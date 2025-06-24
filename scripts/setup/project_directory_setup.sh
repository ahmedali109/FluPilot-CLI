#!/bin/bash

# Cache file to store the last picked directory (in current working directory)
CACHE_FILE="$(pwd)/.flupilot_last_directory"

if [ -z "${FLUTTER_PROJECT_DIR:-}" ]; then
  source "scripts/pickers/pick_directory.sh"

  # Try to load from cache first to use as starting directory
  if [ -f "$CACHE_FILE" ]; then
    CACHED_DIR=$(cat "$CACHE_FILE")
    if [ -d "$CACHED_DIR" ]; then
      echo "🔄 Starting directory picker from last location: $CACHED_DIR"
      FLUTTER_PROJECT_DIR=$(pick_dir "$CACHED_DIR")
    else
      echo "⚠️  Cached directory no longer exists, starting from current directory..."
      FLUTTER_PROJECT_DIR=$(pick_dir "$(pwd)")
    fi
  else
    # No cache file exists, pick directory starting from current working directory
    echo "📁 First time setup - picking Flutter project directory from current location..."
    FLUTTER_PROJECT_DIR=$(pick_dir "$(pwd)")
  fi

  # Save the picked directory to cache for next time
  echo "$FLUTTER_PROJECT_DIR" > "$CACHE_FILE"
  echo "✅ Directory saved for future use: $FLUTTER_PROJECT_DIR"
fi

export FLUTTER_PROJECT_DIR
