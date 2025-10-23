#!/usr/bin/env bash
set -euo pipefail

# === Configuration ===
BASIC="basic"
BASIC_COMMANDS=(
  "version"
  "doctor"
  "clean"
  "devices"
  "emulators"
)

PUB="pub"
PUB_COMMANDS=(
  "pub get"
  "pub add"
  "pub remove"
  "pub outdated"
  "pub upgrade"
  "cache repair"
  "cache clean"
  "build_runner"
  "intl_utils"
)

# Print header
print_header() {
  echo
  echo "======================================"
  echo " Flutter helper menu"
  echo "======================================"
}

confirm_command() {
  read -r -p "Confirm execute? [y/N]: " yn

  # portable lowercase for older bash
  yn_lc=$(printf '%s' "$yn" | tr '[:upper:]' '[:lower:]')

  case "$yn_lc" in
    y|yes)
      echo "=== Running ==="
      eval "$cmd"
      echo "=== Done ==="
      ;;
    *)
      echo "Skipped."
      ;;
  esac
}

just_run() {
  echo "=== Running ==="
  eval "$cmd"
  echo "=== Done ==="
}


# Run command (no extra args, runs immediately)
run_command() {
  local cmd="$1"
  echo
  echo "Command to run: $cmd"
  just_run
}

# portable lowercase helper
to_lower() {
  printf '%s' "$1" | tr '[:upper:]' '[:lower:]'
}

# Map logical command -> actual shell command (no associative arrays)
get_actual_command() {
  local key="$1"
  case "$key" in
    "version") echo "flutter --version" ;;
    "doctor") echo "flutter doctor -v" ;;
    "clean") echo "flutter clean" ;;
    "devices") echo "flutter devices" ;;
    "emulators") echo "flutter emulators" ;;

    "pub get") echo "flutter pub get" ;;
    "pub add") echo "flutter pub add" ;;
    "pub remove") echo "flutter pub remove" ;;
    "pub outdated") echo "flutter pub outdated" ;;
    "pub upgrade") echo "flutter pub upgrade" ;;
    "cache repair") echo "flutter pub cache repair" ;;
    "cache clean") echo "flutter pub cache clean" ;;
    "build_runner") echo "flutter pub run build_runner build --delete-conflicting-outputs" ;;
    "intl_utils") echo "flutter pub run intl_utils:generate" ;;
    *) echo "" ;; # unknown
  esac
}

# Print numbered options using CURRENT_OPTIONS global (compatible with bash 3)
print_options() {
  local i=1
  for item in "${CURRENT_OPTIONS[@]}"; do
    printf "%2d) %s\n" "$i" "$item"
    i=$((i+1))
  done
}

# Main loop
while true; do
  print_header
  echo "Select group:"
  echo " 1) $BASIC"
  echo " 2) $PUB"
  echo " e) exit"
  printf "> "
  read -r group_choice
  group_choice_lc=$(to_lower "$group_choice")

  if [[ "$group_choice_lc" == "e" || "$group_choice_lc" == "q" ]]; then
    echo "Exit."
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
      echo "Invalid selection. Choose 1, 2, or e."
      continue
      ;;
  esac

  # Sub-menu loop: remain here until user presses 'b' (back) or 'e' (exit)
  while true; do
    echo
    echo "You selected group: $CURRENT_GROUP_NAME"
    echo "Select command:"
    print_options
    printf "(enter number, 'b' to back, 'e' to exit) > "
    read -r choice
    choice_lc=$(to_lower "$choice")

    if [[ "$choice_lc" == "b" ]]; then
      # go back to group selection
      break
    fi
    if [[ "$choice_lc" == "e" || "$choice_lc" == "q" ]]; then
      echo "Exit."
      exit 0
    fi

    # check if numeric
    if [[ "$choice_lc" =~ ^[0-9]+$ ]]; then
      idx=$((choice_lc - 1))
      if (( idx < 0 || idx >= ${#CURRENT_OPTIONS[@]} )); then
        echo "Invalid number. Try again."
        continue
      fi
      CMD="${CURRENT_OPTIONS[$idx]}"
    else
      echo "Invalid input. Enter a number, 'b' or 'e'."
      continue
    fi

    # get actual command
    actual=$(get_actual_command "$CMD")
    if [[ -z "$actual" ]]; then
      echo "No mapping found for '$CMD'"
      continue
    fi

    # special for pub add / pub remove: need package name
    if [[ "$CMD" == "pub add" || "$CMD" == "pub remove" ]]; then
      read -r -p "Enter package name (e.g. http or provider:^1.0.0): " pkg
      if [[ -z "$pkg" ]]; then
        echo "Empty package name. Skipped."
        continue
      fi
      full="$actual $pkg"
      run_command "$full"
      # after running, stay in this submenu
      continue
    fi

    # for all other commands just run the mapped command and stay in this submenu
    run_command "$actual"
    # loop continues, staying in same submenu until user types 'b'
  done
done
