#!/bin/bash

function create_api_result(){
  DEST_DIR="${FLUTTER_PROJECT_DIR}/lib/core/networking"
  API_RESULT_FILE="$DEST_DIR/api_result.dart"
  # Check if pubspec.yaml contains freezed_annotation and build_runner and freezed dependencies
  PUBSPEC_FILE="${FLUTTER_PROJECT_DIR}/pubspec.yaml"
  if ! grep -q "freezed_annotation:" "$PUBSPEC_FILE"; then
    echo "Adding freezed_annotation dependency to pubspec.yaml..."
    (cd "$FLUTTER_PROJECT_DIR" && flutter pub add freezed_annotation && flutter pub get)
    echo "✅ freezed_annotation dependency added to pubspec.yaml."
  else
    echo "freezed_annotation dependency already exists in pubspec.yaml."
  fi
  # Check if pubspec.yaml contains build_runner dependency
  if ! grep -q "build_runner:" "$PUBSPEC_FILE"; then
    echo "Adding build_runner dependency to pubspec.yaml..."
    (cd "$FLUTTER_PROJECT_DIR" && flutter pub add build_runner && flutter pub get)
    echo "✅ build_runner dependency added to pubspec.yaml."
  else
    echo "build_runner dependency already exists in pubspec.yaml."
  fi
  # Check if pubspec.yaml contains freezed dependency
  if ! grep -q "freezed:" "$PUBSPEC_FILE"; then
    echo "Adding freezed dependency to pubspec.yaml..."
    (cd "$FLUTTER_PROJECT_DIR" && flutter pub add freezed && flutter pub get)
    echo "✅ freezed dependency added to pubspec.yaml."
  else
    echo "freezed dependency already exists in pubspec.yaml."
  fi
  cat <<EOL > "$API_RESULT_FILE"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'api_error_handler.dart';
part 'api_result.freezed.dart';

@Freezed()
abstract class ApiResult<T> with _\$ApiResult<T> {
  const factory ApiResult.success(T data) = Success<T>;
  const factory ApiResult.failure(ErrorHandler errorHandler) = Failure<T>;
}

EOL
 echo "📄 Created api_result.dart file successfully at $API_RESULT_FILE"
 echo "✅ Api result template generated successfully."
}

export -f create_api_result
