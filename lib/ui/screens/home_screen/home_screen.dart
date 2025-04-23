import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../blocs/home/home_bloc.dart';
import '../../../blocs/home/home_event.dart';
import '../../../blocs/home/home_state.dart';
import '../../../l10n/app_localizations.dart';
import '../../../utils/app_colors.dart';
import '../asteroids_screen/asteroids_screen.dart';
import '../my_profile/MyProfileScreen.dart';
import '../rover_screen/rover_screen.dart';
import '../space_weather/cme/cme_screen.dart';
import 'home_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final screenSize = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    // Prepare dates for CME screen
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));
    final dateFormat = DateFormat('yyyy-MM-dd');
    final formattedStartDate = dateFormat.format(weekAgo);
    final formattedEndDate = dateFormat.format(now);

    // Define all available screens
    final List<Widget> widgetOptions = <Widget>[
      const HomeContent(), // Index 0 - Home (accessed via FAB)
      const RoverScreen(), // Index 1 - Mars Rover
      const AsteroidsScreen(), // Index 2 - Asteroids
      CMEScreen( // Index 3 - Weather
        startDate: formattedStartDate,
        endDate: formattedEndDate,
      ),
      const MyProfileScreen(), // Index 4 - My Profile
    ];

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final currentIndex = state.currentTabIndex;

        return Scaffold(
          key: scaffoldKey,
          backgroundColor: AppColors.transparentColor,
          floatingActionButton: _buildSpaceFAB(context),
          /*floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            elevation: 0,
            shape: const CircleBorder(),
            onPressed: () {
              // Navigate to HomeContent (index 0)
              context.read<HomeBloc>().add(const SwitchTab(0));
            },
            child: const Icon(
              Icons.home,
              color: Colors.black,
              size: 38,
            ),
          ),*/
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          body: IndexedStack(
            index: currentIndex,
            children: widgetOptions,
          ),
          bottomNavigationBar: _buildCosmicNavBar(context, currentIndex),
          /*bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            backgroundColor: Color(0xFF3F30A1).withOpacity(0.2),
            //fixedColor: Color(0xFFFFFFFF).withOpacity(0.2)
            elevation: 0,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.rocket_launch_rounded),
                label: 'Mars Rover',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cloud_circle),
                label: 'Asteroids',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cloud),
                label: 'Weather',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'My Profile',
              ),
            ],
            currentIndex: _getBottomNavIndex(currentIndex),
            onTap: (index) {
              // Map bottom nav index (0-3) to screen index (1-4)
              context.read<HomeBloc>().add(SwitchTab(index + 1));
            },
          ),*/
        );
      },
    );
  }

  Widget _buildSpaceFAB(BuildContext context) {
    return SizedBox(
      width: 56,
      height: 56,
      child: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () {
          context.read<HomeBloc>().add(const SwitchTab(0));
        },
        child: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF6A11CB),
                Color(0xFF2575FC),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Icon(
            Icons.home,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }

  Widget _buildCosmicNavBar(BuildContext context, int currentIndex) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.bottomNavColor,
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.8),
            Colors.black.withOpacity(0.6),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          backgroundColor: AppColors.bottomNavColor,
          elevation: 0,
          items: [
            _buildNavItem(Icons.rocket_launch, 'Mars Rover', currentIndex == 1),
            _buildNavItem(Icons.auto_awesome, 'Asteroids', currentIndex == 2),
            _buildNavItem(Icons.wb_sunny, 'Weather', currentIndex == 3),
            _buildNavItem(Icons.person, 'Profile', currentIndex == 4),
          ],
          currentIndex: _getBottomNavIndex(currentIndex),
          onTap: (index) {
            context.read<HomeBloc>().add(SwitchTab(index + 1));
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, bool isActive) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        constraints: const BoxConstraints(maxHeight: 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: isActive
              ? const LinearGradient(
            colors: [
              Color(0xFF6A11CB),
              Color(0xFF2575FC),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 19),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 8,
                color: isActive ? Colors.white : Colors.grey,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
              maxLines: 1, // Ensure text doesn't wrap
              overflow: TextOverflow.ellipsis, // Handle overflow gracefully
            ),
          ],
        ),
      ),
      label: '',
    );
  }

  // Helper method to map screen index to bottom nav index
  int _getBottomNavIndex(int screenIndex) {
    return screenIndex == 0 ? 0 : screenIndex - 1;
  }
}
