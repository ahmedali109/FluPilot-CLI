#!/bin/bash

source ./scripts/utils/styles/gum_select_style.sh
source ./scripts/utils/constant/gum_options_strings.sh
source ./scripts/utils/gum_options/available_categories.sh
source ./scripts/utils/gum_options/available_packages.sh

IFS=$'\n' read -r -d '' -a SELECTED_CATEGORIES < <(
  gum choose "${GUM_SELECTED_STYLE[@]}" \
    --no-limit \
    --header="📦 Select categories of packages" \
    "${CATEGORIES[@]}" && printf '\0'
)
SELECTED_PACKAGES=()

for CATEGORY in "${SELECTED_CATEGORIES[@]}"; do
  case $CATEGORY in
    $CAT_APP_ICON)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="App Icon packages" \
          "${PKG_AppIcon[@]}" && printf '\0'
      )
      ;;
    $CAT_SPLASH)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Splash screen packages" \
          "${PKG_SplashScreen[@]}" && printf '\0'
      )
      ;;
    $CAT_ON_BOARDING)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="On Boarding packages" \
          "${PKG_OnBoarding[@]}" && printf '\0'
      )
      ;;
    $CAT_ANIMATION)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Animation packages" \
          "${PKG_Animations[@]}" && printf '\0'
      )
      ;;
    $CAT_INDICATORS)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Indicator packages" \
          "${PKG_Indicators[@]}" && printf '\0'
      )
      ;;
    $CAT_BOTTOM_NAV_BAR)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Bottom Navigation Bar packages" \
          "${PKG_BottomNavBar[@]}" && printf '\0'
      )
      ;;
    $CAT_STATE_MANAGEMENT)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="State Management packages" \
          "${PKG_StateManagement[@]}" && printf '\0'
      )
      ;;
    $CAT_NAVIGATION)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Navigation packages" \
          "${PKG_Navigation[@]}" && printf '\0'
      )
      ;;
    $CAT_NETWORKING)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Networking packages" \
          "${PKG_Networking[@]}" && printf '\0'
      )
      ;;
    $CAT_DEPENDENCY_INJECTION)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Dependency Injection packages" \
          "${PKG_DependencyInjection[@]}" && printf '\0'
      )
      ;;
    $CAT_STORAGE)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Storage packages" \
          "${PKG_Storage[@]}" && printf '\0'
      )
      ;;
    $CAT_CLOUD)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Cloud service packages" \
          "${PKG_Cloud[@]}" && printf '\0'
      )
      ;;
    $CAT_AUTH)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Authentication packages" \
          "${PKG_Auth[@]}" && printf '\0'
      )
      ;;
    $CAT_BIOMETRIC)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Biometric packages" \
          "${PKG_Biometric[@]}" && printf '\0'
      )
      ;;
    $CAT_LOCALIZATION)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Localization packages" \
          "${PKG_Localization[@]}" && printf '\0'
      )
      ;;
    $CAT_NOTIFICATIONS)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Notification packages" \
          "${PKG_Notifications[@]}" && printf '\0'
      )
      ;;
    $CAT_RESPONSIVE)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Responsive design packages" \
          "${PKG_Responsive[@]}" && printf '\0'
      )
      ;;
    $CAT_UTILITIES)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="UI Utility packages" \
          "${PKG_UI_Utils[@]}" && printf '\0'
      )
      ;;
    $CAT_OTHERS)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Other packages" \
          "${PKG_Others[@]}" && printf '\0'
      )
      ;;
  esac

  # Add selected packages to the final list
  SELECTED_PACKAGES+=("${SELECTED[@]}")
done

export SELECTED_PACKAGES
