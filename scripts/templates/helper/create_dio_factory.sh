#!/bin/bash

function create_dio_factory(){
 DEST_DIR="${FLUTTER_PROJECT_DIR}/lib/core/networking"
 DIO_FACTORY_FILE="$DEST_DIR/dio_factory.dart"
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
