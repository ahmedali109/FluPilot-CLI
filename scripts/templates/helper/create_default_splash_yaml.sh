#!/bin/bash
# Cross-platform helper to generate a default flutter_native_splash.yaml in the Flutter project directory

function create_default_splash_yaml() {
  DEST_DIR="${FLUTTER_PROJECT_DIR}"
  SPLASH_FILE="$DEST_DIR/flutter_native_splash.yaml"

  cat <<EOL > "$SPLASH_FILE"
flutter_native_splash:
  # This package generates native code to customize Flutter's default white native splash screen
  # with background color and splash image.
  # Customize the parameters below, and run the following command in the terminal:
  # dart run flutter_native_splash:create
  # To restore Flutter's default white splash screen, run the following command in the terminal:
  # dart run flutter_native_splash:remove

  # IMPORTANT NOTE: These parameter do not affect the configuration of Android 12 and later, which
  # handle splash screens differently that prior versions of Android.  Android 12 and later must be
  # configured specifically in the android_12 section below.

  # color or background_image is the only required parameter.  Use color to set the background
  # of your splash screen to a solid color.  Use background_image to set the background of your
  # splash screen to a png image.  This is useful for gradients. The image will be stretch to the
  # size of the app. Only one parameter can be used, color and background_image cannot both be set.

  # background_image: assets/images/splash_background_image_light.png
  # background_image_dark: assets/images/splash_background_image_dark.png
  image: assets/images/splash_background_image_light.png
  image_dark: assets/images/splash_background_image_dark.png
  color: "#F1EFE7"
  color_dark: "#0F1629"
  # branding: assets/images/splash_branding_light_theme.png
  # branding_dark: assets/images/splash_branding_dark_theme.png

  android_12:
    image: assets/images/android_12_splash_background_image_light.png
    image_dark: assets/images/android_12_splash_splash_background_image_dark.png
    color: "#F1EFE7"
    color_dark: "#0F1629"
    # branding: assets/images/splash_branding_light_theme.png
    # branding_dark: assets/images/splash_branding_dark_theme.png
EOL

  echo "✅ Created default flutter_native_splash.yaml in $DEST_DIR"
}

# Export the function for use in other scripts
export -f create_default_splash_yaml
