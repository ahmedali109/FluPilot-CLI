#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

# Source pick_dir function from pick_directory.sh
source "$ROOT_DIR/pickers/pick_directory.sh"

# --- Main Flow ---
echo "📁 Select project location:"
project_dir=$(pick_dir)
[ -z "$project_dir" ] && exit 1

# Get project name
while :; do
  PROJECT_NAME=$(gum input --placeholder "Enter your Flutter project name ")

  if [[ $? -ne 0 ]]; then
    echo -e "\n❌ Input canceled by user."
    exit 1
  fi

  if [[ -z "${PROJECT_NAME// /}" ]]; then
    echo "❌ Project name cannot be empty. Please enter a valid name."
    continue
  fi

  if [ -d "$PROJECT_NAME" ]; then
    echo "❌ Project folder '$PROJECT_NAME' already exists. Please enter a different name."
  else
    break
 fi

done

echo
echo
echo "📝 Please enter your Bundle ID."
echo
echo "💡 Why is it important to change the Bundle ID?"
echo "It ensures proper configuration and avoids conflicts when:"
echo "✅ Uploading the app to Google Play"
echo "✅ Integrating with Firebase"
echo "✅ Setting up notifications and alerts"
echo "✅ Managing the backend"
echo "✅ Setting up CI/CD pipelines"
echo

BUNDLE_ID=$(gum input --placeholder "com.example.$PROJECT_NAME")

if [[ -z "${BUNDLE_ID// /}" ]]; then
# Create project
echo "🚀 Creating Flutter project at $project_dir/$PROJECT_NAME..."
(
    echo "Navigate to the project directory"
    cd "$ROOT_DIR" || exit 1
    if flutter create "$project_dir/$PROJECT_NAME"; then
        echo "✅ Success! Project created."
        echo "🧹 Removing unnecessary platforms..."
        rm -rf "$project_dir/$PROJECT_NAME/windows" "$project_dir/$PROJECT_NAME/macos" "$project_dir/$PROJECT_NAME/linux" "$project_dir/$PROJECT_NAME/web"
        cd - >/dev/null || exit 1
    else
        echo "❌ Failed to create project." >&2
        exit 1
    fi
)
else
    echo "🚀 Creating Flutter project at $project_dir/$PROJECT_NAME..."
    (
        echo "Navigate to the project directory"
        cd "$ROOT_DIR" || exit 1
        if flutter create --org "$BUNDLE_ID" "$project_dir/$PROJECT_NAME"; then
            echo "✅ Success! Project created."
            echo "🧹 Removing unnecessary platforms..."
            rm -rf "$project_dir/$PROJECT_NAME/windows" "$project_dir/$PROJECT_NAME/macos" "$project_dir/$PROJECT_NAME/linux" "$project_dir/$PROJECT_NAME/web"
            cd - >/dev/null || exit 1
        else
            echo "❌ Failed to create project." >&2
            exit 1
        fi
    )
fi

export FLUTTER_PROJECT_DIR="$project_dir/$PROJECT_NAME"
