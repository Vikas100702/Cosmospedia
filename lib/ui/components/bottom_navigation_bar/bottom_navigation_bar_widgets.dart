import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/size_config.dart';

Widget buildNavigationItem(
    BuildContext context,
    IconData icon,
    String label,
    bool isActive,
    VoidCallback onTap,
    ) {

  SizeConfig.init(context);

  return GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isActive ? AppColors.backgroundLight : Colors.white,
          size: SizeConfig.devicePixelRatio(24),
        ),
        SizedBox(height: SizeConfig.devicePixelRatio(0.5)),
        Text(
          label,
          style: TextStyle(
            color: isActive ? AppColors.backgroundLight : Colors.white,
            fontSize: SizeConfig.devicePixelRatio(12),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}