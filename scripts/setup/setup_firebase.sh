#!/bin/bash

# ========== CONFIG ==========
set -euo pipefail
IFS=$'\n\t'

# ========== COLORS ==========
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ========== ERROR HANDLING ==========
trap 'echo -e "${RED}❌ An unexpected error occurred. Exiting.${NC}"' ERR

# ========== FUNCTIONS ==========
function command_exists() {
    command -v "$1" >/dev/null 2>&1
}

function install_node() {
    echo -e "${YELLOW}Installing Node.js...${NC}"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if command_exists brew; then
            brew install node
        else
            echo -e "${RED}Homebrew not found. Please install Homebrew or Node.js manually.${NC}"
            exit 1
        fi
    elif [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "cygwin"* || "$OSTYPE" == "win32"* || "$OS" == "Windows_NT" ]]; then
        # Windows
        if command_exists winget; then
            winget install OpenJS.NodeJS -e --accept-package-agreements --accept-source-agreements
        else
            echo -e "${RED}No supported Windows package manager found (winget). Please install Node.js manually from https://nodejs.org/en/download/.${NC}"
            exit 1
        fi
    elif command_exists pacman; then
        sudo pacman -Syu nodejs npm --noconfirm
    elif command_exists apt; then
        curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
        sudo apt install -y nodejs
    elif command_exists dnf; then
        sudo dnf install -y nodejs
    else
        echo -e "${RED}Unsupported package manager or OS. Please install Node.js manually from https://nodejs.org/en/download/.${NC}"
        exit 1
    fi
}

function install_firebase_cli() {
    echo -e "${YELLOW}Installing Firebase CLI globally via npm...${NC}"
    if [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "cygwin"* || "$OSTYPE" == "win32"* || "$OS" == "Windows_NT" ]]; then
        npm install -g firebase-tools
    else
        sudo npm install -g firebase-tools
    fi
}

function activate_flutterfire() {
    echo -e "${YELLOW}Activating FlutterFire CLI...${NC}"
    if ! command_exists dart; then
        echo -e "${RED}Dart SDK is not installed. Please install Dart before continuing.${NC}"
        exit 1
    fi
    dart pub global activate flutterfire_cli
}

function run_flutterfire_configure() {
    if command_exists flutterfire; then
    flutterfire_configure_helper
    else
        echo -e "${RED}flutterfire command not found. Ensure it's in your PATH.${NC}"
        echo "Try adding this to your PATH: $HOME/.pub-cache/bin"
        export PATH="$PATH:$HOME/.pub-cache/bin"
        if command_exists flutterfire; then
            echo -e "${GREEN}flutterfire command found after updating PATH.${NC}"
            flutterfire_configure_helper
        else
            echo -e "${RED}Still couldn't find flutterfire. Try restarting your shell.${NC}"
            exit 1
        fi
    fi
}

function flutterfire_configure_helper(){
  cd "$FLUTTER_PROJECT_DIR" || {
        echo -e "${RED}FLUTTER_PROJECT_DIR is not set or invalid. Please set it to your Flutter project directory.${NC}"
        exit 1
  }
  echo -e "${CYAN}🔧 Running FlutterFire configuration...${NC}"
  echo -e "${YELLOW}This will guide you through configuring Firebase for your Flutter project.${NC}"
  echo -e "${YELLOW}Make sure you have your Firebase project ready and follow the prompts.${NC}"
  echo -e "${YELLOW}If you encounter issues, ensure that the FlutterFire CLI is installed correctly.${NC}"
  flutterfire configure
   echo "🔙 Returning to the original directory..."
   echo
   echo
   cd - >/dev/null || exit 1
}

# ========== SCRIPT EXECUTION ==========

echo -e "${CYAN}🔍 Checking for Node.js...${NC}"
if command_exists node; then
    echo -e "${GREEN}✅ Node.js is installed: $(node -v)${NC}"
else
    echo -e "${RED}❌ Node.js is not installed.${NC}"
    install_node
    echo -e "${GREEN}✅ Node.js installed: $(node -v)${NC}"
fi

echo -e "${CYAN}🔍 Checking for Firebase CLI...${NC}"
if command_exists firebase; then
    echo -e "${GREEN}✅ Firebase CLI is installed: $(firebase --version)${NC}"
else
    echo -e "${RED}❌ Firebase CLI not found.${NC}"
    install_firebase_cli
    echo -e "${GREEN}✅ Firebase CLI installed: $(firebase --version)${NC}"
fi

echo -e "${CYAN}🔐 Logging into Firebase...${NC}"
firebase login || {
    echo -e "${RED}Login failed or was cancelled.${NC}"
    exit 1
}

echo -e "${CYAN}⚙️ Running Firestore initialization...${NC}"
activate_flutterfire
run_flutterfire_configure

echo -e "${GREEN}🎉 All done! Firebase CLI and FlutterFire are ready to use.${NC}"
