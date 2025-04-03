import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/rover/rover_bloc.dart';
import '../../../../data/models/mars/rover.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../components/custom_app_bar/custom_app_bar.dart';
import '../../../components/image_slider/custom_image_slider.dart';

class RoverScreenView extends StatelessWidget {
  const RoverScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: customAppBar(
        context: context,
        title: l10n!.marsRoverExplorer,
      ),
      body: BlocBuilder<RoverBloc, RoverState>(
        builder: (context, state) {
          if (state.status == RoverStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == RoverStatus.loading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Loading Mars Rover Images..."),
                ],
              ),
            );
          }
          if (state.status == RoverStatus.failure) {
            return Center(
              child: Text(
                state.error ?? l10n.error,
                style: TextStyle(fontSize: screenSize.width * 0.04),
              ),
            );
          }
          if (state.roverPhotos.isEmpty) {
            return Center(
              child: Text(
                "No Mars Rover images available",
                style: TextStyle(fontSize: screenSize.width * 0.04),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              context.read<RoverBloc>().add(RefreshRoverData());
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: kToolbarHeight + 20),
                      buildImageSlider(
                        context,
                        _prepareRoverDataForSlider(state.roverPhotos),
                        screenSize.height * 0.4,
                        constraints,
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenSize.width * 0.04),
                        child: Text(
                          "Latest images from Mars",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
  List<Map<String, String>> _prepareRoverDataForSlider(List<RoverModel> roverPhotos) {
    return roverPhotos.map((rover) {
      final photo = rover.photos?.first;
      return {
        'url': photo?.imgSrc ?? '',
        'title': photo?.rover?.name ?? 'Mars Rover',
        'date': 'Sol ${photo?.sol} • ${photo?.earthDate}',
        'description': photo?.camera?.fullName ?? '',
      };
    }).toList();
  }
}
