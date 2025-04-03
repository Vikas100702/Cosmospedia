import 'package:flutter/material.dart';

import '../coming_soon_screen.dart';
import 'home_content.dart';

class HomeTabScreen extends StatelessWidget {
  final int currentTab;

  const HomeTabScreen({super.key, required this.currentTab});

  @override
  Widget build(BuildContext context) {
    switch (currentTab) {
      case 0: // Home
        return const ComingSoonScreen(title: "Mars Rover Explorer");
      case 1: // Mars Rover
        return const ComingSoonScreen(title: "Weather");
      case 2: // Map
        return const ComingSoonScreen(title: "Space Map");
      case 3: // Settings
        return const ComingSoonScreen(title: "Settings");
      default:
        return const HomeContent();
    }
  }
}
