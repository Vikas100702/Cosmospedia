// lib/ui/widgets/asteroid_detail_widget.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cosmospedia/data/models/asteroids/asteroids_model.dart';
import '../../../../utils/size_config.dart';

class AsteroidDetailWidget extends StatelessWidget {
  final Asteroid asteroid;

  const AsteroidDetailWidget({
    Key? key,
    required this.asteroid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with hazard status
          _buildHeaderSection(context, asteroid),
          const SizedBox(height: 24),

          // Basic info card
          _buildInfoCard(context, asteroid),
          const SizedBox(height: 20),

          // Size comparison visualization
          _buildSizeComparison(context, asteroid),
          const SizedBox(height: 20),

          // Close approach data
          _buildApproachData(context, asteroid),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context, Asteroid asteroid) {
    final theme = Theme.of(context);
    final hazardColor = asteroid.isPotentiallyHazardous
        ? Colors.red[400]
        : Colors.green[400];

    return Row(
      children: [
        Container(
          width: SizeConfig.width(20),
          height: SizeConfig.width(20),
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
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                asteroid.designation,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: hazardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            asteroid.isPotentiallyHazardous ? 'HAZARDOUS' : 'SAFE',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context, Asteroid asteroid) {
    final theme = Theme.of(context);

    return Card(
      elevation: 8,
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Asteroid Details',
              style: theme.textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildDetailRow(
              context,
              'Absolute Magnitude',
              '${asteroid.absoluteMagnitudeH}',
              Icons.brightness_6,
            ),
            _buildDivider(),
            _buildDetailRow(
              context,
              'Estimated Diameter (min)',
              '${asteroid.estimatedDiameter.kilometers.min.toStringAsFixed(2)} km',
              Icons.straighten,
            ),
            _buildDivider(),
            _buildDetailRow(
              context,
              'Estimated Diameter (max)',
              '${asteroid.estimatedDiameter.kilometers.max.toStringAsFixed(2)} km',
              Icons.straighten,
            ),
            _buildDivider(),
            _buildDetailRow(
              context,
              'Miles Equivalent',
              '${asteroid.estimatedDiameter.miles.max.toStringAsFixed(2)} mi',
              Icons.linear_scale,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeComparison(BuildContext context, Asteroid asteroid) {
    final theme = Theme.of(context);
    final minSize = asteroid.estimatedDiameter.kilometers.min;
    final maxSize = asteroid.estimatedDiameter.kilometers.max;
    final avgSize = (minSize + maxSize) / 2;

    // Scale factor to fit the visualization in the available space
    final scaleFactor = SizeConfig.width(80) / maxSize;

    return Card(
      elevation: 8,
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Size Comparison',
              style: theme.textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  // Football field comparison
                  if (avgSize > 0.1)
                    _buildComparisonVisualization(
                      'Football Field (0.11 km)',
                      0.11,
                      avgSize,
                      scaleFactor,
                      Colors.green,
                    ),
                  const SizedBox(height: 20),
                  // Eiffel Tower comparison
                  if (avgSize > 0.3)
                    _buildComparisonVisualization(
                      'Eiffel Tower (0.33 km)',
                      0.33,
                      avgSize,
                      scaleFactor,
                      Colors.blue,
                    ),
                  const SizedBox(height: 20),
                  // Empire State comparison
                  if (avgSize > 0.44)
                    _buildComparisonVisualization(
                      'Empire State (0.44 km)',
                      0.44,
                      avgSize,
                      scaleFactor,
                      Colors.orange,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Average Diameter: ${avgSize.toStringAsFixed(2)} km',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonVisualization(
      String label,
      double comparisonSize,
      double asteroidSize,
      double scaleFactor,
      Color color,
      ) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: SizeConfig.width(3.5),
          ),
        ),
        const SizedBox(height: 8),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              height: SizeConfig.width(6),
              width: comparisonSize * scaleFactor,
              decoration: BoxDecoration(
                color: color.withOpacity(0.6),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Container(
              height: SizeConfig.width(8),
              width: asteroidSize * scaleFactor,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.red[400]!,
                    Colors.orange[400]!,
                  ],
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${comparisonSize.toStringAsFixed(2)} km',
              style: TextStyle(
                color: color,
                fontSize: SizeConfig.width(3),
              ),
            ),
            Text(
              '${asteroidSize.toStringAsFixed(2)} km',
              style: TextStyle(
                color: Colors.orange[400],
                fontSize: SizeConfig.width(3),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildApproachData(BuildContext context, Asteroid asteroid) {
    final theme = Theme.of(context);

    if (asteroid.closeApproachData.isEmpty) {
      return const SizedBox();
    }

    final closestApproach = asteroid.closeApproachData.first;

    return Card(
      elevation: 8,
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Closest Approach',
              style: theme.textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildDetailRow(
              context,
              'Date',
              closestApproach.date,
              Icons.calendar_today,
            ),
            _buildDivider(),
            _buildDetailRow(
              context,
              'Orbiting Body',
              closestApproach.orbitingBody,
              CupertinoIcons.globe,
            ),
            _buildDivider(),
            _buildDetailRow(
              context,
              'Relative Velocity',
              '${closestApproach.relativeVelocity.kilometersPerSecond.toStringAsFixed(2)} km/s',
              Icons.speed,
            ),
            _buildDivider(),
            _buildDetailRow(
              context,
              'Miss Distance (km)',
              '${closestApproach.missDistance.kilometers.toStringAsFixed(2)} km',
              Icons.space_bar,
            ),
            _buildDivider(),
            _buildDetailRow(
              context,
              'Miss Distance (lunar)',
              '${closestApproach.missDistance.lunar.toStringAsFixed(2)} lunar distances',
              Icons.zoom_out_map,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      BuildContext context,
      String label,
      String value,
      IconData icon,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
                    fontSize: SizeConfig.width(3.2),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.width(3.8),
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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Divider(
        color: Colors.grey[800],
        height: 1,
      ),
    );
  }
}