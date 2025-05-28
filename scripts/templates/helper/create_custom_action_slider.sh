#!/bin/bash

function create_custom_action_slider(){
  DEST_DIR="${FLUTTER_PROJECT_DIR}/lib/core/widgets"
  ACTION_SLIDER_FILE="$DEST_DIR/custom_action_slider.dart"
  cat <<EOL > "$ACTION_SLIDER_FILE"
import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';

class CustomActionSlider extends StatelessWidget {
  const CustomActionSlider({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ActionSlider.standard(
        sliderBehavior: SliderBehavior.stretch,
        rolling: false,
        width: double.infinity,
        height: 60.0,
        toggleColor: Colors.blue,
        backgroundColor: Colors.grey.shade300,
        backgroundBorderRadius: BorderRadius.circular(5.0),
        foregroundBorderRadius: BorderRadius.circular(5.0),
        icon: const Icon(Icons.lock),
        action: (controller) async {
          controller.loading(); //starts loading animation
          await Future.delayed(const Duration(seconds: 3));
          controller.success(); //starts success animation
          await Future.delayed(const Duration(seconds: 1));
          controller.reset(); //resets the slider
        },
        child: const Center(
          child: Text(
            'Slide to complete',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
EOL
  echo "📄 Created custom_action_slider.dart file successfully at $ACTION_SLIDER_FILE"
  echo "✅ Custom action slider template generated successfully."
}
