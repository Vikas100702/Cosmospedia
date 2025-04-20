import 'package:cosmospedia/blocs/rover/rover_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

import '../../../../blocs/favorites/favorites_bloc.dart';
import '../../../../data/models/mars/rover.dart';
import '../../../../utils/app_colors.dart';
import '../../../../ui/components/custom_app_bar/custom_app_bar.dart';

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

    // Create a GlobalKey for the Scaffold
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final screenSize = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/background.png"),
          opacity: 0.4,
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
              title,
              style: TextStyle(
                color: AppColors.backgroundLight,
                fontWeight: FontWeight.w600,
                fontSize: screenSize.width * 0.045,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        body: BlocBuilder<RoverBloc, RoverState>(
          builder: (context, state) {
            if (state.status == RoverStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == RoverStatus.failure) {
              return Center(
                  child: Text(state.error ?? 'Failed to load photos'));
            }

            // Extract and filter photos based on selected date
            final photos = <Photos>[];
            for (final rover in state.roverPhotos) {
              if (rover.photos != null) {
                for (final photo in rover.photos!) {
                  // Check if photo matches the selected date (if any)
                  final matchesDate = selectedDate == null ||
                      (photo.earthDate != null &&
                          photo.earthDate ==
                              DateFormat('yyyy-MM-dd').format(selectedDate!));

                  // Check if photo matches the selected camera (if any)
                  final matchesCamera = cameraName == null ||
                      (photo.camera?.name?.toLowerCase() ==
                          cameraName?.toLowerCase());

                  if (matchesCamera || matchesDate) {
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
                    const Icon(Icons.image_not_supported,
                        size: 48, color: Colors.white),
                    const SizedBox(height: 16),
                    Text(
                      cameraName != null
                          ? 'No photos available for $cameraName'
                          : selectedDate != null
                          ? 'No photos available for ${DateFormat('yyyy-MM-dd').format(selectedDate!)}'
                          : 'No photos available',
                      style: const TextStyle(fontSize: 18, color: Colors.white),
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
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
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
                                      value:
                                      loadingProgress.expectedTotalBytes !=
                                          null
                                          ? loadingProgress
                                          .cumulativeBytesLoaded /
                                          loadingProgress
                                              .expectedTotalBytes!
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
                                child:
                                BlocBuilder<FavoritesBloc, FavoritesState>(
                                  builder: (context, favState) {
                                    final isFavorite = favState
                                    is FavoritesUpdated &&
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
      ),
    );
  }

  void _showPhotoDetails(BuildContext context, Photos photo) {
    final size = MediaQuery.of(context).size;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.9),
                const Color(0xFF121212),
              ],
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                blurRadius: 12,
                spreadRadius: 2,
              )
            ],
          ),
          child: Column(
            children: [
              // Handle bar at top
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              // Photo viewer with enhanced frame
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.blue.shade700,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.2),
                          blurRadius: 15,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: PhotoView(
                        imageProvider: NetworkImage(photo.imgSrc ?? ''),
                        minScale: PhotoViewComputedScale.covered,
                        maxScale: PhotoViewComputedScale.covered * 2,
                        backgroundDecoration: const BoxDecoration(
                          color: Colors.black,
                        ),
                        loadingBuilder: (context, event) => Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.blue[300]!),
                            value: event == null
                                ? 0
                                : event.cumulativeBytesLoaded /
                                (event.expectedTotalBytes ?? 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Photo details with space theme
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.blueGrey.withOpacity(0.4),
                      width: 1,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow(
                          icon: Icons.camera_alt,
                          label: 'Camera',
                          value: photo.camera?.fullName ?? 'Unknown',
                          context: context,
                        ),
                        _buildDivider(),
                        _buildDetailRow(
                          icon: Icons.calendar_today,
                          label: 'Earth Date',
                          value: photo.earthDate ?? 'Unknown',
                          context: context,
                        ),
                        _buildDivider(),
                        _buildDetailRow(
                          icon: Icons.public,
                          label: 'Sol',
                          value: '${photo.sol ?? 'Unknown'}',
                          context: context,
                        ),
                        _buildDivider(),
                        _buildDetailRow(
                          icon: Icons.rocket,
                          label: 'Rover',
                          value: photo.rover?.name ?? 'Unknown',
                          context: context,
                        ),
                        _buildDivider(),
                        _buildDetailRow(
                          icon: Icons.info,
                          label: 'Status',
                          value: photo.rover?.status ?? 'Unknown',
                          context: context,
                        ),
                        _buildDivider(),
                        _buildDetailRow(
                          icon: Icons.launch,
                          label: 'Launch Date',
                          value: photo.rover?.launchDate ?? 'Unknown',
                          context: context,
                        ),
                        _buildDivider(),
                        _buildDetailRow(
                          icon: Icons.flight_land,
                          label: 'Landing Date',
                          value: photo.rover?.landingDate ?? 'Unknown',
                          context: context,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Action buttons
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Favorite button
                    BlocBuilder<FavoritesBloc, FavoritesState>(
                      builder: (context, state) {
                        final isFavorite = state is FavoritesUpdated &&
                            state.favorites.any((fav) => fav.id == photo.id);

                        return _buildActionButton(
                          icon: isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          label: isFavorite ? 'Favorited' : 'Favorite',
                          color: isFavorite ? Colors.red : Colors.white,
                          onPressed: () {
                            if (isFavorite) {
                              context
                                  .read<FavoritesBloc>()
                                  .add(RemoveFavorite(photo));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Removed from favorites'),
                                  backgroundColor: Colors.redAccent,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            } else {
                              context
                                  .read<FavoritesBloc>()
                                  .add(AddFavorite(photo));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Added to favorites'),
                                  backgroundColor: Colors.green,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),

                    // Share button
                    _buildActionButton(
                      icon: Icons.share,
                      label: 'Share',
                      color: Colors.white,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Sharing photo...'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),

                    // Download button
                    _buildActionButton(
                      icon: Icons.download,
                      label: 'Save',
                      color: Colors.white,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Saving image...'),
                            behavior: SnackBarBehavior.floating,
                          ),
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

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 18,
              color: Colors.blue[300],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Divider(
        color: Colors.grey[800],
        height: 1,
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}