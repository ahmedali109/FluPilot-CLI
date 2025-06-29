#!/bin/bash

function execute_flag_commands(){
  local file_path="$1"
  if [[ -f "$file_path" ]]; then
    source "$file_path"
  else
    echo "❌ Error: File '$file_path' not found."
    exit 1
  fi
}


# ------------------ CLI Flags ------------------
function show_help() {
  echo "🛠️  FluPilot CLI - Flutter Project Starter"
  echo ""
  echo "Usage:"
  echo "  FluPilotCLI [command]"
  echo ""
  echo "Available Commands:"
  echo ""
  echo "General:"
  echo "  --help, -h                      Show this help message"
  echo "  --version, -v                   Show CLI version"
  echo "  --change-directory              Change Flutter project directory"
  echo "  --reset-directory               Reset to default directory (current working directory)"
  echo ""
  echo "Assets & UI:"
  echo "  --assets                        Add asset management configuration"
  echo "  --app-icon                      Configure app icon setup"
  echo "  --splash                        Add splash screen configuration"
  echo "  --onboarding                    Create onboarding screen templates"
  echo ""
  echo "UI Components:"
  echo "  --slidable                      Add slidable widget functionality"
  echo "  --pull-to-refresh               Add pull-to-refresh functionality"
  echo "  --action-slider                 Add action slider widget"
  echo "  --google-navbar                 Add Google-style navigation bar"
  echo ""
  echo "Media & Picker:"
  echo "  --image-picker                  Add image picker functionality"
  echo "  --audio-player                  Add audio player capabilities"
  echo "  --video-player                  Add video player capabilities"
  echo ""
  echo "Navigation & State Management:"
  echo "  --go-router                     Add GoRouter for navigation"
  echo "  --cubit                         Add BLoC/Cubit state management"
  echo ""
  echo "Networking:"
  echo "  --http                          Add HTTP client functionality"
  echo "  --dio                           Add Dio HTTP client"
  echo "  --retrofit                      Add Retrofit for API calls"
  echo "  --cached-network-image          Add cached network image loading"
  echo "  --internet-connection           Add internet connectivity checking"
  echo ""
  echo "Data & Serialization:"
  echo "  --json-serializable             Add JSON serialization support"
  echo "  --freezed                       Add Freezed for immutable classes"
  echo "  --shared-preferences            Add local storage with SharedPreferences"
  echo ""
  echo "Dependency Injection:"
  echo "  --get-it                        Add GetIt service locator"
  echo ""
  echo "Backend & Database:"
  echo "  --firebase                      Setup Firebase configuration"
  echo "  --firebase-auth                 Add Firebase authentication"
  echo "  --cloud-firestore               Add Cloud Firestore database"
  echo "  --supabase-auth                 Add Supabase authentication"
  echo "  --supabase-service              Add Supabase service integration"
  echo ""
  echo "Authentication & Security:"
  echo "  --google-sign-in                Add Google Sign-In functionality"
  echo "  --local-auth                    Add biometric/PIN authentication"
  echo ""
  echo "Localization & Notifications:"
  echo "  --easy-localization             Add multi-language support"
  echo "  --local-notifications           Add local notifications"
  echo ""
  echo "assistant_files"
  echo "  --assistant-files               Generate assistant files for project"
  echo ""
}

# If SCRIPT_DIR is already set (from parent script), use that instead
if [ -z "$SCRIPT_DIR" ]; then
  SOURCE="${BASH_SOURCE[0]}"
  while [ -h "$SOURCE" ]; do
    DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
  done
  SCRIPT_DIR="$(cd -P "$(dirname "$SOURCE")/../.." && pwd)"
fi

echo "Using script directory: $SCRIPT_DIR"

case "${1:-}" in
  --version|-v)
    # Read from package.json
    VERSION=$(node -p "require('./package.json').version")
    echo "FluPilot CLI $VERSION"
    exit 0
    ;;
  --help|-h)
    show_help
    exit 0
    ;;
  --change-directory)
    CACHE_FILE="$(pwd)/.flupilot_last_directory"
    source "$SCRIPT_DIR/pickers/pick_directory.sh"
    NEW_DIR=$(pick_dir)
    echo "$NEW_DIR" > "$CACHE_FILE"
    echo "✅ Directory changed to: $NEW_DIR"
    exit 0
    ;;
  --reset-directory)
    CACHE_FILE="$(pwd)/.flupilot_last_directory"
    rm -f "$CACHE_FILE"
    echo "🔄 Directory cache cleared - next command will start from current working directory: $(pwd)"
    exit 0
    ;;
  --assets)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/functions/assets_function.sh"
    assets_function
    exit 0
    ;;
  --app-icon)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/functions/app_icon_function.sh"
    app_icon_function
    exit 0
    ;;
  --splash)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/functions/splash_function.sh"
    splash_function
    exit 0
    ;;
  --onboarding)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/functions/onBoarding_function.sh"
    onBoarding_function
    exit 0
    ;;
  --slidable)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/functions/slidable_function.sh"
    SlidableFunction
    exit 0
    ;;
  --pull-to-refresh)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/functions/pull_to_refresh.sh"
    pullToRefresh
    exit 0
    ;;
  --action-slider)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/functions/actionSlider.sh"
    actionSlider
    exit 0
    ;;
  --google-navbar)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/functions/googleNavBar.sh"
    googleNavBar
    exit 0
    ;;
  --image-picker)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/functions/imagePicker.sh"
    imagePicker
    exit 0
    ;;
  --audio-player)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/functions/audioPlayers.sh"
    audioPlayers
    exit 0
    ;;
  --video-player)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/functions/videoPlayers.sh"
    videoPlayers
    exit 0
    ;;
  --go-router)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/functions/goRouter.sh"
    goRouter
    exit 0
    ;;
  --cubit)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/functions/flutterBloc.sh"
    flutterBloc
    exit 0
    ;;
  --http)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/functions/http.sh"
    http
    exit 0
    ;;
  --dio)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/functions/dio.sh"
    dio
    exit 0
    ;;
  --retrofit)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/functions/retrofit.sh"
    retrofit
    exit 0
    ;;
  --cached-network-image)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/functions/cached_network_image.sh"
    cached_network_image
    exit 0
    ;;
  --internet-connection)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/functions/internet_connection.sh"
    internet_connection
    exit 0
    ;;
  --json-serializable)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/functions/json_serializable.sh"
    json_serializable
    exit 0
    ;;
  --freezed)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/functions/freezed.sh"
    freezed
    exit 0
    ;;
  --get-it)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/functions/get_it.sh"
    get_it
    exit 0
    ;;
  --shared-preferences)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/functions/shared_preferences.sh"
    shared_preferences
    exit 0
    ;;
  --firebase)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    source "$SCRIPT_DIR/setup/setup_firebase.sh"
    exit 0
    ;;
  --firebase-auth)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    (cd "$FLUTTER_PROJECT_DIR" && echo "🔄 Adding firebase_auth dependency..." && flutter pub add firebase_auth && flutter pub get && echo "✅ firebase_auth added to pubspec.yaml" && echo "🔄 Running Firebase authentication setup...")
    source "$SCRIPT_DIR/templates/features/auth/create_auth_structure.sh"
    exit 0
    ;;
  --cloud-firestore)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/functions/cloud_firestore.sh"
    cloud_firestore
    exit 0
    ;;
  --supabase-auth)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    source "$SCRIPT_DIR/templates/features/auth/create_auth_structure.sh"
    exit 0
    ;;
  --supabase-service)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/functions/supabase_service.sh"
    supabase_service
    exit 0
    ;;
  --google-sign-in)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/permission/ios/google_sign_in_permission.sh"
    add_google_signin_ios_config
    exit 0
    ;;
  --local-auth)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/functions/local_auth.sh"
    local_auth
    exit 0
    ;;
  --easy-localization)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/functions/easy_localization.sh"
    easy_localization
    exit 0
    ;;
  --local-notifications)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/functions/flutter_local_notifications.sh"
    flutter_local_notifications
    exit 0
    ;;
  --assistants-files)
    source "$SCRIPT_DIR/setup/project_directory_setup.sh"
    execute_flag_commands "$SCRIPT_DIR/templates/gen/assistants_files.sh"
    assistants_files
    exit 0
    ;;
  *)
    if [[ -n "${1:-}" ]]; then
      echo "❌ Unknown command: ${1:-}"
      echo "Use --help or -h to see available commands."
      exit 1
    fi
    ;;
esac
