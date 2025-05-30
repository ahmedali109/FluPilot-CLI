#!/bin/bash

# Generate Templates
source ./scripts/utils/styles/gum_choose_style.sh
source ./scripts/templates/functions/assets_function.sh
source ./scripts/templates/functions/app_icon_function.sh
source ./scripts/templates/functions/splash_function.sh
source ./scripts/templates/functions/onBoarding_function.sh
source ./scripts/templates/functions/slidable_function.sh
source ./scripts/templates/functions/pull_to_refresh.sh
source ./scripts/templates/functions/actionSlider.sh
source ./scripts/templates/functions/googleNavBar.sh
source ./scripts/templates/functions/imagePicker.sh
source ./scripts/templates/functions/audioPlayers.sh
source ./scripts/templates/functions/videoPlayers.sh
source ./scripts/templates/functions/goRouter.sh
source ./scripts/templates/functions/flutterBloc.sh
source ./scripts/templates/functions/http.sh
source ./scripts/templates/functions/dio.sh
source ./scripts/templates/functions/retrofit.sh
source ./scripts/templates/functions/cached_network_image.sh
source ./scripts/templates/functions/connectivity_plus.sh
source ./scripts/templates/functions/internet_connection_checker.sh
source ./scripts/templates/functions/internet_connection_checker_plus.sh
source ./scripts/templates/functions/json_serializable.sh
source ./scripts/templates/functions/freezed.sh
source ./scripts/templates/functions/get_it.sh
source ./scripts/templates/functions/shared_preferences.sh
source ./scripts/templates/gen/app_regex.sh
source ./scripts/templates/gen/extensions.sh
source ./scripts/templates/gen/spacing.sh

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

      if gum confirm "${GUM_CONFIRM_STYLE[@]}" "🧰 Adding Projects Assets?"; then
      assets_function
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

      if contains "get_it" "${SELECTED_PACKAGES[@]}"; then
        get_it
      fi

      if contains "shared_preferences" "${SELECTED_PACKAGES[@]}"; then
        shared_preferences
      fi

      appRegex
      extensions
      spacing

      echo "✅ Templates generated successfully."
  fi
else
  echo "❌ No packages selected. Skipping template generation."
  echo "⚠️ Please Add Packages."
  exit 1
fi
