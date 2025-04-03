import 'dart:ui';

import 'package:cosmospedia/utils/app_colors.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color backGroundColor;
  final Color textColor;
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final Widget? icon;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backGroundColor = AppColors.backgroundLight,
    this.textColor = AppColors.textPrimaryLight,
    this.width,
    this.height,
    this.borderRadius = 12,
    this.padding,
    this.textStyle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backGroundColor,
          foregroundColor: textColor,
          padding: padding ?? const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text,
                    style: textStyle ??
                        const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  icon!
                ],
              )
            : Text(
                text,
                style: textStyle ??
                    const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
              ),
      ),
    );
  }
}
