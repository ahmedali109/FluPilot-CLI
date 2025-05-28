#!/bin/bash

function create_google_nav_bar(){
   DEST_DIR="${FLUTTER_PROJECT_DIR}/lib/core/widgets"
  GOOGLE_NAV_BAR_FILE="$DEST_DIR/google_navbar.dart"
  cat <<EOL > "$GOOGLE_NAV_BAR_FILE"
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class GoogleNavBar extends StatelessWidget {
  const GoogleNavBar({
    super.key,
    required this.selectedIndex,
    this.onTabChange,
  });
  final int selectedIndex;
  final void Function(int)? onTabChange;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 10,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 20),
          child: GNav(
            backgroundColor: Colors.black,
            activeColor: Colors.white,
            color: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            iconSize: 24,
            padding: const EdgeInsets.all(16),
            gap: 8,
            tabs: [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.favorite, text: 'Likes'),
              GButton(icon: Icons.search, text: 'Search'),
              GButton(icon: Icons.settings, text: 'Settings'),
            ],
            selectedIndex: selectedIndex,
            onTabChange: onTabChange,
          ),
        ),
      );
  }
}
EOL
  echo "📄 Created google_navbar.dart file successfully at $GOOGLE_NAV_BAR_FILE"
  echo "✅ Google nav bar template generated successfully."
}

export  -f create_google_nav_bar
