#!/bin/bash


function create_api_error_model(){
DEST_DIR="${FLUTTER_PROJECT_DIR}/lib/core/networking"
 API_ERROR_FILE="$DEST_DIR/api_error_model.dart"
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
