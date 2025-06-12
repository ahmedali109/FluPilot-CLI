#!/bin/bash

function create_video_player_service(){
  DEST_DIR="${FLUTTER_PROJECT_DIR}/lib/core/widgets"
  VIDEO_PLAYER_SERVICE_FILE="$DEST_DIR/video_player_service.dart"
  # check if video_player dependency is in pubspec.yaml
  PUBSPEC_FILE="${FLUTTER_PROJECT_DIR}/pubspec.yaml"
  if ! grep -q "video_player:" "$PUBSPEC_FILE"; then
    echo "Adding video_player dependency to pubspec.yaml..."
    (cd "$FLUTTER_PROJECT_DIR" && flutter pub add video_player && flutter pub get)
    echo "✅ video_player dependency added to pubspec.yaml."
  else
    echo "video_player dependency already exists in pubspec.yaml."
  fi
  cat <<EOL > "$VIDEO_PLAYER_SERVICE_FILE"
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

/// Utility class for video playback using video_player package
class VideoPlayerService {
  static VideoPlayerController? _controller;
  static final ValueNotifier<int> notifier = ValueNotifier<int>(0);

  /// Initialize the video player with a network URL
  static Future<void> initializeNetwork(String url) async {
    _controller?.dispose();
    _controller = VideoPlayerController.networkUrl(Uri.parse(url));
    await _controller!.initialize();
    notifier.value++;
  }

  /// Initialize the video player with a local file path
  static Future<void> initializeFile(String filePath) async {
    _controller?.dispose();
    _controller = VideoPlayerController.file(File(filePath));
    await _controller!.initialize();
    notifier.value++;
  }

  /// Initialize the video player with an asset
  static Future<void> initializeAsset(String assetPath) async {
    _controller?.dispose();
    _controller = VideoPlayerController.asset(assetPath);
    await _controller!.initialize();
    notifier.value++;
  }

  /// Play the video
  static Future<void> play() async {
    await _controller?.play();
    notifier.value++;
  }

  /// Pause the video
  static Future<void> pause() async {
    await _controller?.pause();
    notifier.value++;
  }

  /// Seek to a specific position
  static Future<void> seekTo(Duration position) async {
    await _controller?.seekTo(position);
    notifier.value++;
  }

  /// Set looping
  static Future<void> setLooping(bool looping) async {
    await _controller?.setLooping(looping);
    notifier.value++;
  }

  /// Dispose the controller
  static Future<void> dispose() async {
    await _controller?.dispose();
    _controller = null;
    notifier.value++;
  }

  /// Get the current controller (for use in a VideoPlayer widget)
  static VideoPlayerController? get controller => _controller;
}

EOL
 echo "📄 Created video_player_service.dart file successfully at $VIDEO_PLAYER_SERVICE_FILE"
  echo "✅ Video player service template generated successfully."
}

export -f create_video_player_service
