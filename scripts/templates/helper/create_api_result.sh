#!/bin/bash

function create_api_result(){
  DEST_DIR="${FLUTTER_PROJECT_DIR}/lib/core/networking"
  API_RESULT_FILE="$DEST_DIR/api_result.dart"
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
