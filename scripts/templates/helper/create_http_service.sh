#!/bin/bash

function create_http_service() {
  DEST_DIR="${FLUTTER_PROJECT_DIR}/lib/core/networking"
  HTTP_SERVICE_FILE="$DEST_DIR/http_service.dart"
  cat <<EOL > "$HTTP_SERVICE_FILE"
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  final String baseUrl;

  HttpService({required this.baseUrl});

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse('\$baseUrl\$endpoint');

    try {
      final response = await http.get(url, headers: headers);
      return _processResponse(response);
    } catch (e) {
      throw Exception('GET request error: \$e');
    }
  }

  Future<dynamic> post(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final url = Uri.parse('\$baseUrl\$endpoint');

    try {
      final response = await http.post(
        url,
        headers: _addJsonHeader(headers),
        body: jsonEncode(body),
      );
      return _processResponse(response);
    } catch (e) {
      throw Exception('POST request error: \$e');
    }
  }

  Future<dynamic> put(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final url = Uri.parse('\$baseUrl\$endpoint');

    try {
      final response = await http.put(
        url,
        headers: _addJsonHeader(headers),
        body: jsonEncode(body),
      );
      return _processResponse(response);
    } catch (e) {
      throw Exception('PUT request error: \$e');
    }
  }

  Future<dynamic> delete(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('\$baseUrl\$endpoint');

    try {
      final response = await http.delete(url, headers: headers);
      return _processResponse(response);
    } catch (e) {
      throw Exception('DELETE request error: \$e');
    }
  }

  dynamic _processResponse(http.Response response) {
    final statusCode = response.statusCode;
    final body = response.body;

    if (statusCode >= 200 && statusCode < 300) {
      return jsonDecode(body);
    } else {
      throw Exception('HTTP error [\$statusCode]: \${response.reasonPhrase}');
    }
  }

  Map<String, String> _addJsonHeader(Map<String, String>? headers) {
    return {'Content-Type': 'application/json', ...?headers};
  }
}

EOL

  echo "📄 Created http_service.dart file successfully at $HTTP_SERVICE_FILE"
  echo "✅ HTTP service template generated successfully."
}

export -f create_http_service
