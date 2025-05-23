#!/bin/bash
# Cross-platform dependency installer for gum, flutter, python3
set -euo pipefail

function install_gum_using_homebrew(){
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
}

function install_gum_using_winget(){
  if command -v winget &>/dev/null; then
        echo "Attempting to install gum using winget..."
        winget install charmbracelet.gum || { echo "Failed to install gum with winget."; exit 1; }
      else
        echo "winget not found. Installing winget first..."
        powershell -Command "Set-ExecutionPolicy RemoteSigned -scope CurrentUser; iwr -useb get.scoop.sh | iex" || { echo "Failed to install winget."; exit 1; }
        echo "Attempting to install gum using winget..."
        winget install charmbracelet.gum || { echo "Failed to install gum with winget after installing winget."; exit 1; }
  fi
}

function install_python_using_homebrew(){
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
}

function install_python_using_winget() {
  if command -v winget &>/dev/null; then
    echo "Attempting to install Python 3.13 using winget..."

    # Use the correct package ID and source
    winget install --id Python.Python.3.13 --exact --source winget || {
      echo "Failed to install Python 3.13 with winget."
      exit 1
    }

  else
    echo "winget not found. Please install winget from the Microsoft Store or GitHub."
    exit 1
  fi
}


dep="$1"

case $dep in
  gum)
    echo "Installing gum..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        install_gum_using_homebrew
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        install_gum_using_homebrew
    elif [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "win32"* || "$OS" == "Windows_NT" ]]; then
        install_gum_using_winget
    else
      echo "Unsupported OS: $OSTYPE"
      echo "Please install gum manually: https://github.com/charmbracelet/gum"
      exit 1
    fi
    ;;
  flutter)
     echo "Flutter is not installed"
     echo "Please install flutter manually and re-run the script: https://flutter.dev/docs/get-started/install"
     exit 1
    ;;
  python3|python)
    echo "Installing python..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        install_python_using_homebrew
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        install_python_using_homebrew
    elif [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "win32"* || "$OS" == "Windows_NT" ]]; then
        install_python_using_winget
    else
      echo "Unsupported OS: $OSTYPE"
      echo "Please install python manually: https://www.python.org/downloads/"
      exit 1
    fi
    ;;
  *)
    echo "Unknown dependency: $dep please tell us to add it."
    echo "https://github.com/yourusername/yourrepository/issues"
    exit 1
    ;;
esac
