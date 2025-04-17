import 'package:cosmospedia/ui/screens/asteroids_screen/asteroids_screen.dart';
import 'package:cosmospedia/ui/screens/home_screen/home_content.dart';
import 'package:cosmospedia/ui/screens/rover_screen/rover_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/home/home_bloc.dart';
import '../../../blocs/home/home_event.dart';
import '../../../blocs/home/home_state.dart';
import '../../../l10n/app_localizations.dart';
import '../../../utils/app_colors.dart';
import '../../components/app_drawer/app_drawer.dart';
import '../../components/bottom_navigation_bar/bottom_navigation_bar.dart';
import '../../components/custom_app_bar/custom_app_bar.dart';
import '../coming_soon_screen.dart';
import 'home_tab_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    // Create a GlobalKey for the Scaffold
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        Widget currentScreen;

        switch (state.currentScreen) {
          case CurrentScreen.home:
            currentScreen = const HomeContent();
            break;
          case CurrentScreen.marsRover:
            currentScreen = const RoverScreen();
            break;
          case CurrentScreen.asteroids:
            currentScreen = const AsteroidsScreen();
            break;
          case CurrentScreen.weather:
            currentScreen = const ComingSoonScreen(title: "Space Map");
            break;
          case CurrentScreen.settings:
            currentScreen = const ComingSoonScreen(title: "Settings");
            break;
        }
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/background.png"),
            ),
          ),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: AppColors.transparentColor,
            appBar: customAppBar(
              scaffoldKey: scaffoldKey,
              context: context,
              titleWidget: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  l10n!.appName,
                  style: TextStyle(
                    color: AppColors.backgroundLight,
                    fontWeight: FontWeight.w600,
                    fontSize: screenSize.width * 0.045,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                },
              ),
            ),
            drawer: const CustomAppDrawer(),
            floatingActionButton: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 4,
                    blurRadius: 8,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                elevation: 0,
                shape: const CircleBorder(),
                onPressed: () {
                  context.read<HomeBloc>().add(SwitchScreen(CurrentScreen.home));
                },
                child: const Icon(
                  Icons.home,
                  color: Colors.black,
                  size: 38,
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: const CustomBottomNavigationBar(),
            body: SafeArea(
              bottom: false,
              child: currentScreen,
            ),
          ),
        );
      },
    );
  }
}
