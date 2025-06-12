#!/bin/bash

function create_shared_preferences(){
 DEST_DIR="${FLUTTER_PROJECT_DIR}/lib/core/helpers"
 SHARED_PREFS_FILE="$DEST_DIR/shared_pref_helper.dart"
  # check if shared_preferences dependency is in pubspec.yaml
  PUBSPEC_FILE="${FLUTTER_PROJECT_DIR}/pubspec.yaml"
  if ! grep -q "shared_preferences:" "$PUBSPEC_FILE"; then
    echo "Adding shared_preferences dependency to pubspec.yaml..."
    (cd "$FLUTTER_PROJECT_DIR" && flutter pub add shared_preferences && flutter pub get)
    echo "✅ shared_preferences dependency added to pubspec.yaml."
  else
    echo "shared_preferences dependency already exists in pubspec.yaml."
  fi
  cat <<EOL > "$SHARED_PREFS_FILE"
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  // private constructor as I don't want to allow creating an instance of this class itself.
  SharedPrefHelper._();

  /// Removes a value from SharedPreferences with given [key].
  static removeData(String key) async {
    debugPrint('SharedPrefHelper : data with key : \$key has been removed');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }

  /// Removes all keys and values in the SharedPreferences
  static clearAllData() async {
    debugPrint('SharedPrefHelper : all data has been cleared');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  /// Saves a [value] with a [key] in the SharedPreferences.
  static setData(String key, value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    debugPrint("SharedPrefHelper : setData with key : \$key and value : \$value");
    if (value is String) {
        await sharedPreferences.setString(key, value);
    } else if (value is int) {
        await sharedPreferences.setInt(key, value);
    } else if (value is bool) {
        await sharedPreferences.setBool(key, value);
    } else if (value is double) {
        await sharedPreferences.setDouble(key, value);
    } else {
        return null;
    }
  }

  /// Gets a bool value from SharedPreferences with given [key].
  static getBool(String key) async {
    debugPrint('SharedPrefHelper : getBool with key : \$key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key) ?? false;
  }

  /// Gets a double value from SharedPreferences with given [key].
  static getDouble(String key) async {
    debugPrint('SharedPrefHelper : getDouble with key : \$key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(key) ?? 0.0;
  }

  /// Gets an int value from SharedPreferences with given [key].
  static getInt(String key) async {
    debugPrint('SharedPrefHelper : getInt with key : \$key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(key) ?? 0;
  }

  /// Gets an String value from SharedPreferences with given [key].
  static getString(String key) async {
    debugPrint('SharedPrefHelper : getString with key : \$key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key) ?? '';
  }

}

EOL

 echo "📄 Created shared_pref_helper.dart file successfully at $SHARED_PREFS_FILE"
 echo "✅ Shared Preferences template generated successfully."
}

export -f create_shared_preferences
