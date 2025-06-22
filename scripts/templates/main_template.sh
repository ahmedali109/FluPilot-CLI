#!/usr/bin/env bash

# Get the absolute path to the real script location, resolving symlinks
# If SCRIPT_DIR is already set (from parent script), use that instead
if [ -z "$SCRIPT_DIR" ]; then
  SOURCE="${BASH_SOURCE[0]}"
  while [ -h "$SOURCE" ]; do
    DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
  done
  SCRIPT_DIR="$(cd -P "$(dirname "$SOURCE")/../.." && pwd)"
fi

# Generate Templates
source "$SCRIPT_DIR/utils/styles/gum_choose_style.sh"
source "$SCRIPT_DIR/templates/functions/assets_function.sh"
source "$SCRIPT_DIR/templates/functions/app_icon_function.sh"
source "$SCRIPT_DIR/templates/functions/splash_function.sh"
source "$SCRIPT_DIR/templates/functions/onBoarding_function.sh"
source "$SCRIPT_DIR/templates/functions/slidable_function.sh"
source "$SCRIPT_DIR/templates/functions/pull_to_refresh.sh"
source "$SCRIPT_DIR/templates/functions/actionSlider.sh"
source "$SCRIPT_DIR/templates/functions/googleNavBar.sh"
source "$SCRIPT_DIR/templates/functions/imagePicker.sh"
source "$SCRIPT_DIR/templates/functions/audioPlayers.sh"
source "$SCRIPT_DIR/templates/functions/videoPlayers.sh"
source "$SCRIPT_DIR/templates/functions/goRouter.sh"
source "$SCRIPT_DIR/templates/functions/flutterBloc.sh"
source "$SCRIPT_DIR/templates/functions/http.sh"
source "$SCRIPT_DIR/templates/functions/dio.sh"
source "$SCRIPT_DIR/templates/functions/retrofit.sh"
source "$SCRIPT_DIR/templates/functions/cached_network_image.sh"
source "$SCRIPT_DIR/templates/functions/connectivity_plus.sh"
source "$SCRIPT_DIR/templates/functions/internet_connection_checker.sh"
source "$SCRIPT_DIR/templates/functions/internet_connection_checker_plus.sh"
source "$SCRIPT_DIR/templates/functions/json_serializable.sh"
source "$SCRIPT_DIR/templates/functions/freezed.sh"
source "$SCRIPT_DIR/templates/functions/get_it.sh"
source "$SCRIPT_DIR/templates/functions/shared_preferences.sh"
source "$SCRIPT_DIR/templates/gen/app_regex.sh"
source "$SCRIPT_DIR/templates/gen/extensions.sh"
source "$SCRIPT_DIR/templates/gen/spacing.sh"
source "$SCRIPT_DIR/templates/gen/app_strings.sh"
source "$SCRIPT_DIR/templates/gen/theme.sh"
source "$SCRIPT_DIR/templates/functions/cloud_firestore.sh"
source "$SCRIPT_DIR/templates/functions/supabase_service.sh"
source "$SCRIPT_DIR/templates/functions/local_auth.sh"
source "$SCRIPT_DIR/templates/functions/easy_localization.sh"
source "$SCRIPT_DIR/templates/functions/flutter_local_notifications.sh"
source "$SCRIPT_DIR/templates/permission/ios/google_sign_in_permission.sh"

if [ "${#SELECTED_PACKAGES[@]}" -ne 0 ]; then
  if gum confirm "${GUM_CONFIRM_STYLE[@]}" "🧰 Generate basic templates for selected packages?"; then

      for package in "${SELECTED_PACKAGES[@]}"; do
        echo "Selected package: $package"
      done

      contains() {
        local e match="$1"
        shift
        for e; do [[ "$e" == "$match" ]] && return 0; done
        return 1
      }

      if gum confirm "${GUM_CONFIRM_STYLE[@]}" "🧰 Adding your own Projects Assets?"; then
      assets_function
      else
        echo "⚠️ Creating Assets Directory"
        mkdir -p "$FLUTTER_PROJECT_DIR/assets/images"
        mkdir -p "$FLUTTER_PROJECT_DIR/assets/icons"
        # check if flutter launcher icons is selected
        if contains "flutter_launcher_icons" "${SELECTED_PACKAGES[@]}"; then
          cp "$SCRIPT_DIR/templates/assets/images/app-icon.png" "${FLUTTER_PROJECT_DIR}/assets/images/"
          cp "$SCRIPT_DIR/templates/assets/images/app-icon-android.png" "${FLUTTER_PROJECT_DIR}/assets/images/"
          cp "$SCRIPT_DIR/templates/assets/images/app-icon-foreground.png" "${FLUTTER_PROJECT_DIR}/assets/images/"
          cp "$SCRIPT_DIR/templates/assets/images/app-icon-background.png" "${FLUTTER_PROJECT_DIR}/assets/images/"
          echo "🛠️ Assets for flutter_launcher_icons added."
        fi
        # check if flutter native splash is selected
        if contains "flutter_native_splash" "${SELECTED_PACKAGES[@]}"; then
          cp "$SCRIPT_DIR/templates/assets/images/splash_background_image_light.png" "${FLUTTER_PROJECT_DIR}/assets/images/"
          cp "$SCRIPT_DIR/templates/assets/images/splash_background_image_dark.png" "${FLUTTER_PROJECT_DIR}/assets/images/"
          cp "$SCRIPT_DIR/templates/assets/images/android_12_splash_background_image_light.png" "${FLUTTER_PROJECT_DIR}/assets/images/"
          cp "$SCRIPT_DIR/templates/assets/images/android_12_splash_splash_background_image_dark.png" "${FLUTTER_PROJECT_DIR}/assets/images/"
          echo "🛠️ Assets for flutter_native_splash added."
        fi
        # Add Assets into pubspec.yaml
        echo "🛠️ Adding assets to pubspec.yaml..."
        source "$SCRIPT_DIR/templates/helper/add_assets_yaml.sh"
      fi

      echo "🛠️ Generating templates for selected packages..."

      should_run_build_runner=false

      if contains "flutter_launcher_icons" "${SELECTED_PACKAGES[@]}"; then
        app_icon_function
      fi

      if contains "flutter_native_splash" "${SELECTED_PACKAGES[@]}"; then
        splash_function
      fi

      if contains "introduction_screen" "${SELECTED_PACKAGES[@]}"; then
        onBoarding_function
      fi

      if contains "flutter_slidable" "${SELECTED_PACKAGES[@]}"; then
        SlidableFunction
      fi

      if contains "liquid_pull_to_refresh" "${SELECTED_PACKAGES[@]}"; then
        pullToRefresh
      fi

      if contains "action_slider" "${SELECTED_PACKAGES[@]}"; then
        actionSlider
      fi

      if contains "google_nav_bar" "${SELECTED_PACKAGES[@]}"; then
        googleNavBar
      fi

      if contains "image_picker" "${SELECTED_PACKAGES[@]}"; then
        imagePicker
      fi

      if contains "audioplayers" "${SELECTED_PACKAGES[@]}"; then
        audioPlayers
      fi

      if contains "video_player" "${SELECTED_PACKAGES[@]}"; then
        videoPlayers
      fi

      if contains "go_router" "${SELECTED_PACKAGES[@]}"; then
        goRouter
      fi

      if contains "flutter_bloc" "${SELECTED_PACKAGES[@]}"; then
        if gum confirm "${GUM_CONFIRM_STYLE[@]}" "🧰 Do You Want to Create Cubit ?"; then
          flutterBloc
        fi
      fi

      if contains "http" "${SELECTED_PACKAGES[@]}"; then
        http
      fi

      if contains "dio" "${SELECTED_PACKAGES[@]}"; then
        dio
      fi

      if contains "retrofit" "${SELECTED_PACKAGES[@]}"; then
        retrofit
        should_run_build_runner=true
      fi

      if contains "cached_network_image" "${SELECTED_PACKAGES[@]}"; then
        cached_network_image
      fi

      if contains "connectivity_plus" "${SELECTED_PACKAGES[@]}"; then
        connectivity_plus
      fi

      if contains "internet_connection_checker" "${SELECTED_PACKAGES[@]}"; then
        internet_connection_checker
      fi

      if contains "internet_connection_checker_plus" "${SELECTED_PACKAGES[@]}"; then
        internet_connection_checker_plus
      fi

      if contains "json_serializable" "${SELECTED_PACKAGES[@]}"; then
        json_serializable
        should_run_build_runner=true
      fi

      if contains "freezed" "${SELECTED_PACKAGES[@]}"; then
        freezed
        should_run_build_runner=true
      fi

      if contains "get_it" "${SELECTED_PACKAGES[@]}"; then
        get_it
      fi

      if contains "shared_preferences" "${SELECTED_PACKAGES[@]}"; then
        shared_preferences
      fi

      appRegex
      extensions
      spacing
      appStrings
      themeConfigure

      if contains "firebase_core" "${SELECTED_PACKAGES[@]}"; then
        if gum confirm "${GUM_CONFIRM_STYLE[@]}" "🧩 Run Firebase setup?"; then
          source "$SCRIPT_DIR/setup/setup_firebase.sh"
          if [ $? -ne 0 ]; then
            echo "❌ Firebase setup failed. Please check the output for errors."
            exit 1
          fi
          echo "✅ Firebase setup completed successfully."
        fi
      fi

      if contains "firebase_auth" "${SELECTED_PACKAGES[@]}"; then
        if gum confirm "${GUM_CONFIRM_STYLE[@]}" "🧩 Run Firebase Auth setup?"; then
          source "$SCRIPT_DIR/templates/features/auth/create_auth_structure.sh"

          if [ $? -ne 0 ]; then
            echo "❌ Firebase Auth setup failed. Please check the output for errors."
            exit 1
          fi
          echo "🛠️ Running build_runner for Firebase Auth..."
          should_run_build_runner=true
          echo "✅ Firebase Auth setup completed successfully."
        fi
      fi

      if contains "cloud_firestore" "${SELECTED_PACKAGES[@]}"; then
        if gum confirm "${GUM_CONFIRM_STYLE[@]}" "🧩 Run Cloud Firestore setup?"; then
          cloud_firestore
          if [ $? -ne 0 ]; then
            echo "❌ Cloud Firestore setup failed. Please check the output for errors."
            exit 1
          fi
          echo "✅ Cloud Firestore setup completed successfully."
        fi
      fi


      if contains "google_sign_in" "${SELECTED_PACKAGES[@]}"; then
          add_google_signin_ios_config
      fi

      if contains "supabase_flutter" "${SELECTED_PACKAGES[@]}"; then
        if gum confirm "${GUM_CONFIRM_STYLE[@]}" "🧩 Run Supabase setup?"; then

            if gum confirm "${GUM_CONFIRM_STYLE[@]}" "🧩 Do you want to create a Supabase Authentication?"; then
              source "$SCRIPT_DIR/templates/features/auth/create_auth_structure.sh"
              echo "✅ Supabase Auth creation completed successfully."
            else
              echo "⚠️ Skipping Supabase Auth creation."
            fi

            if gum confirm "${GUM_CONFIRM_STYLE[@]}" "🧩 Do you want to create a Supabase Service (CRUD/Storage) ?"; then
              supabase_service
              echo "✅ Supabase Service (CRUD/Storage) creation completed successfully."
            else
              echo "⚠️ Skipping Supabase Service (CRUD/Storage) creation."
            fi

            echo "✅ Supabase setup completed successfully."
         fi
      fi

      if contains "local_auth" "${SELECTED_PACKAGES[@]}"; then
          local_auth
      fi

      if contains "easy_localization" "${SELECTED_PACKAGES[@]}"; then
          easy_localization
      fi

      if contains "flutter_local_notifications" "${SELECTED_PACKAGES[@]}"; then
          flutter_local_notifications
      fi

      if [ "${should_run_build_runner:-false}" = true ]; then
        DEST_DIR="${FLUTTER_PROJECT_DIR}"
        if [ -z "$DEST_DIR" ]; then
          echo "❌ FLUTTER_PROJECT_DIR is not set. Please set it to your Flutter project directory."
          exit 1
        fi
        cd "$DEST_DIR" || exit 1
        echo "🛠️ Running build_runner..."
        dart run build_runner build --delete-conflicting-outputs
        if [ $? -ne 0 ]; then
          echo "❌ build_runner failed. Please check the output for errors."
          exit 1
        fi
        echo "✅ build_runner completed successfully."
        cd - >/dev/null || exit 1
      fi

      echo "✅ Templates generated successfully."
  fi
else
  echo "❌ No packages selected. Skipping template generation."
  echo "⚠️ Please Add Packages."
  exit 1
fi
