#!/bin/bash


function create_api_error_model(){
DEST_DIR="${FLUTTER_PROJECT_DIR}/lib/core/networking"
 API_ERROR_FILE="$DEST_DIR/api_error_model.dart"
   # Check if pubspec.yaml contains json_annotation and build_runner dependencies
  PUBSPEC_FILE="${FLUTTER_PROJECT_DIR}/pubspec.yaml"
  if ! grep -q "json_annotation:" "$PUBSPEC_FILE"; then
    echo "Adding json_annotation dependency to pubspec.yaml..."
    (cd "$FLUTTER_PROJECT_DIR" && flutter pub add json_annotation && flutter pub get)
    echo "✅ json_annotation dependency added to pubspec.yaml."
  else
    echo "json_annotation dependency already exists in pubspec.yaml."
  fi
  if ! grep -q "build_runner:" "$PUBSPEC_FILE"; then
    echo "Adding build_runner dependency to pubspec.yaml..."
    (cd "$FLUTTER_PROJECT_DIR" && flutter pub add build_runner && flutter pub get)
    echo "✅ build_runner dependency added to pubspec.yaml."
  else
    echo "build_runner dependency already exists in pubspec.yaml."
  fi
  cat <<EOL > "$API_ERROR_FILE"
import 'package:json_annotation/json_annotation.dart';
part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  final String? message;
  final int? code;

  ApiErrorModel({
    required this.message,
    this.code,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) => _\$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _\$ApiErrorModelToJson(this);
}
EOL
 echo "📄 Created api_error_model.dart file successfully at $API_ERROR_FILE"
 echo "✅ Api error model template generated successfully."
}

export -f create_api_error_model
