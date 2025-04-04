import 'package:cosmospedia/ui/screens/rover_screen/rover_list_screen/rover_card_widget/rover_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/rover_manifest/rover_manifest_bloc.dart';
import '../../../../data/repositories/mars/rover_manifest_repository.dart';

class RoverListScreen extends StatelessWidget {
  const RoverListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RoverManifestBloc(
            roverManifestRepository: RoverManifestRepository(),
          ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Browse by Rover'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: const [
              RoverCardWidget(roverName: 'curiosity'),
              SizedBox(height: 16),
              RoverCardWidget(roverName: 'opportunity'),
              SizedBox(height: 16),
              RoverCardWidget(roverName: 'spirit'),
            ],
          ),
        ),
      ),
    );
  }
}