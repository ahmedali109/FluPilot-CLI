#!/bin/bash
# Dependency-aware script to manage assets in pubspec.yaml
PUBSPEC_FILE="$FLUTTER_PROJECT_DIR/pubspec.yaml"

# Check if pubspec.yaml exists
if [[ ! -f "$PUBSPEC_FILE" ]]; then
    echo "❌ Error: pubspec.yaml not found at $PUBSPEC_FILE"
    exit 1
fi

# Function to check if a dependency exists in pubspec.yaml
has_dependency() {
    local dep_name="$1"
    grep -q "^[[:space:]]*$dep_name:" "$PUBSPEC_FILE"
}

# Function to check what dependencies are present
check_dependencies() {
    local deps=()

    # Check for common dependencies that require assets
    if has_dependency "easy_localization"; then
        deps+=("easy_localization")
    fi

    # Check for image-related dependencies
    if has_dependency "cached_network_image" || has_dependency "flutter_svg" || grep -q "assets.*images" "$PUBSPEC_FILE" || [[ -d "$FLUTTER_PROJECT_DIR/assets/images" ]]; then
        deps+=("images")
    fi

    # Check for icon-related dependencies or if icons directory exists
    if has_dependency "flutter_launcher_icons" || has_dependency "cupertino_icons" || [[ -d "$FLUTTER_PROJECT_DIR/assets/icons" ]]; then
        deps+=("icons")
    fi

    # Always include images and icons as they're commonly used
    if [[ ! " ${deps[*]} " =~ " images " ]]; then
        deps+=("images")
    fi
    if [[ ! " ${deps[*]} " =~ " icons " ]]; then
        deps+=("icons")
    fi

    printf "%s\n" "${deps[@]}"
}

# Function to check what assets are currently configured
check_current_assets() {
    local current=()

    if grep -q "^[[:space:]]*-[[:space:]]*assets/images/" "$PUBSPEC_FILE"; then
        current+=("images")
    fi

    if grep -q "^[[:space:]]*-[[:space:]]*assets/icons/" "$PUBSPEC_FILE"; then
        current+=("icons")
    fi

    if grep -q "^[[:space:]]*-[[:space:]]*assets/l10n/" "$PUBSPEC_FILE"; then
        current+=("l10n")
    fi

    # Handle empty array case
    if [[ ${#current[@]} -gt 0 ]]; then
        printf "%s\n" "${current[@]}"
    fi
}

# Function to add missing assets
add_missing_assets() {
    local needed_assets=("$@")

    if [[ ${#needed_assets[@]} -eq 0 ]]; then
        echo "✅ No assets need to be added"
        return
    fi

    echo "📁 Adding missing assets: ${needed_assets[*]}"

    local temp_file=$(mktemp)
    local assets_section_exists=false
    local added_assets=false

    # Check if assets section exists
    if grep -q "^[[:space:]]*assets:[[:space:]]*$" "$PUBSPEC_FILE"; then
        assets_section_exists=true
    fi

    if [[ "$assets_section_exists" == true ]]; then
        # Assets section exists, add new assets after it
        while IFS= read -r line; do
            echo "$line" >> "$temp_file"
            if [[ "$line" =~ ^[[:space:]]*assets:[[:space:]]*$ ]] && [[ "$added_assets" == false ]]; then
                # Add each needed asset
                for asset in "${needed_assets[@]}"; do
                    case "$asset" in
                        "images")
                            echo "    - assets/images/" >> "$temp_file"
                            ;;
                        "icons")
                            echo "    - assets/icons/" >> "$temp_file"
                            ;;
                        "l10n")
                            echo "    - assets/l10n/" >> "$temp_file"
                            ;;
                    esac
                done
                added_assets=true
            fi
        done < "$PUBSPEC_FILE"
    else
        # No assets section, create it
        while IFS= read -r line; do
            echo "$line" >> "$temp_file"
            if [[ "$line" =~ ^[[:space:]]*uses-material-design: ]] && [[ "$added_assets" == false ]]; then
                echo "  assets:" >> "$temp_file"
                # Add each needed asset
                for asset in "${needed_assets[@]}"; do
                    case "$asset" in
                        "images")
                            echo "    - assets/images/" >> "$temp_file"
                            ;;
                        "icons")
                            echo "    - assets/icons/" >> "$temp_file"
                            ;;
                        "l10n")
                            echo "    - assets/l10n/" >> "$temp_file"
                            ;;
                    esac
                done
                added_assets=true
            fi
        done < "$PUBSPEC_FILE"
    fi

    mv "$temp_file" "$PUBSPEC_FILE"
}

# Main logic
echo "🔍 Analyzing dependencies and current assets..."

# Get required assets based on dependencies
echo "📦 Checking dependencies:"
required_assets=()
while IFS= read -r dep; do
    case "$dep" in
        "easy_localization")
            echo "  ✅ easy_localization found → needs assets/l10n/"
            required_assets+=("l10n")
            ;;
        "images")
            echo "  ✅ Images support detected → needs assets/images/"
            required_assets+=("images")
            ;;
        "icons")
            echo "  ✅ Icons support detected → needs assets/icons/"
            required_assets+=("icons")
            ;;
    esac
done < <(check_dependencies)

# Get currently configured assets
echo ""
echo "📋 Current assets configuration:"
current_assets=()
while IFS= read -r asset; do
    if [[ -n "$asset" ]]; then
        echo "  ✅ assets/$asset/ is configured"
        current_assets+=("$asset")
    fi
done < <(check_current_assets)

if [[ ${#current_assets[@]} -eq 0 ]]; then
    echo "  ❌ No assets currently configured"
fi

# Find missing assets
missing_assets=()
for required in "${required_assets[@]}"; do
    # Safe array check
    found=false
    if [[ ${#current_assets[@]} -gt 0 ]]; then
        for current in "${current_assets[@]}"; do
            if [[ "$current" == "$required" ]]; then
                found=true
                break
            fi
        done
    fi
    if [[ "$found" == false ]]; then
        missing_assets+=("$required")
    fi
done

echo ""
if [[ ${#missing_assets[@]} -gt 0 ]]; then
    echo "⚙️  Missing assets: ${missing_assets[*]}"
    add_missing_assets "${missing_assets[@]}"
    echo "✅ Assets have been updated based on your dependencies"
else
    echo "✅ All required assets are already properly configured"
fi
