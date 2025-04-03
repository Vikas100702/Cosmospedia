import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color textColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;

  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.textColor = AppColors.backgroundLight,
    this.textStyle,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: padding,
      ),
      child: Text(
        text,
        style: textStyle ??
            TextStyle(
              color: textColor,
            ),
      ),
    );
  }
}
