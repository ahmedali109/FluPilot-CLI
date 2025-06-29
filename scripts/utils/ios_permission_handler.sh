#!/usr/bin/env bash

# iOS Permission Handler Utility
# This script provides functions to safely add iOS permissions to Info.plist
# without creating duplicates

function check_ios_permission_exists() {
    local plist_file="$1"
    local permission_key="$2"

    if [ ! -f "$plist_file" ]; then
        echo "false"
        return
    fi

    # Check if the permission key already exists in the plist file
    if grep -q "<key>$permission_key</key>" "$plist_file"; then
        echo "true"
    else
        echo "false"
    fi
}

function add_ios_permission_safe() {
    local plist_file="$1"
    local permission_key="$2"
    local permission_description="$3"
    local indent="${4:-    }"  # Default to 4 spaces

    if [ ! -f "$plist_file" ]; then
        echo "❌ Info.plist file not found: $plist_file"
        return 1
    fi

    # Check if permission already exists
    local exists=$(check_ios_permission_exists "$plist_file" "$permission_key")

    if [ "$exists" = "true" ]; then
        echo "✅ Permission '$permission_key' already exists in Info.plist - skipping"
        return 0
    fi

    echo "🔄 Adding iOS permission: $permission_key"

    # Create temporary file for the permission entry
    local tmp_config=$(mktemp)

    # Write the permission with proper indentation
    cat >> "$tmp_config" << EOF
${indent}<key>$permission_key</key>
${indent}<string>$permission_description</string>
EOF

    # Find the last </dict> before the final </plist> and insert before it
    # This ensures we add to the main dictionary
    if ! grep -q "</dict>" "$plist_file"; then
        echo "❌ Invalid Info.plist format - no closing </dict> found"
        rm -f "$tmp_config"
        return 1
    fi

    # Create a backup
    cp "$plist_file" "${plist_file}.backup"

    # Insert the permission before the last </dict>
    # Use a simpler approach - find the last </dict> and insert before it
    awk -v config_file="$tmp_config" '
    BEGIN {
        # Read the config content
        while ((getline line < config_file) > 0) {
            config = config line "\n"
        }
        close(config_file)
    }

    # Store all lines and find the last </dict>
    {
        lines[++line_count] = $0
        if ($0 ~ /<\/dict>/) {
            last_dict_line = line_count
        }
    }

    END {
        # Print all lines, inserting config before the last </dict>
        for (i = 1; i <= line_count; i++) {
            if (i == last_dict_line) {
                printf "%s", config
            }
            print lines[i]
        }
    }' "$plist_file" > "${plist_file}.tmp"

    # Replace original with modified version
    mv "${plist_file}.tmp" "$plist_file"

    # Clean up
    rm -f "$tmp_config"

    echo "✅ Added iOS permission: $permission_key"
    return 0
}

function add_multiple_ios_permissions() {
    local plist_file="$1"
    shift  # Remove first argument, rest are permission arrays

    echo "🔄 Processing multiple iOS permissions..."

    # Each remaining argument should be in format "KEY|DESCRIPTION"
    for permission in "$@"; do
        IFS='|' read -r key description <<< "$permission"
        add_ios_permission_safe "$plist_file" "$key" "$description"
    done

    echo "✅ Finished processing iOS permissions"
}

# Predefined common iOS permissions
function add_face_id_permission() {
    local plist_file="$1"
    add_ios_permission_safe "$plist_file" "NSFaceIDUsageDescription" "This app requires access to Face ID for authentication purposes."
}

function add_camera_permission() {
    local plist_file="$1"
    add_ios_permission_safe "$plist_file" "NSCameraUsageDescription" "This app requires access to the camera to record videos."
}

function add_photo_library_permission() {
    local plist_file="$1"
    add_ios_permission_safe "$plist_file" "NSPhotoLibraryUsageDescription" "This app requires access to the photo library to select and play videos."
}

function add_location_permission() {
    local plist_file="$1"
    add_ios_permission_safe "$plist_file" "NSLocationWhenInUseUsageDescription" "This app requires access to location for location-based features."
}

function add_microphone_permission() {
    local plist_file="$1"
    add_ios_permission_safe "$plist_file" "NSMicrophoneUsageDescription" "This app requires access to the microphone to record audio for videos."
}

# URL Scheme handling functions
function check_url_scheme_exists() {
    local plist_file="$1"
    local url_scheme="$2"

    if [ ! -f "$plist_file" ]; then
        echo "false"
        return
    fi

    # Check if the URL scheme already exists in the plist file
    if grep -q "<string>$url_scheme</string>" "$plist_file"; then
        echo "true"
    else
        echo "false"
    fi
}

function add_url_scheme_safe() {
    local plist_file="$1"
    local url_scheme="$2"
    local comment_text="${3:-Google Sign-in URL Scheme}"

    if [ ! -f "$plist_file" ]; then
        echo "❌ Info.plist file not found: $plist_file"
        return 1
    fi

    # Check if URL scheme already exists
    local exists=$(check_url_scheme_exists "$plist_file" "$url_scheme")

    if [ "$exists" = "true" ]; then
        echo "✅ URL scheme '$url_scheme' already exists in Info.plist - skipping"
        return 0
    fi

    echo "🔄 Adding iOS URL scheme: $url_scheme"

    # Create temporary file for the URL scheme entry
    local tmp_config=$(mktemp)

    # Write the URL scheme configuration with proper indentation
    cat >> "$tmp_config" << EOF
    <!-- $comment_text -->
    <key>CFBundleURLTypes</key>
    <array>
        <dict>
            <key>CFBundleTypeRole</key>
            <string>Editor</string>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>$url_scheme</string>
            </array>
        </dict>
    </array>
    <!-- End of $comment_text -->
EOF

    # Find the last </dict> before the final </plist> and insert before it
    if ! grep -q "</dict>" "$plist_file"; then
        echo "❌ Invalid Info.plist format - no closing </dict> found"
        rm -f "$tmp_config"
        return 1
    fi

    # Create a backup
    cp "$plist_file" "${plist_file}.backup"

    # Insert the URL scheme before the last </dict>
    awk -v config_file="$tmp_config" '
    BEGIN {
        # Read the config content
        while ((getline line < config_file) > 0) {
            config = config line "\n"
        }
        close(config_file)
    }

    # Store all lines and find the last </dict>
    {
        lines[++line_count] = $0
        if ($0 ~ /<\/dict>/) {
            last_dict_line = line_count
        }
    }

    END {
        # Print all lines, inserting config before the last </dict>
        for (i = 1; i <= line_count; i++) {
            if (i == last_dict_line) {
                printf "%s", config
            }
            print lines[i]
        }
    }' "$plist_file" > "${plist_file}.tmp"

    # Replace original with modified version
    mv "${plist_file}.tmp" "$plist_file"

    # Clean up
    rm -f "$tmp_config"

    echo "✅ Added iOS URL scheme: $url_scheme"
    return 0
}

# Localization handling function
function add_localization_array_safe() {
    local plist_file="$1"
    shift  # Remove first argument, rest are language codes
    local languages=("$@")

    if [ ! -f "$plist_file" ]; then
        echo "❌ Info.plist file not found: $plist_file"
        return 1
    fi

    # Check if CFBundleLocalizations already exists
    if grep -q "<key>CFBundleLocalizations</key>" "$plist_file"; then
        echo "✅ CFBundleLocalizations already exists in Info.plist - skipping"
        return 0
    fi

    echo "🔄 Adding iOS localizations: ${languages[*]}"

    # Create temporary file for the localization array
    local tmp_config=$(mktemp)

    # Write the localization array with proper indentation
    cat >> "$tmp_config" << EOF
    <key>CFBundleLocalizations</key>
    <array>
EOF

    # Add each language
    for lang in "${languages[@]}"; do
        echo "        <string>$lang</string>" >> "$tmp_config"
    done

    echo "    </array>" >> "$tmp_config"

    # Find the last </dict> before the final </plist> and insert before it
    if ! grep -q "</dict>" "$plist_file"; then
        echo "❌ Invalid Info.plist format - no closing </dict> found"
        rm -f "$tmp_config"
        return 1
    fi

    # Create a backup
    cp "$plist_file" "${plist_file}.backup"

    # Insert the localization array before the last </dict>
    awk -v config_file="$tmp_config" '
    BEGIN {
        # Read the config content
        while ((getline line < config_file) > 0) {
            config = config line "\n"
        }
        close(config_file)
    }

    # Store all lines and find the last </dict>
    {
        lines[++line_count] = $0
        if ($0 ~ /<\/dict>/) {
            last_dict_line = line_count
        }
    }

    END {
        # Print all lines, inserting config before the last </dict>
        for (i = 1; i <= line_count; i++) {
            if (i == last_dict_line) {
                printf "%s", config
            }
            print lines[i]
        }
    }' "$plist_file" > "${plist_file}.tmp"

    # Replace original with modified version
    mv "${plist_file}.tmp" "$plist_file"

    # Clean up
    rm -f "$tmp_config"

    echo "✅ Added iOS localizations: ${languages[*]}"
    return 0
}

# Predefined localization function
function add_easy_localization_languages() {
    local plist_file="$1"
    add_localization_array_safe "$plist_file" "en" "ar" "de" "fr" "es" "it" "ja" "ko" "zh"
}

# Additional common iOS permissions
function add_contacts_permission() {
    local plist_file="$1"
    add_ios_permission_safe "$plist_file" "NSContactsUsageDescription" "This app requires access to contacts for contact-related features."
}

function add_calendar_permission() {
    local plist_file="$1"
    add_ios_permission_safe "$plist_file" "NSCalendarsUsageDescription" "This app requires access to calendar for scheduling features."
}

function add_reminders_permission() {
    local plist_file="$1"
    add_ios_permission_safe "$plist_file" "NSRemindersUsageDescription" "This app requires access to reminders for task management."
}

function add_speech_recognition_permission() {
    local plist_file="$1"
    add_ios_permission_safe "$plist_file" "NSSpeechRecognitionUsageDescription" "This app requires access to speech recognition for voice features."
}

function add_bluetooth_permission() {
    local plist_file="$1"
    add_ios_permission_safe "$plist_file" "NSBluetoothAlwaysUsageDescription" "This app requires access to Bluetooth for device connectivity."
}
