#!/bin/bash

function create_supabase_service(){
  DEST_DIR="${FLUTTER_PROJECT_DIR}/lib/core/services"
  SUPABASE_SERVICE_FILE="$DEST_DIR/supabase_service.dart"
  # check if supabase_flutter dependency is in pubspec.yaml
  PUBSPEC_FILE="${FLUTTER_PROJECT_DIR}/pubspec.yaml"
  if ! grep -q "supabase_flutter:" "$PUBSPEC_FILE"; then
    echo "Adding supabase_flutter dependency to pubspec.yaml..."
    (cd "$FLUTTER_PROJECT_DIR" && flutter pub add supabase_flutter && flutter pub get)
    echo "✅ supabase_flutter dependency added to pubspec.yaml."
  else
    echo "supabase_flutter dependency already exists in pubspec.yaml."
  fi
  cat <<EOL > "$SUPABASE_SERVICE_FILE"
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final _supabase = Supabase.instance.client.from("Add your table name here");

  SupabaseService._();

  static Future<void> init({
    required String url,
    required String anonKey,
  }) async {
    await Supabase.initialize(url: url, anonKey: anonKey);
  }

  static Future<void> addData(String body) async {
    await _supabase.insert({'body': body});
  }

  static Stream<List<Map<String, dynamic>>> getData() {
    return _supabase
        .stream(primaryKey: ['id']).order('created_at', ascending: true);
  }

  static Future<void> updateData(int id, String newContent) async {
    await _supabase.update({'body': newContent}).eq('id', id);
  }

  static Future<void> deleteData(int id) async {
    await _supabase.delete().eq('id', id);
  }

  static Future<void> uploadImageFromGallery(BuildContext context, File imageFile) async {
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final path = 'uploads/\$fileName';

    await Supabase.instance.client.storage
        .from('images')
        .upload(path, imageFile)
        .then(
          (value) => {
            if (context.mounted)
              {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Image uploaded successfully'),
                    backgroundColor: Colors.green,
                  ),
                )
              }
          },
        );
  }
}
EOL
 echo "📄 Created supabase_service.dart file successfully at $SUPABASE_SERVICE_FILE"
 echo "✅ Supabase service template generated successfully."
}

export -f create_supabase_service
