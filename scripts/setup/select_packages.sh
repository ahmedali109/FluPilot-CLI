#!/bin/bash

source ./scripts/utils/styles/gum_select_style.sh
source ./scripts/utils/constant/gum_options_strings.sh
source ./scripts/utils/gum_options/available_categories.sh
source ./scripts/utils/gum_options/available_packages.sh

trap 'echo "\n❌ Selection cancelled by user."; exit 1' SIGINT

IFS=$'\n' read -r -d '' -a SELECTED_CATEGORIES < <(
  gum choose "${GUM_SELECTED_STYLE[@]}" \
    --no-limit \
    --header="📦 Select categories of packages" \
    "${CATEGORIES[@]}" && printf '\0'
)
SELECTED_PACKAGES=()

if [ ${#SELECTED_CATEGORIES[@]} -eq 0 ]; then
  echo "❌ No categories selected. Exiting."
  exit 1
fi

for CATEGORY in "${SELECTED_CATEGORIES[@]}"; do
  trap 'echo "\n❌ Selection cancelled by user."; exit 1' SIGINT
  case $CATEGORY in
    $CAT_APP_ICON)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="App Icon packages" \
          "${PKG_App_Icon[@]}" && printf '\0'
      )
      ;;
    $CAT_SPLASH)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Splash Screen packages" \
          "${PKG_App_SplashScreen[@]}" && printf '\0'
      )
      ;;
    $CAT_ONBOARDING)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Onboarding packages" \
          "${PKG_App_Onboarding[@]}" && printf '\0'
      )
      ;;
    $CAT_UI_ANIMATIONS)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Animation packages" \
          "${PKG_UI_Animations[@]}" && printf '\0'
      )
      ;;
    $CAT_UI_INDICATORS)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Indicator packages" \
          "${PKG_UI_Indicators[@]}" && printf '\0'
      )
      ;;
    $CAT_UI_BOTTOM_NAV)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Bottom Navigation Bar packages" \
          "${PKG_UI_BottomNavigation[@]}" && printf '\0'
      )
      ;;
    $CAT_UI_UTILITIES)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="UI Utility packages" \
          "${PKG_UI_Utilities[@]}" && printf '\0'
      )
      ;;
    $CAT_UI_RESPONSIVE)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Responsive Design packages" \
          "${PKG_UI_Responsive[@]}" && printf '\0'
      )
      ;;
    $CAT_NAVIGATION)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Navigation packages" \
          "${PKG_Navigation[@]}" && printf '\0'
      )
      ;;
    $CAT_STATE_MANAGEMENT)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="State Management packages" \
          "${PKG_StateManagement[@]}" && printf '\0'
      )
      ;;
    $CAT_NETWORKING)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Networking packages" \
          "${PKG_Networking[@]}" && printf '\0'
      )
      ;;
    $CAT_CODE_GEN)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Code Generation packages" \
          "${PKG_CodeGen[@]}" && printf '\0'
      )
      ;;
    $CAT_DEP_INJECTION)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Dependency Injection packages" \
          "${PKG_Dependency_Injection[@]}" && printf '\0'
      )
      ;;
    $CAT_STORAGE_LOCAL)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Local Storage packages" \
          "${PKG_Storage_Local[@]}" && printf '\0'
      )
      ;;
    $CAT_STORAGE_GRAPHQL)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="GraphQL Storage packages" \
          "${PKG_Storage_GraphQL[@]}" && printf '\0'
      )
      ;;
    $CAT_CLOUD)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Cloud Services packages" \
          "${PKG_Cloud[@]}" && printf '\0'
      )
      ;;
    $CAT_AUTH_SOCIAL)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Social Authentication packages" \
          "${PKG_Auth_Social[@]}" && printf '\0'
      )
      ;;
    $CAT_AUTH_BIOMETRIC)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="Biometric Authentication packages" \
          "${PKG_Auth_Biometric[@]}" && printf '\0'
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
    $CAT_SYSTEM_UTILS)
      IFS=$'\n' read -r -d '' -a SELECTED < <(
        gum choose "${GUM_SELECTED_STYLE[@]}" --no-limit \
          --header="System Utility packages" \
          "${PKG_System_Utilities[@]}" && printf '\0'
      )
      ;;
  esac

  # Handle empty selection gracefully - just inform and continue
  if [ ${#SELECTED[@]} -eq 0 ]; then
    echo "ℹ️  No packages selected for category: $CATEGORY (continuing...)"
  else
    # Add selected packages to the final list
    SELECTED_PACKAGES+=("${SELECTED[@]}")
  fi
done

# Final check - only show message if we have packages, otherwise inform gracefully
if [ ${#SELECTED_PACKAGES[@]} -eq 0 ]; then
  echo "ℹ️  No packages were selected from any category. Continuing with empty selection."
else
  echo "✅ Selected packages: ${SELECTED_PACKAGES[*]}"
fi

export SELECTED_PACKAGES
