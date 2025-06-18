#!/bin/bash

function create_dio_factory(){
 DEST_DIR="${FLUTTER_PROJECT_DIR}/lib/core/networking"
 DIO_FACTORY_FILE="$DEST_DIR/dio_factory.dart"
  # check if dio and pretty_dio_logger dependency is in pubspec.yaml
  PUBSPEC_FILE="${FLUTTER_PROJECT_DIR}/pubspec.yaml"
  if ! grep -q "dio:" "$PUBSPEC_FILE"; then
    echo "Adding dio dependency to pubspec.yaml..."
    (cd "$FLUTTER_PROJECT_DIR" && flutter pub add dio && flutter pub get)
    echo "✅ dio dependency added to pubspec.yaml."
  else
    echo "dio dependency already exists in pubspec.yaml."
  fi
  if ! grep -q "pretty_dio_logger:" "$PUBSPEC_FILE"; then
    echo "Adding pretty_dio_logger dependency to pubspec.yaml..."
    (cd "$FLUTTER_PROJECT_DIR" && flutter pub add pretty_dio_logger && flutter pub get)
    echo "✅ pretty_dio_logger dependency added to pubspec.yaml."
  else
    echo "pretty_dio_logger dependency already exists in pubspec.yaml."
  fi
  cat <<EOL > "$DIO_FACTORY_FILE"
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory._();

  static Dio? dio;

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 30);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;
      addDioHeaders();
      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioHeaders() async {
    dio?.options.headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer //Add user token here',
    };
  }

  static void setTokenIntoHeaderAfterLogin(String token) {
    dio?.options.headers = {'Authorization': 'Bearer \$token'};
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }
}
EOL

 echo "📄 Created dio_factory.dart file successfully at $DIO_FACTORY_FILE"
 echo "✅ Dio factory template generated successfully."
}

export -f create_dio_factory
