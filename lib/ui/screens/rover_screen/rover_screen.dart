/*
import 'package:cosmospedia/data/repositories/mars/rover_repositories.dart';
import 'package:cosmospedia/ui/screens/rover_screen/rover_screen_view/rover_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/rover/rover_bloc.dart';

class RoverScreen extends StatelessWidget {
  const RoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoverBloc(
        roverRepository: context.read<RoverRepository>(),
      )..add(const LoadRoverData(roverName: 'curiosity', sol: 1000)),
      child: const RoverScreenView(),
    );
  }
}*/



import 'package:cosmospedia/data/repositories/mars/rover_repositories.dart';
import 'package:cosmospedia/ui/screens/rover_screen/rover_screen_view/rover_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/rover/rover_bloc.dart';

class RoverScreen extends StatelessWidget {
  const RoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      child: const RoverScreenView(),
    );
  }
}