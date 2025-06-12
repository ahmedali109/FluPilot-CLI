#!/bin/bash

function onBoarding_Screen(){
  DEST_DIR="${FLUTTER_PROJECT_DIR}/lib/features/onboarding"
  ONBOARDING_FILE="$DEST_DIR/onboarding_screen.dart"
  # check if introduction_screen and shared_preferences dependency is in pubspec.yaml
  PUBSPEC_FILE="${FLUTTER_PROJECT_DIR}/pubspec.yaml"
  if ! grep -q "introduction_screen:" "$PUBSPEC_FILE"; then
    echo "Adding introduction_screen dependency to pubspec.yaml..."
    (cd "$FLUTTER_PROJECT_DIR" && flutter pub add introduction_screen && flutter pub get)
    echo "✅ introduction_screen dependency added to pubspec.yaml."
  else
    echo "introduction_screen dependency already exists in pubspec.yaml."
  fi
  if ! grep -q "shared_preferences:" "$PUBSPEC_FILE"; then
    echo "Adding shared_preferences dependency to pubspec.yaml..."
    (cd "$FLUTTER_PROJECT_DIR" && flutter pub add shared_preferences && flutter pub get)
    echo "✅ shared_preferences dependency added to pubspec.yaml."
  else
    echo "shared_preferences dependency already exists in pubspec.yaml."
  fi

  cat <<EOL > "$ONBOARDING_FILE"
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  static List<PageViewModel> onboardingList = [
    PageViewModel(
      title: "Welcome to Our App",
      body: "Discover amazing features and functionalities.",
      image: Center(child: Image.asset("assets/images/onboarding1.png" , width: 300)),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 18),
      ),
    ),
    PageViewModel(
      title: "Stay Connected",
      body: "Connect with friends and family effortlessly.",
      image: Center(child: Image.asset("assets/images/onboarding2.png" , width: 300)),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 18),
      ),
    ),
    PageViewModel(
      title: "Get Started",
      body: "Let's dive in and explore the app!",
      image: Center(child: Image.asset("assets/images/onboarding3.png" , width: 300)),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 18),
      ),
    ),
  ];
  static final _introKey = GlobalKey<IntroductionScreenState>();
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: _introKey,
      pages: onboardingList,
      // Navigate to the home page after onboarding is done
      onDone: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('onboarding_completed', true);
        if(context.mounted){
          // Navigate to the home page
        }
      },
      onSkip: () => _introKey.currentState?.skipToEnd(),
      showSkipButton: true,
      showBackButton: true,
      showNextButton: true,
      showDoneButton: true,
      done: const Text("Done", style: TextStyle(fontSize: 18 , color: Colors.blueAccent)),
      skip: const Text("Skip", style: TextStyle(fontSize: 18 , color: Colors.blueAccent)),
      next: const Text("Next", style: TextStyle(fontSize: 18 , color: Colors.blueAccent)),
      back: const Text("Back", style: TextStyle(fontSize: 18 , color: Colors.blueAccent)),
      dotsDecorator: DotsDecorator(
        size: const Size(10.0, 10.0),
        activeSize: const Size(30.0, 10.0),
        activeColor: Colors.lightBlue,
        color: Colors.indigo,
        spacing: const EdgeInsets.symmetric(horizontal: 5.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}

EOL

  echo "📄 Created on_boarding_screen.dart file successfully at $ONBOARDING_FILE"
  echo "✅ Onboarding screen template generated successfully."
}

export -f onBoarding_Screen
