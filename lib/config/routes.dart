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
      case '/missions':
        // return MaterialPageRoute(
        //   builder: (_) => const MissionsScreen(),
        // );
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Missions Screen - Coming Soon')),
          ),
        );
      case '/apod':
        // return MaterialPageRoute(
        //   builder: (_) => const ApodGalleryScreen(),
        // );
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('APOD Gallery - Coming Soon')),
          ),
        );
      case '/rovers':
        // return MaterialPageRoute(
        //   builder: (_) => const RoversScreen(),
        // );
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Rovers Screen - Coming Soon')),
          ),
        );
      case '/neos':
        // return MaterialPageRoute(
        //   builder: (_) => const NeosScreen(),
        // );
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('NEOs Screen - Coming Soon')),
          ),
        );
      case '/events':
        // return MaterialPageRoute(
        //   builder: (_) => const EventsScreen(),
        // );
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Events Screen - Coming Soon')),
          ),
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
