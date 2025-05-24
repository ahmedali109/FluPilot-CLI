#!/bin/bash

#Show ASCII BANNER
source ./scripts/setup/ascii_banner.sh

#Create Flutter project
source ./scripts/setup/init_flutter_project.sh

#Choose form package manager
source ./scripts/setup/select_packages.sh

#Add packages and dependencies
source ./scripts/setup/add_packages.sh

#Generate templates
source ./scripts/templates/main_template.sh

#Choose IDE to open
source ./scripts/pickers/pick_ide.sh
