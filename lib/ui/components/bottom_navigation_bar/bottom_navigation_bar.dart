/*
import 'package:cosmospedia/ui/screens/rover_screen/rover_screen.dart';
import 'package:cosmospedia/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/home/home_bloc.dart';
import '../../../blocs/home/home_event.dart';
import '../../../blocs/home/home_state.dart';
import '../../../utils/app_colors.dart';
import 'bottom_navigation_bar_widgets.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: AppColors.bottomNavColor,
          notchMargin: SizeConfig.width(1.5),
          height: SizeConfig.height(8.35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildNavigationItem(
                context,
                Icons.rocket_launch_rounded,
                "Mars Rover",
                state.currentScreen == CurrentScreen.marsRover,
                () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RoverScreen()));
                  // context
                  //     .read<HomeBloc>()
                  //     .add(SwitchScreen(CurrentScreen.marsRover));
                },
              ),
              buildNavigationItem(
                context,
                Icons.cloud,
                "Weather",
                state.currentScreen == CurrentScreen.weather,
                () => context
                    .read<HomeBloc>()
                    .add(SwitchScreen(CurrentScreen.weather)),
              ),
              SizedBox(width: SizeConfig.width(1)),
              buildNavigationItem(
                context,
                Icons.map,
                "Map",
                state.currentScreen == CurrentScreen.map,
                () => context
                    .read<HomeBloc>()
                    .add(SwitchScreen(CurrentScreen.map)),
              ),
              buildNavigationItem(
                context,
                Icons.settings,
                "Settings",
                state.currentScreen == CurrentScreen.settings,
                () => context
                    .read<HomeBloc>()
                    .add(SwitchScreen(CurrentScreen.settings)),
              ),
            ],
          ),
        );
      },
    );
  }
}
*/

// lib/ui/components/bottom_navigation_bar/bottom_navigation_bar.dart
import 'package:cosmospedia/ui/screens/asteroids_screen/asteroids_screen.dart';
import 'package:cosmospedia/ui/screens/rover_screen/rover_screen.dart';
import 'package:cosmospedia/ui/screens/space_weather/space_weather_dashboard.dart';
import 'package:cosmospedia/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/home/home_bloc.dart';
import '../../../blocs/home/home_event.dart';
import '../../../blocs/home/home_state.dart';
import '../../../blocs/rover/rover_bloc.dart';
import '../../../data/repositories/mars/rover_repositories.dart';
import '../../../utils/app_colors.dart';
import 'bottom_navigation_bar_widgets.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: AppColors.bottomNavColor,
          notchMargin: SizeConfig.width(1.5),
          height: SizeConfig.height(8.35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildNavigationItem(
                context,
                Icons.rocket_launch_rounded,
                "Mars Rover",
                state.currentScreen == CurrentScreen.marsRover,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        // Provide RoverBloc when navigating to RoverScreen
                        create: (context) => RoverBloc(
                          roverRepository: context.read<RoverRepository>(),
                        )..add(const LoadRoverData(roverName: 'curiosity')),
                        child: const RoverScreen(),
                      ),
                    ),
                  );
                  context
                      .read<HomeBloc>()
                      .add(SwitchScreen(CurrentScreen.marsRover));
                },
              ),
              buildNavigationItem(
                context,
                Icons.cloud_circle,
                "Asteroids",
                state.currentScreen == CurrentScreen.asteroids,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AsteroidsScreen(),
                  ),
                ),
              ),
              SizedBox(width: SizeConfig.width(1)),
              buildNavigationItem(
                context,
                Icons.cloud,
                "Weather",
                state.currentScreen == CurrentScreen.weather,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SpaceWeatherDashboard(),
                  ),
                ),
              ),
              buildNavigationItem(
                context,
                Icons.settings,
                "Settings",
                state.currentScreen == CurrentScreen.settings,
                () => context
                    .read<HomeBloc>()
                    .add(SwitchScreen(CurrentScreen.settings)),
              ),
            ],
          ),
        );
      },
    );
  }
}
