import 'package:cosmospedia/data/models/mars/rover.dart';
import 'package:cosmospedia/ui/screens/rover_screen/rover_details_screen/rover_detail_row_widget/rover_detail_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/rover_manifest/rover_manifest_bloc.dart';
import '../../../../data/repositories/mars/rover_manifest_repository.dart';
import '../../../../l10n/app_localizations.dart';

// Updated RoverDetailsScreen with better styling
class RoverDetailsScreen extends StatelessWidget {
  final String roverName;

  const RoverDetailsScreen({super.key, required this.roverName});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => RoverManifestBloc(
        roverManifestRepository: context.read<RoverManifestRepository>(),
      )..add(LoadRoverManifest(roverName: roverName)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('$roverName Details'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[800]!, Colors.blue[600]!],
              ),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/background.png"),
            ),
          ),
          child: BlocBuilder<RoverManifestBloc, RoverManifestState>(
            builder: (context, state) {
              if (state.status == RoverManifestStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.status == RoverManifestStatus.failure) {
                return Center(child: Text(state.error ?? l10n!.error));
              }
              if (state.roverManifestModel != null) {
                final manifest = state.roverManifestModel!;
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Rover Header
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.blue[800],
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.rocket_launch,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    roverName.toUpperCase(),
                                    style: theme.textTheme.headlineSmall?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Status: ${manifest.status}',
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Mission Details Card
                      Card(
                        color: Colors.white.withOpacity(0.1),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mission Details',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              RoverDetailRowWidget(label: 'Launch Date', value: manifest.launchDate),
                              RoverDetailRowWidget(label: 'Landing Date', value: manifest.landingDate),
                              RoverDetailRowWidget(label: 'Total Photos', value: manifest.totalPhotos.toString()),
                              RoverDetailRowWidget(label: 'Max Sol', value: manifest.maxSol.toString()),
                              RoverDetailRowWidget(label: 'Max Date', value: manifest.maxDate),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Photo Manifest Section
                      Text(
                        'Photo Manifest',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Photo Manifest List
                      ...manifest.photos.map((photo) => Card(
                        color: Colors.white.withOpacity(0.1),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.camera_alt, size: 16, color: Colors.white70),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Sol ${photo.sol}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Earth Date: ${photo.earthDate}',
                                style: const TextStyle(color: Colors.white70),
                              ),
                              Text(
                                'Total Photos: ${photo.totalPhotos}',
                                style: const TextStyle(color: Colors.white70),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 4,
                                children: photo.cameras.map((camera) => Chip(
                                  label: Text(
                                    camera,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  backgroundColor: Colors.blue.withOpacity(0.2),
                                )).toList(),
                              ),
                            ],
                          ),
                        ),
                      )).toList(),
                    ],
                  ),
                );
              }
              return Center(
                child: Text(
                  'No data available',
                  style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
