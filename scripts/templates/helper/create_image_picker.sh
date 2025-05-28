#!/bin/bash

function create_image_picker(){
 DEST_DIR="${FLUTTER_PROJECT_DIR}/lib/core/widgets"
  IMAGE_PICKER_FILE="$DEST_DIR/image_picker.dart"
  cat <<EOL > "$IMAGE_PICKER_FILE"
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

/// Enum for image quality presets
enum ImageQualityPreset { low, medium, high }

/// ValueNotifier to hold the selected media file (image or video)
final ValueNotifier<File?> mediaNotifier = ValueNotifier<File?>(null);

/// Utility class for picking images and videos using the image_picker package
class MediaPickerService {
  static final ImagePicker _picker = ImagePicker();

  /// Pick a single image from the gallery
  static Future<void> pickImageFromGallery({
    ImageQualityPreset quality = ImageQualityPreset.high,
  }) async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: _mapQuality(quality),
    );
    mediaNotifier.value = image != null ? File(image.path) : null;
  }

  /// Pick a single image from the camera
  static Future<void> pickImageFromCamera({
    ImageQualityPreset quality = ImageQualityPreset.high,
  }) async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: _mapQuality(quality),
    );
    mediaNotifier.value = image != null ? File(image.path) : null;
  }

  /// Pick multiple images from the gallery
  static Future<List<File>?> pickMultipleImages({
    ImageQualityPreset quality = ImageQualityPreset.high,
  }) async {
    final List<XFile> images = await _picker.pickMultiImage(
      imageQuality: _mapQuality(quality),
    );
    if (images.isNotEmpty) {
      mediaNotifier.value = File(images.first.path);
    } else {
      mediaNotifier.value = null;
    }
    return images.map((xfile) => File(xfile.path)).toList();
  }

  /// Pick a single video from the gallery
  static Future<File?> pickVideoFromGallery() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    mediaNotifier.value = video != null ? File(video.path) : null;
    return mediaNotifier.value;
  }

  /// Pick a single video from the camera
  static Future<File?> pickVideoFromCamera() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
    mediaNotifier.value = video != null ? File(video.path) : null;
    return mediaNotifier.value;
  }

  /// Pick multiple videos from the gallery (not supported by image_picker, workaround)
  /// This will return a single video, as image_picker does not support multi-video selection.
  static Future<List<File>?> pickMultipleVideos() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      mediaNotifier.value = File(video.path);
      return [File(video.path)];
    } else {
      mediaNotifier.value = null;
      return [];
    }
  }

  /// Helper to map quality enum to int value
  static int _mapQuality(ImageQualityPreset quality) {
    switch (quality) {
      case ImageQualityPreset.low:
        return 25;
      case ImageQualityPreset.medium:
        return 60;
      case ImageQualityPreset.high:
        return 100;
    }
  }
}
EOL
  echo "📄 Created image_picker.dart file successfully at $IMAGE_PICKER_FILE"
  echo "✅ Image picker template generated successfully."
}

export -f create_image_picker
