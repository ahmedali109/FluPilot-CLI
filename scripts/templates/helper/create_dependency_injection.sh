#!/bin/bash

function create_dependency_injection(){
 DEST_DIR="${FLUTTER_PROJECT_DIR}/lib/core/di"
 DEPENDENCY_INJECTION_FILE="$DEST_DIR/dependency_injection.dart"
  # check if get_it and dio dependency is in pubspec.yaml
  PUBSPEC_FILE="${FLUTTER_PROJECT_DIR}/pubspec.yaml"
  if ! grep -q "get_it:" "$PUBSPEC_FILE"; then
    echo "Adding get_it dependency to pubspec.yaml..."
    (cd "$FLUTTER_PROJECT_DIR" && flutter pub add get_it && flutter pub get)
    echo "✅ get_it dependency added to pubspec.yaml."
  else
    echo "get_it dependency already exists in pubspec.yaml."
  fi
  if ! grep -q "dio:" "$PUBSPEC_FILE"; then
    echo "Adding dio dependency to pubspec.yaml..."
    (cd "$FLUTTER_PROJECT_DIR" && flutter pub add dio && flutter pub get)
    echo "✅ dio dependency added to pubspec.yaml."
  else
    echo "dio dependency already exists in pubspec.yaml."
  fi
  cat <<EOL > "$DEPENDENCY_INJECTION_FILE"
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../networking/api_service.dart';
import '../networking/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));
}

EOL

 echo "📄 Created dependency_injection.dart file successfully at $DEPENDENCY_INJECTION_FILE"
 echo "✅ Dependency injection template generated successfully."
}

export -f create_dependency_injection
