import 'package:cosmospedia/blocs/rover/rover_bloc.dart';
import 'package:cosmospedia/data/repositories/mars/rover_repositories.dart';
import 'package:cosmospedia/ui/components/custom_app_bar/custom_app_bar.dart';
import 'package:cosmospedia/ui/components/custom_buttons/custom_elevated_button/custom_elevated_button.dart';
import 'package:cosmospedia/ui/screens/rover_screen/rover_calendar_alert_dialog/rover_calendar_alert_dialog.dart';
import 'package:cosmospedia/ui/screens/rover_screen/rover_details_screen/rover_detail_row_widget/rover_detail_row_widget.dart';
import 'package:cosmospedia/ui/screens/rover_screen/rover_photos_grid/rover_photos_grid.dart';
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
                            debugPrint('Selected Date: $formattedDate');
                          }
                        },
                        text: "Browse by Earth Date",
                        width: double.infinity,
                      ),
                      const SizedBox(height: 20),
                      // In RoverDetailsScreen's build method
                      CustomElevatedButton(
                        onPressed: () async {
                          final manifest = context
                              .read<RoverManifestBloc>()
                              .state
                              .roverManifestModel;
                          if (manifest == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('No manifest data available')),
                            );
                            return;
                          }

                          // Get unique camera names using a Set
                          final uniqueCameras = <String>{};
                          for (final photo in manifest.photos) {
                            uniqueCameras.addAll(photo.cameras);
                          }

                          // Show camera selection dialog
                          final selectedCamera = await showRoverCameraDialog(
                            context: context,
                            cameras: uniqueCameras.toList(),
                          );

                          if (selectedCamera != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => RoverBloc(
                                    roverRepository:
                                        context.read<RoverRepository>(),
                                  )..add(
                                      LoadRoverData(
                                        roverName: roverName.toLowerCase(),
                                        cameraName: selectedCamera,
                                        sol: 1000,
                                      ),
                                    ),
                                  child: RoverPhotosGrid(
                                    roverName: roverName,
                                    cameraName: selectedCamera,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        text: "Browse by Camera",
                        width: double.infinity,
                      ),
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

/*Future<int?> _showSolInputDialog(BuildContext context, int maxSol) async {
    final solController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Sol Value'),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: solController,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(hintText: 'Enter Mars Sol (e.g. 1000)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a sol value';
                }
                final sol = int.tryParse(value);
                if (sol == null) {
                  return 'Please enter a valid number';
                }
                if (sol < 0) {
                  return 'Sol cannot be negative';
                }
                if (sol > maxSol) {
                  return 'Maximum sol is $maxSol';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final sol = int.tryParse(solController.text);

                if (sol != null) {
                  Navigator.pop(context, sol);
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }*/
}
