import 'package:cosmospedia/data/repositories/mars/rover_repositories.dart';
import 'package:cosmospedia/ui/screens/rover_screen/rover_details_screen/rover_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/rover/rover_bloc.dart';
import '../../../l10n/app_localizations.dart';

class RoverScreen extends StatelessWidget {
  const RoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocProvider(
      create: (context) {
        // Create the RoverBloc with the repository
        final bloc = RoverBloc(
          roverRepository: context.read<RoverRepository>(),
        );

        // Add the initial event with explicit parameters
        bloc.add(const LoadRoverData(
          roverName: 'curiosity',
          sol: 1000, // Using a default sol value that will have photos
        ));

        return bloc;
      },
      child: RoverDetailsScreen(roverName: l10n!.curiosity),
    );
  }
}