#!/usr/bin/env bash
set -euo pipefail

# helper.sh
# Usage: bash helper.sh

# Check flutter sdk valid
if ! command -v flutter >/dev/null 2>&1; then
  echo "Error: 'flutter' command not found. Please install Flutter or add it to PATH."
  exit 1
fi

run_cmd() {
  echo
  echo "--------------------------------------------------"
  echo "Running: $*"
  echo "--------------------------------------------------"
  eval "$*"
  echo "Return code: $?"
  echo "--------------------------------------------------"
  echo
}

show_menu() {
  cat <<EOF

Select an option:
  1) Fetch packages
  2) Clean cache
  3) Repair cache
  4) Run diagnostics
  5) Clean build
  6) Generate code (build_runner)
  7) Generate localization (intl_utils)
  q) Quit

EOF
}

execute_choice() {
  case "$1" in
    1)
      run_cmd "flutter pub get"
      ;;
    2)
      run_cmd "flutter pub cache clean"
      ;;
    3)
      run_cmd "flutter pub cache repair"
      ;;
    4)
      run_cmd "flutter doctor -v"
      ;;
    5)
      run_cmd "flutter clean"
      ;;
    6)
      run_cmd "flutter pub run build_runner build --delete-conflicting-outputs"
      ;;
    7)
      run_cmd "flutter pub run intl_utils:generate"
      ;;
    q|Q)
      echo "Bye."
      exit 0
      ;;
    *)
      echo "Invalid option: $1"
      return 1
      ;;
  esac
}

# Interactive menu loop: use read -n1 so Enter is not required
while true; do
  show_menu
  # -n1: read 1 character; -r: raw (do not process backslashes)
  # Do not use -s because we want the pressed key to be shown
  read -n1 -r -p "Press choice key: " CHOICE
  # print a newline because read -n1 does not move the cursor to a new line automatically
  printf "\n"

  # if user pressed just Enter (CHOICE empty) => continue loop
  if [ -z "${CHOICE}" ]; then
    continue
  fi

  # process the choice
  if execute_choice "$CHOICE"; then
    # allow the user to see the result before returning to the menu
    # prompt and wait for one key (no Enter needed)
    read -n1 -r -p "Press any key to continue..." _tmp
    printf "\n"
  else
    # if invalid input, show message and continue (do not exit)
    read -n1 -r -p "Invalid option. Press any key to try again..." _tmp
    printf "\n"
  fi
done
