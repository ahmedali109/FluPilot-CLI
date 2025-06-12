#!/bin/bash

function create_api_service(){
  DEST_DIR="${FLUTTER_PROJECT_DIR}/lib/core/networking"
  API_SERVICE_FILE="$DEST_DIR/api_service.dart"
  # Check if pubspec.yaml contains dio and retrofit and build_runner dependencies
  PUBSPEC_FILE="${FLUTTER_PROJECT_DIR}/pubspec.yaml"
  if ! grep -q "dio:" "$PUBSPEC_FILE"; then
    echo "Adding dio dependency to pubspec.yaml..."
    (cd "$FLUTTER_PROJECT_DIR" && flutter pub add dio && flutter pub get)
    echo "✅ dio dependency added to pubspec.yaml."
  else
    echo "dio dependency already exists in pubspec.yaml."
  fi
  if ! grep -q "retrofit:" "$PUBSPEC_FILE"; then
    echo "Adding retrofit dependency to pubspec.yaml..."
    (cd "$FLUTTER_PROJECT_DIR" && flutter pub add retrofit && flutter pub get)
    echo "✅ retrofit dependency added to pubspec.yaml."
  else
    echo "retrofit dependency already exists in pubspec.yaml."
  fi
  if ! grep -q "build_runner:" "$PUBSPEC_FILE"; then
    echo "Adding build_runner dependency to pubspec.yaml..."
    (cd "$FLUTTER_PROJECT_DIR" && flutter pub add build_runner && flutter pub get)
    echo "✅ build_runner dependency added to pubspec.yaml."
  else
    echo "build_runner dependency already exists in pubspec.yaml."
  fi
  cat <<EOL > "$API_SERVICE_FILE"
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'api_constants.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/users")
  Future<List<Map<String , dynamic>>> getUsers();

  @GET("/users/{id}")
  Future<Map<String , dynamic>> getUser(@Path("id") String id);

  @POST("/users")
  Future<Map<String , dynamic>> createUser(@Body() Map<String, dynamic> user);

  @PUT("/users/{id}")
  Future<Map<String , dynamic>> updateUser(
    @Path("id") String id,
    @Body() Map<String, dynamic> user,
  );

  @DELETE("/users/{id}")
  Future<void> deleteUser(@Path("id") String id);
}

EOL
 echo "📄 Created api_service.dart file successfully at $API_SERVICE_FILE"
 echo "✅ Api service template generated successfully."
 echo "⚡️ Run: flutter pub run build_runner build --delete-conflicting-outputs to generate the .g.dart file."
}
export -f create_api_service
