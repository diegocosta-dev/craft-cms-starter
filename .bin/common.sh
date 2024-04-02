#!/bin/bash

# -- GLOBAL Variables --
BASE_PATH=${BASE_PATH:-"./"}
DDEV_PATH=${DDEV_PATH:-".ddev"}
CRAFT_PATH=${CRAFT_PATH:-"cms"}
SRC_PATH=${SRC_PATH:-"src"}
GITHUB_PATH=${GITHUB_PATH:-".github"}
DEFAULT_SITE_NAME=${DEFAULT_SITE_NAME:-"Dative Boilerplate"}
ADMIN_USERNAME=${ADMIN_USERNAME:-"info@hellodative.com"}
TASKS_DIR=${TASKS_DIR:-".bin"}
SCRIPT_OUTPUT=${SCRIPT_OUTPUT:-}
STAGED_NAME=${STAGED_NAME:-"staged-project"}

# -- Functions --

print_style() {
  if [ "$2" == "info" ]; then
    COLOR="34m"
  elif [ "$2" == "success" ]; then
    COLOR="32m"
  elif [ "$2" == "warning" ]; then
    COLOR="33m"
  elif [ "$2" == "danger" ]; then
    COLOR="31m"
  else #default color
    COLOR="0m"
  fi

  STARTCOLOR="\e[$COLOR"
  ENDCOLOR="\e[0m"

  printf "$STARTCOLOR%b$ENDCOLOR" "$1"
}

raise() {
  print_style "$1" "$2" >&2
}

get_arg_value() {
  if [ -z "$1" ]; then
    raise "Error: arg_name parameter is required."
    return 1
  fi

  arg_name="$1"
  args_string="$2"

  arg_value=$(echo "$args_string" | tr ' ' '\n' | grep "^$arg_name=" | sed "s/^$arg_name=//")
  echo "$arg_value"
}

remove_from_args() {
  arg_name="$1"
  args_string="$2"
  new_args_string=""
  for arg in $args_string; do
    case "$arg" in
    "$arg_name="*)
      # Do not add the argument to the new_args_string
      ;;
    "$arg_name")
      # Do not add the argument to the new_args_string
      ;;
    *)
      new_args_string="$new_args_string $arg"
      ;;
    esac
  done
  echo "${new_args_string# }" # Remove leading space
}

check_if_args_unique() {
  if [ -z "$1" ]; then
    return 0
  fi

  local args_list
  local args_option_names
  local duplicates

  args_list=$(echo "$1" | tr ' ' '\n' | sort)
  # get the option names
  args_option_names=$(echo "$args_list" | cut -d '=' -f 1)
  # get the duplicate names
  duplicates=$(echo "$args_option_names" | uniq -d)
  if [ -n "$duplicates" ]; then
    raise "Error: Duplicate options found: $duplicates"
    return 1
  fi
}

check_required_environment() {
  local required_env="$1"

  for reqvar in $required_env; do
    if [ -z "${!reqvar}" ]; then
      raise "missing ENVIRONMENT ${reqvar}!"
      return 1
    fi
  done
}

check_required_ddev_command() {
  if ! command -v ddev >/dev/null 2>&1; then
    raise "DDEV not found. Please install DDEV first."
    return 1
  fi
}

ddev_up() {
  if [ ! "$(ddev describe | grep OK)" ]; then
    ddev start
  else
    printf "\033[34mDDEV is already running.\033[0m\n"
  fi
}

add_to_summary() {
  # [ -z "$SCRIPT_OUTPUT" ] && echo "Empty" || echo "Not empty"
  if [ -z "$SCRIPT_OUTPUT" ]; then
    SCRIPT_OUTPUT="$1"
  else
    SCRIPT_OUTPUT="$SCRIPT_OUTPUT\n$1"
  fi
}

print_summary() {
  if [ -n "$SCRIPT_OUTPUT" ]; then
    FINAL_OUTPUT=$(printf "%b" "$SCRIPT_OUTPUT" | sed 's/^/    /' | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" | fmt -w 76)
    BORDER=$(printf '%.0s*' {1..80})
    print_style "\n$BORDER\n\n" "$1"
    print_style "${FINAL_OUTPUT}" "$1"
    print_style "\n\n$BORDER\n\n" "$1"
  fi
}
