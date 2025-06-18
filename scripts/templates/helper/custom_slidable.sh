#!/bin/bash

function CustomSlidable(){
  DEST_DIR="${FLUTTER_PROJECT_DIR}/lib/core/widgets"
  SLIDABLE_FILE="$DEST_DIR/custom_slidable.dart"
  # check if flutter_slidable dependency is in pubspec.yaml
  PUBSPEC_FILE="${FLUTTER_PROJECT_DIR}/pubspec.yaml"
  if ! grep -q "flutter_slidable:" "$PUBSPEC_FILE"; then
    echo "Adding flutter_slidable dependency to pubspec.yaml..."
    (cd "$FLUTTER_PROJECT_DIR" && flutter pub add flutter_slidable && flutter pub get)
    echo "✅ flutter_slidable dependency added to pubspec.yaml."
  else
    echo "flutter_slidable dependency already exists in pubspec.yaml."
  fi
  cat <<EOL > "$SLIDABLE_FILE"
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CustomSlidable extends StatelessWidget {
  const CustomSlidable({super.key , required this.child, required this.onDismissed});
  final Function() onDismissed;
  static final _key = GlobalKey();
  static void doNothing(BuildContext context) {}
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: _key,
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: onDismissed
        ),
        children: const [
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.share,
            label: 'Share',
          ),
        ],
      ),
      endActionPane: const ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
          ),
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: Color(0xFF0392CF),
            foregroundColor: Colors.white,
            icon: Icons.save,
            label: 'Save',
          ),
        ],
      ),
      child: child,
    );
  }
}
EOL
  echo "📄 Created custom_slidable.dart file successfully at $SLIDABLE_FILE"
  echo "✅ Custom slidable template generated successfully."
}

export -f CustomSlidable
