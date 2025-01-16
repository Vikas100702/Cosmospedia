// lib/utils/size_config.dart


import 'package:flutter/material.dart';

class SizeConfig {
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double blockWidth = 0;
  static double blockHeight = 0;
  static double pixelRatio = 1.0;

  static void init(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    blockWidth = screenWidth / 100;
    blockHeight = screenHeight / 100;
    pixelRatio = MediaQuery.of(context).devicePixelRatio;
  }

  static double height(double heightPercentage) {
    return blockHeight * heightPercentage;
  }

  static double width(double widthPercentage) {
    return blockWidth * widthPercentage;
  }

  static double devicePixelRatio(double pixelValue) {
    return pixelValue * (screenWidth / 360); // Adjust radius based on a reference width (e.g., 360)
  }
}
