import 'package:cosmospedia/data/models/mars/rover.dart';
import 'package:cosmospedia/ui/components/custom_app_bar/custom_app_bar.dart';
import 'package:cosmospedia/ui/components/custom_buttons/custom_elevated_button/custom_elevated_button.dart';
import 'package:cosmospedia/ui/screens/rover_screen/rover_calendar_alert_dialog/rover_calendar_alert_dialog.dart';
import 'package:cosmospedia/ui/screens/rover_screen/rover_details_screen/rover_detail_row_widget/rover_detail_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../blocs/rover_manifest/rover_manifest_bloc.dart';
import '../../../../data/repositories/mars/rover_manifest_repository.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../utils/app_colors.dart';
import '../rover_camera_alert_dialog/rover_camera_alert_dialog.dart';

// Updated RoverDetailsScreen with better styling
class RoverDetailsScreen extends StatelessWidget {
  final String roverName;

  const RoverDetailsScreen({super.key, required this.roverName});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    // Create a GlobalKey for the Scaffold
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocProvider(
      create: (context) => RoverManifestBloc(
        roverManifestRepository: context.read<RoverManifestRepository>(),
      )..add(LoadRoverManifest(roverName: roverName)),
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
                '$roverName Details',
                style: TextStyle(
                  color: AppColors.backgroundLight,
                  fontWeight: FontWeight.w600,
                  fontSize: screenSize.width * 0.045,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          body: BlocBuilder<RoverManifestBloc, RoverManifestState>(
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
                                    style:
                                        theme.textTheme.headlineSmall?.copyWith(
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
                              RoverDetailRowWidget(
                                  label: 'Launch Date',
                                  value: manifest.launchDate),
                              RoverDetailRowWidget(
                                  label: 'Landing Date',
                                  value: manifest.landingDate),
                              RoverDetailRowWidget(
                                  label: 'Total Photos',
                                  value: manifest.totalPhotos.toString()),
                              RoverDetailRowWidget(
                                  label: 'Max Sol',
                                  value: manifest.maxSol.toString()),
                              RoverDetailRowWidget(
                                  label: 'Max Date', value: manifest.maxDate),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomElevatedButton(
                          onPressed: () {},
                          text: "Browse by Sol",
                          width: double.infinity),
                      const SizedBox(height: 20),
                      // In RoverDetailsScreen
                      CustomElevatedButton(
                        onPressed: () async {
                          final manifest = context
                              .read<RoverManifestBloc>()
                              .state
                              .roverManifestModel;
                          final selectedDate = await showRoverCalendarDialog(
                            context: context,
                            roverName: roverName,
                            manifest: manifest,
                          );


                          if (selectedDate != null) {
                            final formattedDate =
                                DateFormat('yyyy-MM-dd').format(selectedDate);
                            // Use the selected date to fetch photos
                            // Example:
                            // context.read<RoverBloc>().add(LoadRoverPhotosByDate(
                            //   roverName: roverName,
                            //   earthDate: formattedDate,
                            // ));
                            debugPrint('Selected Date: $formattedDate');
                          }
                        },
                        text: "Browse by Earth Date",
                        width: double.infinity,
                      ),
                      const SizedBox(height: 20),
                      // In the RoverDetailsScreen widget (add this near the other buttons)
                      CustomElevatedButton(
                        onPressed: () async {
                          final manifest = context
                              .read<RoverManifestBloc>()
                              .state
                              .roverManifestModel;

                          if (manifest != null && manifest.photos.isNotEmpty) {
                            // Get all unique cameras from the manifest
                            final allCameras = manifest.photos
                                .expand((photo) => photo.cameras)
                                .toSet()
                                .toList();

                            final selectedCamera = await showRoverCameraDialog(
                              context: context,
                              cameras: allCameras,
                            );

                            if (selectedCamera != null) {
                              // Handle camera selection
                              debugPrint('Selected Camera: $selectedCamera');
                              // You can now use this to fetch photos by camera
                              // Example:
                              // context.read<RoverBloc>().add(LoadRoverPhotosByCamera(
                              //   roverName: roverName,
                              //   cameraName: selectedCamera,
                              // ));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('No camera data available')),
                            );
                          }
                        },
                        text: "Browse by Camera",
                        width: double.infinity,
                      ),

                      // Photo Manifest Section
                      /*Text(
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
                      )).toList(),*/
                    ],
                  ),
                );
              }
              return Center(
                child: Text(
                  'No data available',
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
