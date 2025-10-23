#!/usr/bin/env bash
set -euo pipefail

# flutter_helper.sh (final)
# - Group selection: single keypress (no Enter). Prints selected group message, then shows submenu.
# - Submenu: single keypress (no Enter). No "press any key" pause after running commands.
# - pub add / pub remove still prompt for package name (requires Enter).
# - Banner: ASCII block "FLUTTER HELPER"
# - All printf use constant format string; variables passed as arguments.

# ---------- Colors & Styles ----------
if [ -t 1 ]; then
  BOLD=$(printf '\033[1m')
  DIM=$(printf '\033[2m')
  RESET=$(printf '\033[0m')
  RED=$(printf '\033[31m')
  GREEN=$(printf '\033[32m')
  YELLOW=$(printf '\033[33m')
  BLUE=$(printf '\033[34m')
  MAGENTA=$(printf '\033[35m')
  CYAN=$(printf '\033[36m')
  WHITE=$(printf '\033[37m')
else
  BOLD=""; DIM=""; RESET=""; RED=""; GREEN=""; YELLOW=""; BLUE=""; MAGENTA=""; CYAN=""; WHITE=""
fi

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

# ---------- Config ----------
BASIC="Basic Commands"
BASIC_COMMANDS=(
  "Version"
  "Run Diagnostics"
  "Clean Build"
  "Devices"
  "Emulators"
  "Upgrade Flutter"
)

PUB="Pub Commands"
PUB_COMMANDS=(
  "Fetch Packages"
  "Add Package"
  "Remove Package"
  "Check Outdated Packages"
  "Upgrade Outdated Packages"
  "Repair Cache"
  "Clean Cache"
  "Generate code (build_runner)"
  "Generate localization (intl_utils)"
)

# ---------- Helpers ----------
print_header() {
  printf "%b\n" "${CYAN}============================================================${RESET}"
  printf "%b\n" "${BOLD}${WHITE}               Flutter helper — quick interactive menu${RESET}"
  printf "%b\n" "${CYAN}============================================================${RESET}"
}

print_group_menu() {
  printf "\n"
  printf "%b\n" "${MAGENTA}Select group:${RESET}"
  printf "%b\n" "  ${YELLOW}1)${RESET} ${BOLD}${BASIC}${RESET}"
  printf "%b\n" "  ${YELLOW}2)${RESET} ${BOLD}${PUB}${RESET}"
  printf "%b\n" "  ${YELLOW}e)${RESET} Exit"
}

print_options() {
  local i=1
  for item in "${CURRENT_OPTIONS[@]}"; do
    printf "%b\n" "  ${YELLOW}%2d)${RESET} ${item}" "$i"
    i=$((i+1))
  done
}

run_cmd() {
  printf "%b\n" ""
  printf "%b\n" "${DIM}--------------------------------------------------${RESET}"
  printf "%b\n" "${GREEN}Running:${RESET} %s" "$*"
  printf "%b\n" "${DIM}--------------------------------------------------${RESET}"
  eval "$*"
  rc=$?
  printf "%b\n" "${DIM}--------------------------------------------------${RESET}"
  printf "%b\n" "${BOLD}Return code:${RESET} %d" "$rc"
  printf "%b\n" "${DIM}--------------------------------------------------${RESET}"
  printf "%b\n" ""
}

get_actual_command() {
  local key="$1"
  case "$key" in
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

to_lower() {
  printf '%s' "$1" | tr '[:upper:]' '[:lower:]'
}

# ---------- Sanity check ----------
if ! command -v flutter >/dev/null 2>&1; then
  printf "%b\n" "${RED}Error: 'flutter' command not found. Please install Flutter or add it to PATH.${RESET}"
  exit 1
fi

# ---------- Main ----------
print_banner
echo
print_header

while true; do
  print_group_menu
  printf "%b" "${BLUE}➜ ${RESET}"
  # group selection single key (no Enter)
  read -n1 -r group_choice
  printf "\n"

  # if nothing (Enter), re-show
  if [ -z "${group_choice}" ]; then
    continue
  fi

  group_choice_lc=$(to_lower "$group_choice")

  if [[ "$group_choice_lc" == "e" || "$group_choice_lc" == "q" ]]; then
    printf "%b\n" "${CYAN}Goodbye.${RESET}"
    exit 0
  fi

  case "$group_choice_lc" in
    1)
      CURRENT_OPTIONS=("${BASIC_COMMANDS[@]}")
      CURRENT_GROUP_NAME="$BASIC"
      ;;
    2)
      CURRENT_OPTIONS=("${PUB_COMMANDS[@]}")
      CURRENT_GROUP_NAME="$PUB"
      ;;
    *)
      printf "%b\n" "${RED}Invalid selection.${RESET} Choose 1, 2, or e."
      continue
      ;;
  esac

  printf "\n"
  printf "%b\n" "${BOLD}${WHITE}You selected group:${RESET} ${MAGENTA}%s${RESET}" "$CURRENT_GROUP_NAME"

  # submenu
  while true; do
    printf "\n"
    printf "%b\n" "${CYAN}Available commands:${RESET}"
    # print_options uses printf with format string constant
    local i=1
    for item in "${CURRENT_OPTIONS[@]}"; do
      printf "%b\n" "  ${YELLOW}%2d)${RESET} ${item}" "$i"
      i=$((i+1))
    done

    printf "%b\n" "${BLUE}(press number key, ${YELLOW}b${RESET}${BLUE} to back, ${YELLOW}e${RESET}${BLUE} to exit)${RESET}"
    printf "%b" "${BLUE}➜ ${RESET}"

    read -n1 -r choice
    printf "\n"

    if [ -z "${choice}" ]; then
      continue
    fi

    choice_lc=$(to_lower "$choice")

    if [[ "$choice_lc" == "b" ]]; then
      break
    fi
    if [[ "$choice_lc" == "e" || "$choice_lc" == "q" ]]; then
      printf "%b\n" "${CYAN}Goodbye.${RESET}"
      exit 0
    fi

    if [[ "$choice_lc" =~ ^[0-9]+$ ]]; then
      idx=$((choice_lc - 1))
      if (( idx < 0 || idx >= ${#CURRENT_OPTIONS[@]} )); then
        printf "%b\n" "${RED}Invalid number.${RESET} Try again."
        continue
      fi
      CMD="${CURRENT_OPTIONS[$idx]}"
    else
      printf "%b\n" "${RED}Invalid input.${RESET} Press a number key, 'b' or 'e'."
      continue
    fi

    actual=$(get_actual_command "$CMD")
    if [ -z "$actual" ]; then
      printf "%b\n" "${YELLOW}No mapping found for '%s'${RESET}" "$CMD"
      continue
    fi

    if [[ "$CMD" == "Add Package" || "$CMD" == "Remove Package" ]]; then
      printf "%b" "${YELLOW}Enter package name (e.g. http or provider:^1.0.0): ${RESET}"
      read -r pkg
      if [ -z "${pkg}" ]; then
        printf "%b\n" "${RED}Empty package name. Skipped.${RESET}"
        continue
      fi
      full="$actual $pkg"
      run_cmd "$full"
      continue
    fi

    run_cmd "$actual"
  done
done