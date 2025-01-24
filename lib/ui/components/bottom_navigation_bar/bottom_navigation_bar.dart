import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/size_config.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: SizeConfig.width(4),
        vertical: SizeConfig.height(2),
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width(3),
              vertical: SizeConfig.height(1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                      size: SizeConfig.devicePixelRatio(28),
                    ),
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.cloud_outlined,
                      color: Colors.white,
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
                      color: Colors.white,
                      size: SizeConfig.devicePixelRatio(28),
                    ),
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.photo_library_outlined,
                      color: Colors.white,
                      size: SizeConfig.devicePixelRatio(28),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}