#!/bin/bash

function create_api_service(){
  DEST_DIR="${FLUTTER_PROJECT_DIR}/lib/core/networking"
  API_SERVICE_FILE="$DEST_DIR/api_service.dart"
  cat <<EOL > "$API_SERVICE_FILE"
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'api_constants.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/users")
  Future<List<dynamic>> getUsers();

  @GET("/users/{id}")
  Future<dynamic> getUser(@Path("id") String id);

  @POST("/users")
  Future<dynamic> createUser(@Body() Map<String, dynamic> user);

  @PUT("/users/{id}")
  Future<dynamic> updateUser(@Path("id") String id, @Body() Map<String, dynamic> user);

  @DELETE("/users/{id}")
  Future<void> deleteUser(@Path("id") String id);
}
EOL
 echo "📄 Created api_service.dart file successfully at $API_SERVICE_FILE"
 echo "✅ Api service template generated successfully."
 echo "⚡️ Run: flutter pub run build_runner build --delete-conflicting-outputs to generate the .g.dart file."
}
export -f create_api_service
