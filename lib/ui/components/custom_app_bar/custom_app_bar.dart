import 'package:cosmospedia/utils/app_colors.dart';
import 'package:cosmospedia/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar({
  required BuildContext context,
  String? title,
  Widget? titleWidget,
  Widget? leading,

  List<Widget>? actions,
  bool? centerTitle = true,
  TextStyle? textStyle,
  PreferredSizeWidget? bottom,
  GlobalKey<ScaffoldState>? scaffoldKey,
}) {
  return AppBar(
    excludeHeaderSemantics: true,
    backgroundColor: AppColors.transparentColor,
    foregroundColor: AppColors.transparentColor,
    forceMaterialTransparency: true,
    automaticallyImplyLeading: false,
    elevation: 0,
    bottom: bottom,
    actions: actions,
    leading: leading,
    centerTitle: centerTitle,
    title: title == null
        ? titleWidget
        : Text(
            title,
            style: textStyle ?? AppTextStyles.h3,
            softWrap: true,
            maxLines: 3,
          ),
  );
}
