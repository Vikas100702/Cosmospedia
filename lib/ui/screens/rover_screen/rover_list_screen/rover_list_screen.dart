import 'package:cosmospedia/l10n/app_localizations.dart';
import 'package:cosmospedia/ui/screens/rover_screen/rover_list_screen/rover_card_widget/rover_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/rover_manifest/rover_manifest_bloc.dart';
import '../../../../data/repositories/mars/rover_manifest_repository.dart';
import '../../../../utils/app_colors.dart';
import '../../../components/custom_app_bar/custom_app_bar.dart';

class RoverListScreen extends StatelessWidget {
  const RoverListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final screenSize = MediaQuery.of(context).size;

    // Create a GlobalKey for the Scaffold
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RoverManifestBloc(
            roverManifestRepository: RoverManifestRepository(),
          ),
        ),
      ],
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/background.png"),
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
              l10n!.browseByRover,
              style: TextStyle(
                color: AppColors.backgroundLight,
                fontWeight: FontWeight.w600,
                fontSize: screenSize.width * 0.045,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                BlocProvider.value(
                  value: RoverManifestBloc(
                    roverManifestRepository: RoverManifestRepository(),
                  )..add(LoadRoverManifest(roverName: l10n.curiosity)),
                  child: RoverCardWidget(roverName: l10n.curiosity),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}