#!/bin/bash

source ./scripts/templates/helper/create_notifications_service.sh
source ./scripts/templates/permission/android/notifications_permission.sh

function flutter_local_notifications(){
  DEST_DIR="${FLUTTER_PROJECT_DIR}"

  if [ -z "$DEST_DIR" ]; then
    echo "❌ FLUTTER_PROJECT_DIR is not set. Please set it to your Flutter project directory."
    exit 1
  fi

  mkdir -p "$DEST_DIR/lib/core/services" || {
    echo "❌ Failed to create directory $DEST_DIR/lib/core/services"
    exit 1
  }

  echo "📂 Created directory $DEST_DIR/lib/core/services"
  cd "$DEST_DIR" || exit 1
  echo "🛠️ Generating flutter_local_notifications template in $DEST_DIR"

  if ! grep -q "flutter_local_notifications:" pubspec.yaml; then
    echo "❌ flutter_local_notifications not found in pubspec.yaml. Please add it under dependencies."
    echo "Example:"
    echo "dependencies:"
    echo "  flutter_local_notifications: latest_version"
    exit 1
  fi

  echo "📂 Creating notifications_service.dart in $DEST_DIR/lib/core/services..."
  touch "$DEST_DIR/lib/core/services/notifications_service.dart" || {
    echo "❌ Failed to create notifications_service.dart"
    exit 1
  }

  create_notifications_service

  APP_DELEGATE_FILE="$FLUTTER_PROJECT_DIR/ios/Runner/AppDelegate.swift"
  echo "📂 Updating AppDelegate.swift at $APP_DELEGATE_FILE"

  # Check if the file exists
  if [ ! -f "$APP_DELEGATE_FILE" ]; then
      echo "❌ Error: AppDelegate.swift not found at $APP_DELEGATE_FILE"
      exit 1
  fi

  # Update AppDelegate.swift to include flutter_local_notifications
  sed -i '' -e 's/import UIKit/import UIKit\
  import flutter_local_notifications/' \
  -e '/GeneratedPluginRegistrant.register(with: self)/i\
      FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in\
      GeneratedPluginRegistrant.register(with: registry)\
      }\
      if #available(iOS 10.0, *) {\
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate\
      }' "$APP_DELEGATE_FILE"

  echo "✅ AppDelegate.swift has been successfully updated."

  # Add permissions to AndroidManifest.xml
  add_flutter_local_notifications_permissions

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}
