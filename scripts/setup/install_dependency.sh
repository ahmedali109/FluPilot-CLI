#!/bin/bash
# Cross-platform dependency installer for gum, flutter, python3
set -euo pipefail

dep="$1"

case $dep in
  gum)
    echo "Installing gum..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
      if command -v brew &>/dev/null; then
        echo "Attempting to install gum using Homebrew..."
        brew install gum || { echo "Failed to install gum."; exit 1; }
      else
        echo "Homebrew not found. Installing Homebrew first..."
        echo "Attempting to install Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || { echo "Failed to install Homebrew."; exit 1; }
        echo "Attempting to install gum using Homebrew..."
        brew install gum || { echo "Failed to install gum after installing Homebrew."; exit 1; }
      fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
      if command -v apt &>/dev/null; then
        echo "Attempting to install gum using apt..."
        sudo apt update && sudo apt install -y gum || { echo "Failed to install gum."; exit 1; }
      elif command -v dnf &>/dev/null; then
        echo "Attempting to install gum using dnf..."
        sudo dnf install -y gum || { echo "Failed to install gum."; exit 1; }
      elif command -v pacman &>/dev/null; then
        echo "Attempting to install gum using pacman..."
        sudo pacman -Sy gum || { echo "Failed to install gum."; exit 1; }
      else
        echo "Please install gum manually: https://github.com/charmbracelet/gum"
        exit 1
      fi
    elif [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "win32"* || "$OS" == "Windows_NT" ]]; then
      if command -v scoop &>/dev/null; then
        echo "Attempting to install gum using Scoop..."
        scoop install gum || { echo "Failed to install gum with Scoop."; exit 1; }
      else
        echo "Scoop not found. Installing Scoop first..."
        powershell -Command "Set-ExecutionPolicy RemoteSigned -scope CurrentUser; iwr -useb get.scoop.sh | iex" || { echo "Failed to install Scoop."; exit 1; }
        echo "Attempting to install gum using Scoop..."
        scoop install gum || { echo "Failed to install gum with Scoop after installing Scoop."; exit 1; }
      fi
    else
      echo "Unsupported OS: $OSTYPE"
      echo "Please install gum manually: https://github.com/charmbracelet/gum"
      exit 1
    fi
    ;;
  python3)
    echo "Installing python3..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
      if command -v brew &>/dev/null; then
        echo "Attempting to install python3 using Homebrew..."
        brew install python || { echo "Failed to install python3."; exit 1; }
      else
        echo "Homebrew not found. Installing Homebrew first..."
        echo "Attempting to install Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || { echo "Failed to install Homebrew."; exit 1; }
        echo "Attempting to install python3 using Homebrew..."
        brew install python || { echo "Failed to install python3 after installing Homebrew."; exit 1; }
      fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
      if command -v apt &>/dev/null; then
        echo "Attempting to install python3 using apt..."
        sudo apt update && sudo apt install -y python3 || { echo "Failed to install python3."; exit 1; }
      elif command -v dnf &>/dev/null; then
        echo "Attempting to install python3 using dnf..."
        sudo dnf install -y python3 || { echo "Failed to install python3."; exit 1; }
      elif command -v pacman &>/dev/null; then
        echo "Attempting to install python3 using pacman..."
        sudo pacman -Sy python || { echo "Failed to install python3."; exit 1; }
      else
        echo "Unsupported Linux distribution. Please install python3 manually: https://www.python.org/downloads/"
        echo "Please install python3 manually: https://www.python.org/downloads/"
        exit 1
      fi
    elif [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "win32"* || "$OS" == "Windows_NT" ]]; then
      if command -v scoop &>/dev/null; then
        echo "Attempting to install python3 using Scoop..."
        scoop install python || { echo "Failed to install python3 with Scoop."; exit 1; }
      else
        echo "Scoop not found. Installing Scoop first..."
        echo "Attempting to install Scoop..."
        powershell -Command "Set-ExecutionPolicy RemoteSigned -scope CurrentUser; iwr -useb get.scoop.sh | iex" || { echo "Failed to install Scoop."; exit 1; }
        echo "Attempting to install python3 using Scoop..."
        scoop install python || { echo "Failed to install python3 with Scoop after installing Scoop."; exit 1; }
      fi
    else
      echo "Unsupported OS: $OSTYPE"
      echo "Please install python3 manually: https://www.python.org/downloads/"
      exit 1
    fi
    ;;
  *)
    echo "Unknown dependency: $dep please tell us for support."
    echo "Exiting..."
    exit 1
    ;;
esac
