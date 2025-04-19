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
import 'package:intl/intl.dart';
import '../../../blocs/home/home_bloc.dart';
import '../../../blocs/home/home_event.dart';
import '../../../blocs/home/home_state.dart';
import '../../../blocs/rover/rover_bloc.dart';
import '../../../data/repositories/mars/rover_repositories.dart';
import '../../../l10n/app_localizations.dart';
import '../../../utils/app_colors.dart';
import '../../screens/my_profile/MyProfileScreen.dart';
import '../../screens/space_weather/cme/cme_screen.dart';
import 'bottom_navigation_bar_widgets.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final l10n = AppLocalizations.of(context);

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
                () {
                  final now = DateTime.now();
                  final weekAgo = now.subtract(const Duration(days: 7));
                  final dateFormat = DateFormat('yyyy-MM-dd');

                  // Ensure dates are in correct format
                  final formattedStartDate = dateFormat.format(weekAgo);
                  final formattedEndDate = dateFormat.format(now);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CMEScreen(
                        startDate: formattedStartDate,
                        endDate: formattedEndDate,
                      ),
                    ),
                  );
                }
              ),
              buildNavigationItem(
                context,
                Icons.person,
                "My Profile",
                state.currentScreen == CurrentScreen.settings,
                    () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyProfileScreen()),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

 /* void _showSettingsMenu(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundDark.withOpacity(0.9),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.white),
                title: Text(l10n.settings, style: const TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  context.read<HomeBloc>().add(SwitchScreen(CurrentScreen.settings));
                },
              ),
             ListTile(
                leading: const Icon(Icons.language, color: Colors.white),
                title: Text("FAQs", style: const TextStyle(color: Colors.white)),
                onTap: () {
                  // Handle language change
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.list, color: Colors.white),
                title: Text(l10n.termConditions, style: const TextStyle(color: Colors.white)),
                onTap: () {
                  // Handle terms and conditions
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.privacy_tip, color: Colors.white),
                title: Text(l10n.privacyPolicy, style: const TextStyle(color: Colors.white)),
                onTap: () {
                  // Handle privacy policy
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.help, color: Colors.white),
                title: Text(l10n.helpSupport, style: const TextStyle(color: Colors.white)),
                onTap: () {
                  // Handle help and support
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title: Text(l10n.logout, style: const TextStyle(color: Colors.white)),
                onTap: () {
                  // Handle logout
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }*/
}

