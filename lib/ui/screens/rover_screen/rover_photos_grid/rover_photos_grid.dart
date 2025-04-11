import 'package:cosmospedia/blocs/rover/rover_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

import '../../../../blocs/favorites/favorites_bloc.dart';
import '../../../../data/models/mars/rover.dart';

class RoverPhotosGrid extends StatelessWidget {
  final String roverName;
  final String? cameraName;
  final DateTime? selectedDate;

  const RoverPhotosGrid({
    super.key,
    required this.roverName,
    this.cameraName,
    this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    String title;
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
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              // TODO: Navigate to favorites screen
            },
          ),
        ],
      ),
      body: BlocBuilder<RoverBloc, RoverState>(
        builder: (context, state) {
          if (state.status == RoverStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == RoverStatus.failure) {
            return Center(child: Text(state.error ?? 'Failed to load photos'));
          }

          // Extract all photos
          final photos = <Photos>[];
          for (final rover in state.roverPhotos) {
            if (rover.photos != null) {
              for (final photo in rover.photos!) {
                final matchesCamera = cameraName == null ||
                    (photo.camera?.name?.toLowerCase() ==
                        cameraName?.toLowerCase());

                if (matchesCamera) {
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
                        : selectedDate != null
                            ? 'No photos available for ${DateFormat('yyyy-MM-dd').format(selectedDate!)}'
                            : 'No photos available',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<RoverBloc>().add(
                            LoadRoverData(
                              roverName: roverName.toLowerCase(),
                              cameraName: cameraName,
                              earthDate: selectedDate?.toString(),
                            ),
                          );
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
                        _showPhotoDetails(context, photo);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              photo.imgSrc ?? '',
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
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
                            // Favorite icon overlay
                            Align(
                              alignment: Alignment.topRight,
                              child: BlocBuilder<FavoritesBloc, FavoritesState>(
                                builder: (context, favState) {
                                  final isFavorite =
                                      favState is FavoritesUpdated &&
                                          favState.favorites
                                              .any((fav) => fav.id == photo.id);
                                  return IconButton(
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFavorite
                                          ? Colors.red
                                          : Colors.white,
                                    ),
                                    onPressed: () {
                                      if (isFavorite) {
                                        context
                                            .read<FavoritesBloc>()
                                            .add(RemoveFavorite(photo));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Removed from favorites')),
                                        );
                                      } else {
                                        context
                                            .read<FavoritesBloc>()
                                            .add(AddFavorite(photo));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content:
                                                  Text('Added to favorites')),
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
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

  void _showPhotoDetails(BuildContext context, Photos photo) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Photo viewer
              Expanded(
                child: PhotoView(
                  imageProvider: NetworkImage(photo.imgSrc ?? ''),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Photo details
              _buildPhotoDetails(photo),

              // Action buttons
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BlocBuilder<FavoritesBloc, FavoritesState>(
                      builder: (context, state) {
                        final isLiked =
                            false; // You'll need to implement this based on your state
                        return IconButton(
                          icon: Icon(
                            Icons.thumb_up,
                            color: isLiked ? Colors.blue : Colors.grey,
                          ),
                          onPressed: () {
                            context
                                .read<FavoritesBloc>()
                                .add(ToggleLike(photo, !isLiked));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(isLiked
                                      ? 'Removed like'
                                      : 'Liked photo')),
                            );
                          },
                        );
                      },
                    ),
                    BlocBuilder<FavoritesBloc, FavoritesState>(
                      builder: (context, state) {
                        final isDisliked =
                            false; // You'll need to implement this based on your state
                        return IconButton(
                          icon: Icon(
                            Icons.thumb_down,
                            color: isDisliked ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            context
                                .read<FavoritesBloc>()
                                .add(ToggleLike(photo, false));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Disliked photo')),
                            );
                          },
                        );
                      },
                    ),
                    BlocBuilder<FavoritesBloc, FavoritesState>(
                      builder: (context, state) {
                        final isFavorite = state is FavoritesUpdated &&
                            state.favorites.any((fav) => fav.id == photo.id);
                        return IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            if (isFavorite) {
                              context
                                  .read<FavoritesBloc>()
                                  .add(RemoveFavorite(photo));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Removed from favorites')),
                              );
                            } else {
                              context
                                  .read<FavoritesBloc>()
                                  .add(AddFavorite(photo));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Added to favorites')),
                              );
                            }
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.grey),
                      onPressed: () {
                        // TODO: Implement share functionality
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Sharing photo...')),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPhotoDetails(Photos photo) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Camera: ${photo.camera?.fullName ?? 'Unknown'}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text('Earth Date: ${photo.earthDate ?? 'Unknown'}'),
          const SizedBox(height: 4),
          Text('Sol: ${photo.sol ?? 'Unknown'}'),
          const SizedBox(height: 4),
          Text('Rover: ${photo.rover?.name ?? 'Unknown'}'),
          const SizedBox(height: 4),
          Text('Status: ${photo.rover?.status ?? 'Unknown'}'),
          const SizedBox(height: 4),
          Text('Launch Date: ${photo.rover?.launchDate ?? 'Unknown'}'),
          const SizedBox(height: 4),
          Text('Landing Date: ${photo.rover?.landingDate ?? 'Unknown'}'),
        ],
      ),
    );
  }
}
