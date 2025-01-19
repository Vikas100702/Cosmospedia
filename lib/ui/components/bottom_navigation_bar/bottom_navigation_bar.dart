import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/size_config.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return BottomAppBar(
      padding: EdgeInsets.zero,
      height: SizeConfig.height(8),
      color: Colors.black,
      shape: const CircularNotchedRectangle(),
      notchMargin: SizeConfig.devicePixelRatio(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: IconButton(
              icon: Icon(
                Icons.calendar_today,
                color: AppColors.surfaceLight,
                size: SizeConfig.devicePixelRatio(28),
              ),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: IconButton(
              icon: Icon(
                Icons.cloud_outlined,
                color: AppColors.surfaceLight,
                size: SizeConfig.devicePixelRatio(28),
              ),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: SizedBox(width: SizeConfig.width(8)),
          ),
          Expanded(
            child: IconButton(
              icon: Icon(
                Icons.edit_outlined,
                color: AppColors.surfaceLight,
                size: SizeConfig.devicePixelRatio(28),
              ),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: IconButton(
              icon: Icon(
                Icons.photo_library_outlined,
                color: AppColors.surfaceLight,
                size: SizeConfig.devicePixelRatio(28),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

// In your HomeScreen.dart, update the FloatingActionButton:
