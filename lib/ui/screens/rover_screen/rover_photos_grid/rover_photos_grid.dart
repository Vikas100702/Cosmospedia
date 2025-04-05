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
}