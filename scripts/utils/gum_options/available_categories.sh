#!/bin/bash

source ./scripts/utils/constant/gum_options_strings.sh

CATEGORIES=(
  # App Setup
  $CAT_APP_ICON
  $CAT_SPLASH
  $CAT_ONBOARDING

  # UI/UX
  $CAT_UI_ANIMATIONS
  $CAT_UI_INDICATORS
  $CAT_UI_BOTTOM_NAV
  $CAT_UI_UTILITIES
  $CAT_UI_RESPONSIVE

  # Architecture
  $CAT_NAVIGATION
  $CAT_STATE_MANAGEMENT

  # Networking & Code Gen
  $CAT_NETWORKING
  $CAT_CODE_GEN
  $CAT_DEP_INJECTION

  # Storage
  $CAT_STORAGE_LOCAL
  $CAT_STORAGE_GRAPHQL

  # Cloud & Auth
  $CAT_CLOUD
  $CAT_AUTH_SOCIAL
  $CAT_AUTH_BIOMETRIC

  # Localization & Notifications
  $CAT_LOCALIZATION
  $CAT_NOTIFICATIONS

  # Utilities
  $CAT_SYSTEM_UTILS
)
