#!/bin/bash

# --- Cross-platform directory picker ---
function pick_dir() {
    case "$OSTYPE" in
        linux*)
            if command -v zenity &>/dev/null; then
                zenity --file-selection --directory --title="Select Flutter project location"
            elif command -v kdialog &>/dev/null; then
                kdialog --getexistingdirectory "$HOME"
            else
                # Fallback: Gum or terminal prompt
                if command -v gum &>/dev/null; then
                    gum input --placeholder "Enter absolute path for project" --prompt "> "
                else
                    read -rp "Enter absolute path for project: " selected_dir
                    echo "$selected_dir"
                fi
            fi
            ;;
        darwin*)
            osascript -e 'POSIX path of (choose folder with prompt "Select Flutter project location")'
            ;;
        msys*|cygwin*)
            powershell -noprofile -command \
                '[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null;
                 $dialog = New-Object System.Windows.Forms.FolderBrowserDialog;
                 $dialog.Description = "Select Flutter project location";
                 $dialog.ShowDialog() | Out-Null;
                 $dialog.SelectedPath;'
            ;;
        *)
            echo "$(pwd)"
            ;;
    esac
}
