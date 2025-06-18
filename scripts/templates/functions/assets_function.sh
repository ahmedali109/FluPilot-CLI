#!/usr/bin/env bash

source ./scripts/pickers/pick_image.sh

function assets_function(){

  DEST_DIR="${FLUTTER_PROJECT_DIR}/assets"
  echo "📂 Creating assets directory at ${DEST_DIR}..."
  mkdir -p "${DEST_DIR}/images"
  mkdir -p "${DEST_DIR}/icons"

  image_paths="$(pick_img)"

  # Convert image_paths (semicolon-separated) to array
  IFS=';' read -ra FILE_ARRAY <<< "$image_paths"

  # Exit if no files selected
  if [[ -z "$image_paths" ]]; then
    echo "No images selected. Exiting."
    exit 1
  fi

  # Copy selected images to the destination directory
  for img in "${FILE_ARRAY[@]}"; do
    if [[ "$img" == *.svg ]]; then
      cp "$img" "${DEST_DIR}/icons/"
    else
      cp "$img" "${DEST_DIR}/images/"
    fi
  done

  echo "✅ Successfully copied images to ${DEST_DIR}/images/"
  echo "✅ Successfully copied images to ${DEST_DIR}/icons/"
  echo "📝 Updating pubspec.yaml to include assets..."

  source ./scripts/templates/helper/add_assets_yaml.sh

  if [[ $? -ne 0 ]]; then
    echo "❌ Failed to update pubspec.yaml"
    exit 1
  fi

  echo "✅ pubspec.yaml updated successfully."
  echo "📦 Running flutter pub get to update dependencies..."
  (cd "$FLUTTER_PROJECT_DIR" && flutter pub get)
  echo "✅ Dependencies updated successfully."
  echo "🎉 Assets setup completed successfully!"
  echo "You can now use the assets in your Flutter project."
  echo
  echo
}

# Function to generate the app icon
export -f assets_function
