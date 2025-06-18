#!/usr/bin/env bash

source ./scripts/utils/styles/gum_select_style.sh

IDE_CHOICE_OPEN=$(gum choose "${GUM_SELECTED_STYLE[@]}" "vscode" "Android Studio" --header="🛠️ Choose an editor to open your Flutter project:")

case "$IDE_CHOICE_OPEN" in
  "vscode")
    if command -v code &> /dev/null; then
      echo "🚀 Opening project in VS Code..."
      code $FLUTTER_PROJECT_DIR
    else
      echo "❌ VS Code is not installed or 'code' command not found."
      echo "👉 Run 'Shell Command: Install 'code' command in PATH' from Command Palette in VS Code."
    fi
    ;;

  "Android Studio")
    echo "🚀 Opening project in Android Studio..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
      open -a "Android Studio" $FLUTTER_PROJECT_DIR
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
      if command -v studio &> /dev/null; then
        studio $FLUTTER_PROJECT_DIR
      elif command -v android-studio &> /dev/null; then
        android-studio $FLUTTER_PROJECT_DIR
      else
        echo "❌ Android Studio command-line launcher not found."
        echo "👉 Open Android Studio > Tools > Create Command-Line Launcher"
      fi
    elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
      if [[ -f "/c/Program Files/Android/Android Studio/bin/studio64.exe" ]]; then
        "/c/Program Files/Android/Android Studio/bin/studio64.exe" "$FLUTTER_PROJECT_DIR"
      else
        echo "❌ Android Studio executable not found."
      fi
    else
      echo "❌ Unsupported OS: $OSTYPE"
    fi
    ;;

  *)
    echo "❌ Invalid option."
    ;;
esac
