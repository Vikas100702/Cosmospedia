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
      )..add(const LoadRoverData(roverName: 'curiosity')),
      child: const RoverScreenView(),
    );
  }
}