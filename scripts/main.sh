#!/usr/bin/env bash

# Get the absolute path to the real script location, resolving symlinks
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
SCRIPT_DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"

#Show ASCII BANNER
source "$SCRIPT_DIR/setup/ascii_banner.sh"

#Create Flutter project
source "$SCRIPT_DIR/setup/init_flutter_project.sh"

#Choose form package manager
source "$SCRIPT_DIR/setup/select_packages.sh"

#Add packages and dependencies
source "$SCRIPT_DIR/setup/add_packages.sh"

#Generate templates
source "$SCRIPT_DIR/templates/main_template.sh"

#Choose IDE to open
source "$SCRIPT_DIR/pickers/pick_ide.sh"
