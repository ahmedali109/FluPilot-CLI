#!/usr/bin/env bash

if [ -z "$SCRIPT_DIR" ]; then
  SOURCE="${BASH_SOURCE[0]}"
  while [ -h "$SOURCE" ]; do
    DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
  done
  SCRIPT_DIR="$(cd -P "$(dirname "$SOURCE")/../.." && pwd)"
fi

source "$SCRIPT_DIR/templates/gen/app_regex.sh"
source "$SCRIPT_DIR/templates/gen/extensions.sh"
source "$SCRIPT_DIR/templates/gen/spacing.sh"
source "$SCRIPT_DIR/templates/gen/app_strings.sh"
source "$SCRIPT_DIR/templates/gen/theme.sh"

function assistants_files(){
  appRegex
  extensions
  spacing
  appStrings
  themeConfigure
}
