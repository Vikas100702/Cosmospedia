import 'package:cosmospedia/blocs/asteroids/asteroids_bloc.dart';
import 'package:cosmospedia/ui/components/custom_app_bar/custom_app_bar.dart';
import 'package:cosmospedia/ui/screens/asteroids_screen/asteroid_details_screen/asteroids_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/asteroids/asteroids_model.dart';
import '../../../l10n/app_localizations.dart';
import '../../../utils/app_colors.dart';

class AsteroidsScreen extends StatelessWidget {
  const AsteroidsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final screenSize = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/background.png"),
          opacity: 0.3,
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
              l10n?.asteroidsTitle ?? 'Asteroids',
              style: TextStyle(
                color: AppColors.backgroundLight,
                fontWeight: FontWeight.w600,
                fontSize: screenSize.width * 0.045,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        body: BlocBuilder<AsteroidsBloc, AsteroidsState>(
          builder: (context, state) {
            if (state is AsteroidsInitial) {
              context.read<AsteroidsBloc>().add(LoadAsteroids());
              return const Center(child: CircularProgressIndicator());
            } else if (state is AsteroidsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AsteroidsError) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else if (state is AsteroidsLoaded) {
              return _buildAsteroidsList(state.asteroids, context);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildAsteroidsList(List<Asteroid> asteroids, BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Asteroids List',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[800],
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.filter_list, color: Colors.white),
                    onPressed: () {
                      // TODO: Implement filter functionality
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: asteroids.length,
            itemBuilder: (context, index) {
              final asteroid = asteroids[index];
              return _buildAsteroidsCard(asteroid, context);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAsteroidsCard(Asteroid asteroid, BuildContext context) {
    final theme = Theme.of(context);
    final closestApproach = asteroid.closeApproachData.isNotEmpty
        ? asteroid.closeApproachData.first
        : null;

    // Determine hazard level color
    final hazardColor =
        asteroid.isPotentiallyHazardous ? Colors.red[400] : Colors.green[400];

    return GestureDetector(
      onTap: () {
        context.read<AsteroidsBloc>().add(SelectAsteroid(asteroid));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AsteroidsDetailScreen(asteroid: asteroid),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 8,
        color: Colors.white.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue[800],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.public,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          asteroid.name,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          asteroid.designation,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(color: Colors.white30, height: 24),

              // Asteroid stats
              _buildDetailRow(context, 'Diameter',
                  '${asteroid.estimatedDiameter.kilometers.min.toStringAsFixed(2)} - ${asteroid.estimatedDiameter.kilometers.max.toStringAsFixed(2)} km'),
              _buildDetailRow(context, 'Absolute Magnitude',
                  asteroid.absoluteMagnitudeH.toString()),
              _buildHazardStatusRow(context, 'Potentially Hazardous',
                  asteroid.isPotentiallyHazardous ? 'Yes' : 'No', hazardColor),

              if (closestApproach != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Closest Approach',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildDetailRow(context, 'Date', closestApproach.date),
                      _buildDetailRow(context, 'Distance',
                          '${closestApproach.missDistance.kilometers.toStringAsFixed(0)} km'),
                      _buildDetailRow(context, 'Relative Velocity',
                          '${closestApproach.relativeVelocity.kilometersPerSecond.toStringAsFixed(2)} km/s'),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHazardStatusRow(
      BuildContext context, String label, String value, Color? valueColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: valueColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
