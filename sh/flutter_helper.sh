#!/usr/bin/env bash
set -euo pipefail

# flutter_helper.sh — compact & feature-preserving (macOS ready)

# ---------- Colors & Styles ----------
if [ -t 1 ]; then
  BOLD=$'\033[1m'; DIM=$'\033[2m'; RESET=$'\033[0m'
  RED=$'\033[31m'; GREEN=$'\033[32m'; YELLOW=$'\033[33m'; BLUE=$'\033[34m'
  MAGENTA=$'\033[35m'; CYAN=$'\033[36m'; WHITE=$'\033[37m'
else
  BOLD=""; DIM=""; RESET=""; RED=""; GREEN=""; YELLOW=""; BLUE=""; MAGENTA=""; CYAN=""; WHITE=""
fi

# ---------- Banner ----------
print_banner() {
cat <<'BANNER'
                      __
                     / _|
                    | |_ _____  ___   _
                    |  _/ _ \ \/ / | | |
                    | || (_) >  <| |_| |
                    |_| \___/_/\_\\__, |
                                   __/ |
                                  |___/
BANNER
}

# ---------- Configuration ----------
BASIC="Basic Commands"
BASIC_COMMANDS=(
  "Version" "Run Diagnostics" "Clean Build" "Devices" "Emulators" "Upgrade Flutter"
)

PUB="Pub Commands"
PUB_COMMANDS=(
  "Fetch Packages" "Add Package" "Remove Package" "Check Outdated Packages"
  "Upgrade Outdated Packages" "Repair Cache" "Clean Cache"
  "Generate code (build_runner)" "Generate localization (intl_utils)"
)

BUILD_PACKAGES=("api" "resource" "rl_animation" "rl_tool" "main")

# ---------- Utilities ----------
run_cmd() {
  local cmd="$*"
  printf "\n%b\n" "${DIM}--------------------------------------------------${RESET}"
  printf "%sRunning:%s %s\n" "$GREEN" "$RESET" "$cmd"
  printf "%b\n" "${DIM}--------------------------------------------------${RESET}"
  eval "$cmd"
  local rc=$?
  printf "%b\n" "${DIM}--------------------------------------------------${RESET}"
  printf "%sReturn code:%s %d\n" "$BOLD" "$RESET" "$rc"
  printf "%b\n\n" "${DIM}--------------------------------------------------${RESET}"
  return $rc
}

get_actual_command() {
  case "$1" in
    "Version") echo "flutter --version" ;;
    "Run Diagnostics") echo "flutter doctor -v" ;;
    "Clean Build") echo "flutter clean" ;;
    "Devices") echo "flutter devices" ;;
    "Emulators") echo "flutter emulators" ;;
    "Upgrade Flutter") echo "flutter upgrade" ;;
    "Fetch Packages") echo "flutter pub get" ;;
    "Add Package") echo "flutter pub add" ;;
    "Remove Package") echo "flutter pub remove" ;;
    "Check Outdated Packages") echo "flutter pub outdated" ;;
    "Upgrade Outdated Packages") echo "flutter pub upgrade" ;;
    "Repair Cache") echo "flutter pub cache repair" ;;
    "Clean Cache") echo "flutter pub cache clean" ;;
    "Generate code (build_runner)") echo "flutter pub run build_runner build --delete-conflicting-outputs" ;;
    "Generate localization (intl_utils)") echo "flutter pub run intl_utils:generate" ;;
    *) echo "" ;;
  esac
}

to_lower() { printf '%s' "$1" | tr '[:upper:]' '[:lower:]'; }

print_header() {
  printf "%b\n" "${CYAN}============================================================${RESET}"
  printf "%b\n" "${BOLD}${WHITE}               Flutter helper — quick interactive menu${RESET}"
  printf "%b\n" "${CYAN}============================================================${RESET}"
}

print_group_menu() {
  printf "\n%b\n" "${MAGENTA}Select group:${RESET}"
  printf "  ${YELLOW}1)${RESET} ${BOLD}%s${RESET}\n" "$BASIC"
  printf "  ${YELLOW}2)${RESET} ${BOLD}%s${RESET}\n" "$PUB"
  printf "  %se)%s Exit\n" "$YELLOW" "$RESET"
}

# ---------- Sanity check ----------
if ! command -v flutter >/dev/null 2>&1; then
  printf "%b\n" "${RED}Error: 'flutter' command not found. Please install Flutter or add it to PATH.${RESET}"
  exit 1
fi

# ---------- Package selector (w/s, space, enter, b) ----------
redraw_package_selector() {
  local cur=$1; shift
  local -n pkgs=$1; local -n sel=$2
  printf '\033[2J\033[H'
  print_banner
  printf "\n%b\n" "${BOLD}${WHITE}Select packages to run build_runner on:${RESET}"
  printf "%b\n" "${DIM}(Use ${YELLOW}w${RESET}/${YELLOW}s${RESET} to move, ${YELLOW}Space${RESET} to toggle, ${YELLOW}Enter${RESET} to run, ${YELLOW}b${RESET} to cancel)${RESET}"
  printf "\n"
  for i in "${!pkgs[@]}"; do
    local mark="[ ]"
    [ "${sel[i]:-0}" = "1" ] && mark="[x]"
    if [ "$i" -eq "$cur" ]; then
      printf "%b %s ${BOLD}%s${RESET}\n" "${BLUE}➜${RESET}" "$mark" "${pkgs[i]}"
    else
      printf "   %s %s\n" "$mark" "${pkgs[i]}"
    fi
  done
  printf "\n%b" "${BLUE}➜ ${RESET}"
}

package_selector_loop() {
  # returns 0 + SELECTED_PKGS or 1 if cancelled
  local -n pkgList=$1
  local n=${#pkgList[@]}
  local sel; sel=()
  for ((i=0;i<n;i++)); do sel[i]=1; done
  local cur=0

  exec 3</dev/tty 2>/dev/null || { echo "Cannot open /dev/tty"; return 1; }
  printf '\033[?25l'
  trap 'printf "\033[?25h"; printf "\033[2J\033[H"; print_banner; print_header; exec 3<&- 2>/dev/null || true' EXIT

  while true; do
    redraw_package_selector "$cur" pkgList sel
    IFS= read -rsn1 -u 3 key || key=""
    [ -z "$key" ] && key=$'\r'

    if [ "$key" = $'\x1b' ]; then
      IFS= read -rsn3 -t 0.02 -u 3 _ || true
      key=$'\x1b'
    fi

    case "$key" in
      'w'|'W') cur=$(( (cur - 1 + n) % n ));;
      's'|'S') cur=$(( (cur + 1) % n ));;
      ' ') sel[$cur]=$(( 1 - ${sel[$cur]:-1} ));;
      $'\r')
        SELECTED_PKGS=()
        for i in "${!pkgList[@]}"; do
          [ "${sel[i]:-0}" = "1" ] && SELECTED_PKGS+=("${pkgList[i]}")
        done
        trap - EXIT
        printf '\033[?25h'
        printf '\033[2J\033[H'
        exec 3<&- 2>/dev/null || true
        return 0
        ;;
      'b'|'B'|'q'|'Q')
        SELECTED_PKGS=()
        trap - EXIT
        printf '\033[?25h'
        printf '\033[2J\033[H'
        exec 3<&- 2>/dev/null || true
        return 1
        ;;
      *) ;;
    esac
  done
}

# ---------- Main loop ----------
print_banner
echo
print_header

while true; do
  print_group_menu
  printf "%b" "${BLUE}➜ ${RESET}"
  IFS= read -rsn1 group_choice </dev/tty || group_choice=""
  printf "\n"
  [ -z "$group_choice" ] && continue

  gc_lc=$(to_lower "$group_choice")
  if [[ "$gc_lc" == "e" || "$gc_lc" == "q" ]]; then
    printf "%b\n" "${CYAN}Goodbye.${RESET}"
    exit 0
  fi

  case "$gc_lc" in
    1) CURRENT_OPTIONS=("${BASIC_COMMANDS[@]}"); CURRENT_GROUP_NAME="$BASIC" ;;
    2) CURRENT_OPTIONS=("${PUB_COMMANDS[@]}"); CURRENT_GROUP_NAME="$PUB" ;;
    *) printf "%b\n" "${RED}Invalid selection.${RESET} Choose 1, 2, or e."; continue ;;
  esac

  printf "\n%s%sYou selected group:%s %s%s%s\n" "$BOLD" "$WHITE" "$RESET" "$MAGENTA" "$CURRENT_GROUP_NAME" "$RESET"

  while true; do
    printf "\n%b\n" "${CYAN}Available commands:${RESET}"
    for i in "${!CURRENT_OPTIONS[@]}"; do
      printf "  ${YELLOW}%2d)${RESET} %s\n" "$((i+1))" "${CURRENT_OPTIONS[i]}"
    done
    printf "%b\n" "${BLUE}(press number key, ${YELLOW}b${RESET}${BLUE} to back, ${YELLOW}e${RESET}${BLUE} to exit)${RESET}"
    printf "%b" "${BLUE}➜ ${RESET}"
    IFS= read -rsn1 choice </dev/tty || choice=""
    printf "\n"
    [ -z "$choice" ] && continue

    choice_lc=$(to_lower "$choice")
    if [[ "$choice_lc" == "b" ]]; then break; fi
    if [[ "$choice_lc" == "e" || "$choice_lc" == "q" ]]; then printf "%b\n" "${CYAN}Goodbye.${RESET}"; exit 0; fi

    if [[ "$choice_lc" =~ ^[0-9]+$ ]]; then
      idx=$((choice_lc - 1))
      if (( idx < 0 || idx >= ${#CURRENT_OPTIONS[@]} )); then
        printf "%b\n" "${RED}Invalid number.${RESET} Try again." ; continue
      fi
      CMD="${CURRENT_OPTIONS[$idx]}"
    else
      printf "%b\n" "${RED}Invalid input.${RESET} Press a number key, 'b' or 'e'." ; continue
    fi

    actual=$(get_actual_command "$CMD")
    if [ -z "$actual" ]; then
      printf "%b\n" "${YELLOW}No mapping found for '%s'${RESET}" "$CMD"
      continue
    fi

    # build_runner special flow
    if [[ "$CMD" == "Generate code (build_runner)" ]]; then
      if package_selector_loop BUILD_PACKAGES; then
        if [ "${#SELECTED_PKGS[@]}" -eq 0 ]; then
          printf "%b\n" "${YELLOW}No packages selected. Skipping build_runner.${RESET}"
          continue
        fi

        ROOT_DIR="$(pwd)"
        printf "%b\n" "${DIM}--------------------------------------------------${RESET}"
        printf "%sSelected packages:%s %s\n" "$BOLD" "$RESET" "${SELECTED_PKGS[*]}"
        printf "%b\n" "${DIM}--------------------------------------------------${RESET}"

        for pkg in "${SELECTED_PKGS[@]}"; do
          if [[ "$pkg" == "main" || "$pkg" == "." || "$pkg" == "root" ]]; then
            ts=$(date +'%Y-%m-%d %H:%M:%S')
            printf "%b\n" "${DIM}--------------------------------------------------${RESET}"
            printf "%sRunning build_runner in (root):%s %s\n" "$GREEN" "$RESET" "$pkg"
            printf "%sStarted at:%s %s\n" "$BOLD" "$RESET" "$ts"
            printf "%b\n" "${DIM}--------------------------------------------------${RESET}"
            (cd "${ROOT_DIR}" && flutter pub run build_runner build --delete-conflicting-outputs)
          else
            if [ -d "${ROOT_DIR}/${pkg}" ]; then
              ts=$(date +'%Y-%m-%d %H:%M:%S')
              printf "%b\n" "${DIM}--------------------------------------------------${RESET}"
              printf "%sRunning build_runner in:%s %s\n" "$GREEN" "$RESET" "$pkg"
              printf "%sStarted at:%s %s\n" "$BOLD" "$RESET" "$ts"
              printf "%b\n" "${DIM}--------------------------------------------------${RESET}"
              (cd "${ROOT_DIR}/${pkg}" && flutter pub run build_runner build --delete-conflicting-outputs)
            else
              printf "%sSkip, folder not found:%s %s\n" "$YELLOW" "$RESET" "$pkg"
            fi
          fi
        done

        printf "%b\n" "${DIM}================ build_runner completed ================${RESET}"
        cd "${ROOT_DIR}" || true
      else
        printf "%b\n" "${DIM}Cancelled package selection. Returning to menu.${RESET}"
      fi
      continue
    fi

    # Add / Remove package flows prompt user for package name
    if [[ "$CMD" == "Add Package" || "$CMD" == "Remove Package" ]]; then
      printf "%b" "${YELLOW}Enter package name (e.g. http or provider:^1.0.0): ${RESET}"
      read -r pkg
      if [ -z "${pkg}" ]; then
        printf "%b\n" "${RED}Empty package name. Skipped.${RESET}"
        continue
      fi
      run_cmd "$actual $pkg"
      continue
    fi

    run_cmd "$actual"
  done
done