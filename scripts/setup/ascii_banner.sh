#!/bin/bash

# ------------------ ASCI BANNER ------------------

COMMUNITY_URL="https://github.com/ahmedali109/FluPilot-CLI"
ISSUE_URL="https://github.com/ahmedali109/FluPilot-CLI/issues"


RED='\033[0;31m'
ORANGE='\033[0;33m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ASCII Art Banner for FluPilot CLI
echo -e "
${RED}   ______   __  _____  ______   ____  ______  _______   ____
${ORANGE}  / __/ /  / / / / _ \\/  _/ /  / __ \\/_  __/ / ___/ /  /  _/
${YELLOW} / _// /__/ /_/ / ___// // /__/ /_/ / / /   / /__/ /___/ /
${GREEN}/_/ /____/\\____/_/  /___/____/\\____/ /_/    \\___/____/___/
${BLUE}
"

# Install confirmation
echo -e "                                                          ${GREEN}....is now installed!${NC}\n"

# Welcome instructions
echo -e "${MAGENTA}Before you scream ${YELLOW}FluPilot CLI!${MAGENTA} make sure to read the docs for usage instructions.${NC}"
echo ""
echo -e "• 💬 Join our community: ${CYAN} $COMMUNITY_URL ${NC}"
echo -e "• 🧰 Feedback & Issues:  ${CYAN} $ISSUE_URL ${NC}"
