#!/bin/bash

function create_dependency_injection(){
 DEST_DIR="${FLUTTER_PROJECT_DIR}/lib/core/di"
 DEPENDENCY_INJECTION_FILE="$DEST_DIR/dependency_injection.dart"
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
