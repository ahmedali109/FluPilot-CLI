#!/bin/bash

# Generate Templates
source ./scripts/utils/styles/gum_choose_style.sh
source ./scripts/templates/functions/assets_function.sh
source ./scripts/templates/functions/app_icon_function.sh
source ./scripts/templates/functions/splash_function.sh
source ./scripts/templates/functions/onBoarding_function.sh
source ./scripts/templates/functions/slidable_function.sh

if gum confirm "${GUM_CONFIRM_STYLE[@]}" "🧰 Generate basic templates for selected packages?"; then
    contains() {
      local e match="$1"
      shift
      for e; do [[ "$e" == "$match" ]] && return 0; done
      return 1
    }

    assets_function

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

    echo "✅ Templates generated successfully."
fi
