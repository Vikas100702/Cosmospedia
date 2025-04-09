/*
// lib/ui/screens/rover_screen/rover_photos_grid/rover_photos_grid.dart
import 'package:cosmospedia/blocs/rover/rover_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repositories/mars/rover_repositories.dart';

class RoverPhotosGrid extends StatelessWidget {
  final String roverName;
  final DateTime selectedDate;

  const RoverPhotosGrid({
    super.key,
    required this.roverName,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = _formatDate(selectedDate);

    return BlocProvider(
      create: (context) => RoverBloc(
        roverRepository: context.read<RoverRepository>(),
      )..add(LoadRoverData(
        roverName: roverName.toLowerCase(),
        earthDate: formattedDate,
      )),
      child: Scaffold(
        appBar: AppBar(
          title: Text('$roverName Photos - $formattedDate'),
        ),
        body: BlocBuilder<RoverBloc, RoverState>(
          builder: (context, state) {
            if (state.status == RoverStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == RoverStatus.failure) {
              return Center(child: Text(state.error ?? 'Failed to load photos'));
            }

            if (state.roverPhotos.isEmpty) {
              return const Center(child: Text('No photos available for this date'));
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Total Photos: ${state.roverPhotos.length}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1,
                    ),
                    itemCount: state.roverPhotos.length,
                    itemBuilder: (context, index) {
                      final photo = state.roverPhotos[index].photos?.first;
                      return GestureDetector(
                        onTap: () {
                          // TODO: Add photo viewer
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            photo?.imgSrc ?? '',
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(Icons.error),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}*/
/*
 */
/*


// lib/ui/screens/rover_screen/rover_photos_grid/rover_photos_grid.dart
*/
/*

*/
/*
import 'package:cosmospedia/blocs/rover/rover_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class RoverPhotosGrid extends StatelessWidget {
  final String roverName;
  final DateTime selectedDate;

  const RoverPhotosGrid({
    super.key,
    required this.roverName,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('$roverName Photos - $formattedDate'),
      ),
      body: BlocBuilder<RoverBloc, RoverState>(
        builder: (context, state) {
          if (state.status == RoverStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == RoverStatus.failure) {
            return Center(child: Text(state.error ?? 'Failed to load photos'));
          }

          final hasPhotos = state.roverPhotos.isEmpty && state.roverPhotos.any((rover) => rover.photos?.isNotEmpty ?? false);
          */
/*
 */
/*

*/
/*

*/
/*if (state.roverPhotos.isEmpty) {
            return Center(child: Text('No photos available for $formattedDate'));
          }*/
/*
 */
/*

*/
/*

*/
/*


          if (!hasPhotos) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.image_not_supported, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    'No photos available for $formattedDate',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Try loading again
                      context.read<RoverBloc>().add(LoadRoverData(
                        roverName: roverName.toLowerCase(),
                        earthDate: formattedDate,
                      ));
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total Photos: ${state.roverPhotos.length}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemCount: state.roverPhotos.length,
                  itemBuilder: (context, index) {
                    final photo = state.roverPhotos[index].photos?.first;
                    return GestureDetector(
                      onTap: () {
                        // TODO: Add photo viewer
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          photo?.imgSrc ?? '',
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(Icons.error),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}*/
/*

*/
/*


// In rover_photos_grid.dart
import 'package:cosmospedia/blocs/rover/rover_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class RoverPhotosGrid extends StatelessWidget {
  final String roverName;
  final DateTime selectedDate;

  const RoverPhotosGrid({
    super.key,
    required this.roverName,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('$roverName Photos - $formattedDate'),
      ),
      body: BlocBuilder<RoverBloc, RoverState>(
        builder: (context, state) {
          if (state.status == RoverStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == RoverStatus.failure) {
            return Center(child: Text(state.error ?? 'Failed to load photos'));
          }

          // Extract all photos from the rover models
          final photos = state.roverPhotos.expand((rover) => rover.photos ?? []).toList();

          if (photos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.image_not_supported, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    'No photos available for $formattedDate',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<RoverBloc>().add(LoadRoverData(
                        roverName: roverName.toLowerCase(),
                        earthDate: formattedDate,
                      ));
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total Photos: ${photos.length}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemCount: photos.length,
                  itemBuilder: (context, index) {
                    final photo = photos[index];
                    return GestureDetector(
                      onTap: () {
                        // TODO: Add photo viewer
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          photo.imgSrc ?? '',
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(Icons.error),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
*/
/*


// lib/ui/screens/rover_screen/rover_photos_grid/rover_photos_grid.dart
import 'package:cosmospedia/blocs/rover/rover_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/mars/rover.dart';

class RoverPhotosGrid extends StatelessWidget {
  final String roverName;
  final DateTime? selectedDate;
  final String? cameraName;

  const RoverPhotosGrid({
    super.key,
    required this.roverName,
    this.selectedDate,
    this.cameraName,
  });

  @override
  Widget build(BuildContext context) {
    String title;
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);

    if (cameraName != null) {
      title = '$roverName Photos - $cameraName';
    } else if (selectedDate != null) {
      title =
          '$roverName Photos - ${DateFormat('yyyy-MM-dd').format(selectedDate!)}';
    } else {
      title = '$roverName Photos';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocBuilder<RoverBloc, RoverState>(
        builder: (context, state) {
          if (state.status == RoverStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == RoverStatus.failure) {
            return Center(child: Text(state.error ?? 'Failed to load photos'));
          }

          // Extract all photos from all rover models
          final photos = <Photos>[];
          for (final rover in state.roverPhotos) {
            if (rover.photos != null && rover.photos!.isNotEmpty) {
              if (cameraName != null) {
                photos.addAll(rover.photos!.where(
                  (photo) => photo.camera?.name == cameraName,
                ));
              } else {
                photos.addAll(rover.photos!);
              }
            }
          }

          if (photos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.image_not_supported, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    cameraName != null
                        ? 'No photos available for $cameraName'
                        : 'No photos available for $formattedDate',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<RoverBloc>().add(LoadRoverData(
                            roverName: roverName.toLowerCase(),
                            earthDate: formattedDate,
                            cameraName: cameraName,
                          ));
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total Photos: ${photos.length}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemCount: photos.length,
                  itemBuilder: (context, index) {
                    final photo = photos[index];
                    return GestureDetector(
                      onTap: () {
                        // TODO: Add photo viewer
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          photo.imgSrc ?? '',
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(Icons.error),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
*/

import 'package:cosmospedia/blocs/rover/rover_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/mars/rover.dart';

class RoverPhotosGrid extends StatelessWidget {
  final String roverName;
  final DateTime? selectedDate;
  final String? cameraName;

  const RoverPhotosGrid({
    super.key,
    required this.roverName,
    this.selectedDate,
    this.cameraName,
  });

  @override
  Widget build(BuildContext context) {
    String title;
    if (cameraName != null) {
      title = '$roverName Photos - $cameraName';
    } else if (selectedDate != null) {
      title = '$roverName Photos - ${DateFormat('yyyy-MM-dd').format(selectedDate!)}';
    } else {
      title = '$roverName Photos';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocBuilder<RoverBloc, RoverState>(
        builder: (context, state) {
          if (state.status == RoverStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == RoverStatus.failure) {
            return Center(child: Text(state.error ?? 'Failed to load photos'));
          }

          // Extract all photos from all rover models
          final photos = <Photos>[];
          for (final rover in state.roverPhotos) {
            if (rover.photos != null) {
              for (final photo in rover.photos!) {
                if (cameraName == null ||
                    (photo.camera?.name?.toLowerCase() == cameraName?.toLowerCase())) {
                  photos.add(photo);
                }
              }
            }
          }

          if (photos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.image_not_supported, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    cameraName != null
                        ? 'No photos available for $cameraName'
                        : 'No photos available',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (cameraName != null) {
                        context.read<RoverBloc>().add(
                          LoadRoverData(
                            roverName: roverName.toLowerCase(),
                            cameraName: cameraName,
                          ),
                        );
                      } else if (selectedDate != null) {
                        context.read<RoverBloc>().add(
                          LoadRoverData(
                            roverName: roverName.toLowerCase(),
                            earthDate: DateFormat('yyyy-MM-dd').format(selectedDate!),
                          ),
                        );
                      } else {
                        context.read<RoverBloc>().add(
                          LoadRoverData(
                            roverName: roverName.toLowerCase(),
                          ),
                        );
                      }
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total Photos: ${photos.length}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemCount: photos.length,
                  itemBuilder: (context, index) {
                    final photo = photos[index];
                    return GestureDetector(
                      onTap: () {
                        // TODO: Add photo viewer
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          photo.imgSrc ?? '',
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(Icons.error),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}