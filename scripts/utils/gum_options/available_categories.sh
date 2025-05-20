#!/bin/bash

source ./scripts/utils/constant/gum_options_strings.sh

CATEGORIES=(
  # UI/UX Elements
  $CAT_APP_ICON
  $CAT_SPLASH
  $CAT_ON_BOARDING
  $CAT_ANIMATION
  $CAT_INDICATORS
  $CAT_BOTTOM_NAV_BAR

  # State & Navigation
  $CAT_STATE_MANAGEMENT
  $CAT_NAVIGATION

  # Data Handling
  $CAT_NETWORKING
  $CAT_DEPENDENCY_INJECTION
  $CAT_STORAGE
  $CAT_CLOUD

  # Security & Permissions
  $CAT_AUTH
  $CAT_BIOMETRIC

  # Localization & Notifications
  $CAT_LOCALIZATION
  $CAT_NOTIFICATIONS

  # Responsive Design
  $CAT_RESPONSIVE

  # Developer Utilities
  $CAT_UTILITIES
  $CAT_OTHERS
)
