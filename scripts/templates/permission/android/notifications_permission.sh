#!/usr/bin/env bash

function add_flutter_local_notifications_permissions(){
  DEST_DIR="${FLUTTER_PROJECT_DIR}"
  MANIFEST_FILE="$DEST_DIR/android/app/src/main/AndroidManifest.xml"

  if [ -z "$DEST_DIR" ]; then
    echo "❌ FLUTTER_PROJECT_DIR is not set. Please set it to your Flutter project directory."
    exit 1
  fi

  if [ ! -f "$MANIFEST_FILE" ]; then
    echo "❌ AndroidManifest.xml not found at $MANIFEST_FILE."
    exit 1
  fi



  # Add permissions after <manifest> tag
  PERMISSIONS_TO_ADD=(
    "android.permission.POST_NOTIFICATIONS"
    "android.permission.RECEIVE_BOOT_COMPLETED"
    "android.permission.VIBRATE"
    "android.permission.ACCESS_NOTIFICATION_POLICY"
  )

  for permission in "${PERMISSIONS_TO_ADD[@]}"; do
    if grep -q "<uses-permission android:name=\"$permission\"" "$MANIFEST_FILE"; then
      echo "ℹ️ $permission already exists in AndroidManifest.xml."
    else
      echo "🛠️ Adding $permission to AndroidManifest.xml..."
      awk -v perm="$permission" '/<manifest/{print; print "    <uses-permission android:name=\"" perm "\"/>"; next} 1' "$MANIFEST_FILE" > "$MANIFEST_FILE.tmp" && mv "$MANIFEST_FILE.tmp" "$MANIFEST_FILE"
      echo "✅ $permission added."
    fi
  done

  # Check if receivers already exist
  if grep -q "com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver" "$MANIFEST_FILE"; then
    echo "ℹ️ Notification receivers already exist in AndroidManifest.xml."
  else
    echo "🛠️ Adding notification receivers to AndroidManifest.xml..."

    # Create temporary file with receivers block
    cat > /tmp/receivers_block.txt << 'EOF'
        <!-- Notification Service and Receivers for flutter_local_notifications -->
        <receiver android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver" android:exported="false" />
        <receiver android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver" android:exported="false">
            <intent-filter>
                <action android:name="android.intent.action.BOOT_COMPLETED"/>
                <action android:name="android.intent.action.MY_PACKAGE_REPLACED"/>
                <action android:name="android.intent.action.PACKAGE_REPLACED"/>
                <data android:scheme="package" />
            </intent-filter>
        </receiver>
EOF

    # Use a simple approach: create new file with receivers inserted
    awk '
    /<\/application>/ {
        while ((getline line < "/tmp/receivers_block.txt") > 0) {
            print line
        }
        close("/tmp/receivers_block.txt")
    }
    { print }
    ' "$MANIFEST_FILE" > "$MANIFEST_FILE.tmp" && mv "$MANIFEST_FILE.tmp" "$MANIFEST_FILE"

    # Clean up temporary file
    rm -f /tmp/receivers_block.txt

    echo "✅ Notification receivers added."
  fi

  echo "🎉 Flutter local notifications setup completed!"
}

export -f add_flutter_local_notifications_permissions

# Usage example:
# export FLUTTER_PROJECT_DIR="/path/to/your/flutter/project"
# add_flutter_local_notifications_permissions
