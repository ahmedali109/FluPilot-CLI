#!/bin/bash

if [ ${#SELECTED_PACKAGES[@]} -eq 0 ]; then
  echo "⚠️ No packages selected. Skipping package install and template generation."
else
  echo "📦 Adding selected packages..."
  for PACKAGE in "${SELECTED_PACKAGES[@]}"; do
    flutter pub add "$PACKAGE"
  done
fi
