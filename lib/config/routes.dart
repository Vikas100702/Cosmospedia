import 'package:cosmospedia/ui/screens/rover_screen/rover_screen.dart';
import 'package:flutter/material.dart';

import '../ui/screens/home_screen/home_screen.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case '/rovers':
        return MaterialPageRoute(
          builder: (_) => const RoverScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
