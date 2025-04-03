import 'package:cosmospedia/utils/size_config.dart';
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
                Icons.calendar_today,
                "Mars Rover",
                state.currentScreen == CurrentScreen.marsRover,
                    () => context.read<HomeBloc>().add(SwitchScreen(CurrentScreen.marsRover)),
              ),
              buildNavigationItem(
                context,
                Icons.cloud,
                "Weather",
                state.currentScreen == CurrentScreen.weather,
                    () => context.read<HomeBloc>().add(SwitchScreen(CurrentScreen.weather)),
              ),
              SizedBox(width: SizeConfig.width(1)),
              buildNavigationItem(
                context,
                Icons.map,
                "Map",
                state.currentScreen == CurrentScreen.map,
                    () => context.read<HomeBloc>().add(SwitchScreen(CurrentScreen.map)),
              ),
              buildNavigationItem(
                context,
                Icons.settings,
                "Settings",
                state.currentScreen == CurrentScreen.settings,
                    () => context.read<HomeBloc>().add(SwitchScreen(CurrentScreen.settings)),
              ),
            ],
          ),
        );
      },
    );
  }
}