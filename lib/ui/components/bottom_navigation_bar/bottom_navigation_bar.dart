/*
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: whiteColor,
      height: SizeConfig.height(7),
      shape: const CircularNotchedRectangle(),
      notchMargin: SizeConfig.devicePixelRatio(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.event),
            color: blackColor,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.cloud),
            color: blackColor,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.note_alt),
            color: blackColor,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.image),
            color: blackColor,
          ),
        ],
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/size_config.dart'; // Import the colors file

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final backgroundColor = brightness == Brightness.light
        ? AppColors.surfaceLight
        : AppColors.surfaceDark;
    final iconColor = brightness == Brightness.light
        ? AppColors.textPrimaryLight
        : AppColors.textPrimaryDark;

    return BottomAppBar(
      color: backgroundColor,
      shape: const CircularNotchedRectangle(),
      notchMargin: SizeConfig.devicePixelRatio(8),
      padding: EdgeInsets.symmetric(vertical: SizeConfig.height(1)), // Adjust the vertical padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.event),
            color: iconColor,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.cloud),
            color: iconColor,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.note_alt),
            color: iconColor,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.image),
            color: iconColor,
          ),
        ],
      ),
    );
  }
}
