import 'package:cosmospedia/data/models/asteroids/asteroids_model.dart';
import 'package:cosmospedia/l10n/app_localizations.dart';
import 'package:cosmospedia/ui/components/custom_app_bar/custom_app_bar.dart';
import 'package:cosmospedia/ui/screens/asteroids_screen/asteroid_details_screen/asteroids_detail_widgets.dart';
import 'package:cosmospedia/utils/app_colors.dart';
import 'package:cosmospedia/utils/size_config.dart';
import 'package:flutter/material.dart';

class AsteroidsDetailScreen extends StatelessWidget {
  final Asteroid asteroid;

  const AsteroidsDetailScreen({super.key, required this.asteroid});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    // Create a GlobalKey for the Scaffold
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/background.png"),
          opacity: 0.4,
        ),
      ),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.transparentColor,
        appBar: customAppBar(
          scaffoldKey: scaffoldKey,
          context: context,
          titleWidget: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              asteroid.name,
              style: TextStyle(
                color: AppColors.backgroundLight,
                fontWeight: FontWeight.w600,
                fontSize: screenSize.width * 0.045,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        body: AsteroidsDetailWidgets(asteroid: asteroid),
      ),
    );
  }
}
