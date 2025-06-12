#!/bin/bash

function create_cached_network_image(){
 DEST_DIR="${FLUTTER_PROJECT_DIR}/lib/core/helpers"
 CACHED_IMG_FILE="$DEST_DIR/cached_image.dart"
  # check if cached_network_image dependency is in pubspec.yaml
  PUBSPEC_FILE="${FLUTTER_PROJECT_DIR}/pubspec.yaml"
  if ! grep -q "cached_network_image:" "$PUBSPEC_FILE"; then
    echo "Adding cached_network_image dependency to pubspec.yaml..."
    (cd "$FLUTTER_PROJECT_DIR" && flutter pub add cached_network_image && flutter pub get)
    echo "✅ cached_network_image dependency added to pubspec.yaml."
  else
    echo "cached_network_image dependency already exists in pubspec.yaml."
  fi
  cat <<EOL > "$CACHED_IMG_FILE"
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final BorderRadius? borderRadius;

  const CachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final image = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) =>
          placeholder ?? Center(child: CircularProgressIndicator.adaptive()),
      errorWidget: (context, url, error) =>
          errorWidget ??
          Center(child: Icon(Icons.error, color: Colors.red, size: 32)),
    );
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: image,
    );
  }
}

EOL
 echo "📄 Created cached_image.dart file successfully at $CACHED_IMG_FILE"
 echo "✅ Cached image template generated successfully."
}

export -f create_cached_network_image
