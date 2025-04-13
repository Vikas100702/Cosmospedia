/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/asteroids/asteroids_model.dart';
import '../../../../utils/size_config.dart';

class AsteroidDetailWidget extends StatelessWidget {
  final Asteroid asteroid;

  const AsteroidDetailWidget({
    Key? key,
    required this.asteroid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final closestApproach = asteroid.closeApproachData.isNotEmpty
        ? asteroid.closeApproachData.first
        : null;

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

          // Orbital and Physical Characteristics
          _buildCharacteristicsCard(context, asteroid),
          const SizedBox(height: 20),

          // Close approach data
          if (closestApproach != null) ...[
            _buildApproachData(context, asteroid, closestApproach),
            const SizedBox(height: 20),
          ],

          // All Close Approaches
          if (asteroid.closeApproachData.isNotEmpty) ...[
            _buildAllApproaches(context, asteroid),
            const SizedBox(height: 20),
          ],
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
              'NASA JPL URL',
              'https://ssd.jpl.nasa.gov/tools/sbdb_lookup.html#/?sstr=${asteroid.id}',
              Icons.link,
              isUrl: true,
            ),
            _buildDivider(),
            _buildDetailRow(
              context,
              'Absolute Magnitude',
              '${asteroid.absoluteMagnitudeH}',
              Icons.brightness_6,
            ),
            _buildDivider(),
            _buildDetailRow(
              context,
              'Designation',
              asteroid.designation,
              Icons.numbers,
            ),
            _buildDivider(),
            _buildDetailRow(
              context,
              'Potentially Hazardous',
              asteroid.isPotentiallyHazardous ? 'Yes' : 'No',
              Icons.warning,
              valueColor: asteroid.isPotentiallyHazardous
                  ? Colors.red[400]
                  : Colors.green[400],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCharacteristicsCard(BuildContext context, Asteroid asteroid) {
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
              'Physical Characteristics',
              style: theme.textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
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
            _buildDivider(),
            _buildDetailRow(
              context,
              'Feet Equivalent',
              '${asteroid.estimatedDiameter.feet.max.toStringAsFixed(2)} ft',
              Icons.height,
            ),
            _buildDivider(),
            _buildDetailRow(
              context,
              'Meters Equivalent',
              '${asteroid.estimatedDiameter.meters.max.toStringAsFixed(2)} m',
              Icons.square_foot,
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

  Widget _buildApproachData(
      BuildContext context,
      Asteroid asteroid,
      CloseApproachData closestApproach,
      ) {
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
            _buildDivider(),
            _buildDetailRow(
              context,
              'Miss Distance (astronomical)',
              '${closestApproach.missDistance.astronomical.toStringAsFixed(6)} AU',
              Icons.zoom_out_map,
            ),
            _buildDivider(),
            _buildDetailRow(
              context,
              'Miss Distance (miles)',
              '${closestApproach.missDistance.miles.toStringAsFixed(2)} miles',
              Icons.zoom_out_map,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllApproaches(BuildContext context, Asteroid asteroid) {
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
            Row(
              children: [
                Text(
                  'All Close Approaches (${asteroid.closeApproachData.length})',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...asteroid.closeApproachData.map((approach) {
              return Column(
                children: [
                  _buildApproachItem(context, approach),
                  if (approach != asteroid.closeApproachData.last)
                    _buildDivider(),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildApproachItem(BuildContext context, CloseApproachData approach) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow(
          context,
          'Date',
          approach.dateFull,
          Icons.calendar_today,
          showIcon: false,
        ),
        _buildDetailRow(
          context,
          'Velocity',
          '${approach.relativeVelocity.kilometersPerSecond.toStringAsFixed(2)} km/s',
          Icons.speed,
          showIcon: false,
        ),
        _buildDetailRow(
          context,
          'Distance',
          '${approach.missDistance.kilometers.toStringAsFixed(2)} km',
          Icons.space_bar,
          showIcon: false,
        ),
        _buildDetailRow(
          context,
          'Orbiting Body',
          approach.orbitingBody,
          CupertinoIcons.globe,
          showIcon: false,
        ),
      ],
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

  Widget _buildDetailRow(
      BuildContext context,
      String label,
      String value,
      IconData icon, {
        Color? valueColor,
        bool isUrl = false,
        bool showIcon = true,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showIcon)
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
          if (showIcon) const SizedBox(width: 12),
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
                if (isUrl)
                  InkWell(
                    onTap: () {
                      // Handle URL tap
                    },
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.blue[300],
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.width(3.8),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                else
                  Text(
                    value,
                    style: TextStyle(
                      color: valueColor ?? Colors.white,
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
}*/

import 'dart:ui';

import 'package:cosmospedia/data/models/asteroids/asteroids_model.dart';
import 'package:cosmospedia/utils/size_config.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:math';

class AsteroidsDetailWidgets extends StatelessWidget {
  final Asteroid asteroid;

  const AsteroidsDetailWidgets({
    super.key,
    required this.asteroid,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final closestApproach = asteroid.closeApproachData.isNotEmpty
        ? asteroid.closeApproachData.first
        : null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderSection(context, asteroid),
          const SizedBox(height: 24),
          _buildEnhancedSizeComparison(context, asteroid),
          const SizedBox(height: 20),
          _buildDiameterRadarChart(context, asteroid),
          const SizedBox(height: 20),
          if (asteroid.closeApproachData.length > 1)
            _buildVelocityLineChart(context, asteroid),
          if (asteroid.closeApproachData.length > 1) const SizedBox(height: 20),
          if (closestApproach != null)
            _buildMissDistanceBarChart(context, closestApproach),
          if (closestApproach != null) const SizedBox(height: 20),
          _buildOrbitVisualization(context, asteroid),
          const SizedBox(height: 20),
          _buildApproachesDataTable(context, asteroid),
        ],
      ),
    );
  }

  Widget _buildEnhancedSizeComparison(
    BuildContext context,
    Asteroid asteroid,
  ) {
    final minSize = asteroid.estimatedDiameter.kilometers.min;
    final maxSize = asteroid.estimatedDiameter.kilometers.max;
    final avgSize = (minSize + maxSize) / 2;

    const double footballField = 0.11;
    const double eiffelTower = 0.33;
    const double empireState = 0.44;
    const double burjKhalifa = 0.828;

    final comparisons = [
      {
        'name': 'Football Field',
        'size': footballField,
        'color': Colors.blue,
        'icon': Icons.sports_football
      },
      {
        'name': 'Eiffel Tower',
        'size': eiffelTower,
        'color': Colors.green,
        'icon': Icons.location_city
      },
      {
        'name': 'Empire State',
        'size': empireState,
        'color': Colors.orange,
        'icon': Icons.apartment
      },
      {
        'name': 'Burj Khalifa',
        'size': burjKhalifa,
        'color': Colors.purple,
        'icon': Icons.business
      },
    ];

    return Card(
      elevation: 8,
      color: Colors.blue.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.compare_arrows, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'Size Comparison',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const Divider(color: Colors.white30),
            const SizedBox(height: 16),
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Colors.grey[400]!, Colors.grey[700]!],
                    center: Alignment.center,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.5),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '${avgSize.toStringAsFixed(2)} km',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: comparisons.map((item) {
                final ratio = avgSize / (item['size'] as double);
                final isLarger = ratio >= 1;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            item['icon'] as IconData,
                            color: item['color'] as Color,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            (item['name'] as String),
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            width: 50,
                            alignment: Alignment.center,
                            child: Text(
                              '${ratio.toStringAsFixed(1)}x${isLarger ? ' larger' : ' smaller'}',
                              style: TextStyle(
                                color: isLarger
                                    ? Colors.red[300]
                                    : Colors.green[300],
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Expanded(
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final maxWidth = constraints.maxWidth * 0.8;
                                final referenceSize = 40.0;
                                final asteroidVisualSize = isLarger
                                    ? referenceSize * ratio
                                    : referenceSize;
                                final comparisonVisualSize = isLarger
                                    ? referenceSize
                                    : referenceSize / ratio;

                                return Stack(
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    Container(
                                      width: maxWidth,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: (item['color'] as Color)
                                            .withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: Colors.white30, width: 1),
                                      ),
                                    ),
                                    Container(
                                      width: math.min(
                                          comparisonVisualSize, maxWidth),
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: (item['color'] as Color)
                                            .withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: Colors.white30, width: 1),
                                      ),
                                    ),
                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      width: math.min(
                                          asteroidVisualSize, maxWidth),
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: Colors.white, width: 1),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Asteroid',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue.withOpacity(0.5)),
                ),
                child: RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                      text: 'Diameter Range: ',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    TextSpan(
                      text:
                          '${minSize.toStringAsFixed(2)} - ${maxSize.toStringAsFixed(2)} km',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDiameterRadarChart(
    BuildContext context,
    Asteroid asteroid,
  ) {
    final diameters = asteroid.estimatedDiameter;
    final minKm = diameters.kilometers.min;
    final maxKm = diameters.kilometers.max;
    final minMiles = diameters.miles.min;
    final maxMiles = diameters.miles.max;
    final minFeet = diameters.feet.min;
    final maxFeet = diameters.feet.max;
    final minMeters = diameters.meters.min;
    final maxMeters = diameters.meters.max;

    final maxValue =
        [maxKm, maxMiles, maxFeet, maxMeters].reduce((a, b) => a > b ? a : b);
    final normalizedMinKm = minKm / maxValue;
    final normalizedMaxKm = maxKm / maxValue;
    final normalizedMinMiles = minMiles / maxValue;
    final normalizedMaxMiles = maxMiles / maxValue;
    final normalizedMinFeet = minFeet / maxValue;
    final normalizedMaxFeet = maxFeet / maxValue;
    final normalizedMinMeters = minMeters / maxValue;
    final normalizedMaxMeters = maxMeters / maxValue;

    return Card(
      elevation: 8,
      color: Colors.blueGrey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.radar, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'Diameter in Different Units',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const Divider(color: Colors.white30),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: RadarChart(
                RadarChartData(
                  radarShape: RadarShape.polygon,
                  radarBorderData: BorderSide(color: Colors.white30, width: 1),
                  gridBorderData: BorderSide(color: Colors.white10, width: 1),
                  tickCount: 5,
                  ticksTextStyle: const TextStyle(color: Colors.transparent),
                  borderData: FlBorderData(show: false),
                  radarTouchData: RadarTouchData(
                    touchCallback: (FlTouchEvent event, response) {},
                    enabled: true,
                  ),
                  getTitle: (index, _) {
                    const titles = ['Kilometers', 'Miles', 'Meters', 'Feet'];

                    return RadarChartTitle(
                      text: titles[index],
                      angle: index * math.pi / 2,
                      // positionPercentageOffset: 0.1,
                    );
                  },
                  titlePositionPercentageOffset: 0.2,
                  titleTextStyle: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                  dataSets: [
                    RadarDataSet(
                      fillColor: Colors.blue.withOpacity(0.2),
                      borderColor: Colors.blue,
                      entryRadius: 5,
                      dataEntries: [
                        RadarEntry(value: normalizedMinKm),
                        RadarEntry(value: normalizedMinMiles),
                        RadarEntry(value: normalizedMinMeters),
                        RadarEntry(value: normalizedMinFeet),
                      ],
                      borderWidth: 2,
                    ),
                    RadarDataSet(
                      fillColor: Colors.red.withOpacity(0.2),
                      borderColor: Colors.red,
                      entryRadius: 5,
                      dataEntries: [
                        RadarEntry(value: normalizedMaxKm),
                        RadarEntry(value: normalizedMaxMiles),
                        RadarEntry(value: normalizedMaxMeters),
                        RadarEntry(value: normalizedMaxFeet),
                      ],
                      borderWidth: 2,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 8,
              children: [
                _buildLegendItem(Colors.blue, 'Minimum Diameter'),
                _buildLegendItem(Colors.red, 'Maximum Diameter'),
              ],
            ),
            const SizedBox(height: 16),
            Table(
              border: TableBorder.all(color: Colors.white30),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.white10),
                  children: [
                    _buildTableHeader('Unit'),
                    _buildTableHeader('Minimum'),
                    _buildTableHeader('Maximum'),
                  ],
                ),
                _buildTableRow('Kilometers', minKm.toStringAsFixed(2),
                    maxKm.toStringAsFixed(2)),
                _buildTableRow('Miles', minMiles.toStringAsFixed(2),
                    maxMiles.toStringAsFixed(2)),
                _buildTableRow('Meters', minMeters.toStringAsFixed(2),
                    maxMeters.toStringAsFixed(2)),
                _buildTableRow(
                    'Feet', minFeet.toStringAsFixed(2), maxFeet.toStringAsFixed(2)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVelocityLineChart(BuildContext context, Asteroid asteroid) {
    final approaches = asteroid.closeApproachData;
    final velocities =
        approaches.map((a) => a.relativeVelocity.kilometersPerSecond).toList();
    final dates = approaches.map((a) => a.date.substring(0, 10)).toList();

    return Card(
      elevation: 8,
      color: Colors.blueGrey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.speed, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'Approach Velocity Over Time',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const Divider(color: Colors.white30),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      // tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                      getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                        return touchedBarSpots.map((barSpot) {
                          final index = barSpot.x.toInt();
                          return LineTooltipItem(
                            '${dates[index]}\n${velocities[index].toStringAsFixed(2)} km/s',
                            const TextStyle(color: Colors.white),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    horizontalInterval: 5,
                    verticalInterval: 1,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.white10,
                        strokeWidth: 1,
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: Colors.white10,
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < 0 || index >= dates.length) {
                            return const SizedBox();
                          }

                          if (dates.length > 5 && index % 2 != 0) {
                            return const SizedBox();
                          }

                          return Transform.rotate(
                            angle: -math.pi / 4,
                            child: Text(
                              dates[index].substring(0, 7),
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 10,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      axisNameWidget: const Text(
                        'Velocity (km/s)',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 42,
                        interval: 5,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.white30),
                  ),
                  minX: 0,
                  maxX: velocities.length.toDouble() - 1,
                  minY: 0,
                  maxY: velocities.reduce((a, b) => a > b ? a : b) * 1.2,
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        velocities.length,
                        (index) {
                          return FlSpot(index.toDouble(), velocities[index]);
                        },
                      ),
                      isCurved: true,
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.withOpacity(0.8),
                          Colors.lightBlueAccent.withOpacity(0.8),
                        ],
                      ),
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 6,
                            color: Colors.white,
                            strokeWidth: 2,
                            strokeColor: Colors.blue,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.withOpacity(0.3),
                            Colors.blue.withOpacity(0.0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue.withOpacity(0.5)),
                ),
                child: Text(
                  'Highest Velocity: ${velocities.reduce((a, b) => a > b ? a : b).toStringAsFixed(2)} km/s',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMissDistanceBarChart(
      BuildContext context, CloseApproachData approach) {
    final km = approach.missDistance.kilometers;
    final lunar = approach.missDistance.lunar;
    final astronomical = approach.missDistance.astronomical;
    final miles = approach.missDistance.miles;

    final distances = [
      {
        'name': 'Kilometers',
        'value': km,
        'color': Colors.blue,
        'icon': Icons.straighten
      },
      {
        'name': 'Lunar',
        'value': lunar,
        'color': Colors.green,
        'icon': Icons.nightlight_round
      },
      {
        'name': 'AU',
        'value': astronomical,
        'color': Colors.orange,
        'icon': Icons.wb_sunny
      },
      {
        'name': 'Miles',
        'value': miles,
        'color': Colors.purple,
        'icon': Icons.map
      },
    ];

    distances
        .sort((a, b) => (b['value'] as double).compareTo(a['value'] as double));
    final maxValue = distances.first['value'] as double;

    return Card(
      elevation: 8,
      color: Colors.blueGrey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.social_distance, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'Miss Distance Comparison',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.calendar_today,
                          color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        approach.date.substring(0, 10),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.white30),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: maxValue * 1.1,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      // tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final item = distances[groupIndex];
                        return BarTooltipItem(
                          '${item['name']}\n${(item['value'] as double).toStringAsFixed(2)}',
                          const TextStyle(color: Colors.white),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < 0 || index >= distances.length) {
                            return const SizedBox();
                          }

                          final item = distances[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  item['icon'] as IconData,
                                  color: item['color'] as Color,
                                  size: 20,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item['name'] as String,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        reservedSize: 60,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 60,
                        getTitlesWidget: (value, meta) {
                          String text;
                          if (value >= 1000000) {
                            text = '${(value / 1000000).toStringAsFixed(1)}M';
                          } else if (value >= 1000) {
                            text = '${(value / 1000).toStringAsFixed(1)}K';
                          } else {
                            text = value.toStringAsFixed(1);
                          }
                          return Text(
                            text,
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 11,
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.white30),
                  ),
                  barGroups: List.generate(
                    distances.length,
                    (index) {
                      final item = distances[index];
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: item['value'] as double,
                            gradient: LinearGradient(
                              colors: [
                                (item['color'] as Color).withOpacity(0.7),
                                (item['color'] as Color),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                            width: 40,
                            borderRadius: BorderRadius.circular(8),
                            backDrawRodData: BackgroundBarChartRodData(
                              show: true,
                              toY: maxValue,
                              color: Colors.white.withOpacity(0.05),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
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
                    'Context:',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '• Lunar = Distance to the Moon (${lunar.toStringAsFixed(2)} lunar distances)',
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    '• AU = Astronomical Unit (${astronomical.toStringAsFixed(6)} AU)',
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    '• 1 AU = Distance from Earth to Sun (149.6 million km)',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrbitVisualization(BuildContext context, Asteroid asteroid) {
    final isHazardous = asteroid.isPotentiallyHazardous;

    return Card(
      elevation: 8,
      color: Colors.blueGrey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.track_changes, color: Colors.white),
                const SizedBox(width: 8),
                Expanded( // Added Expanded here
                  child: Text(
                    'Orbit Visualization',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.white30),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: CustomPaint(
                painter: OrbitPainter(
                  isHazardous: isHazardous,
                  asteroidName: asteroid.name,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView( // Added SingleChildScrollView for the legend items
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendItem(Colors.blue, 'Earth\'s Orbit'),
                  const SizedBox(width: 24),
                  _buildLegendItem(
                    isHazardous ? Colors.red : Colors.green,
                    '${asteroid.name} Orbit',
                  ),
                  const SizedBox(width: 24),
                  _buildLegendItem(Colors.orange, 'Intersection Point'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isHazardous
                    ? Colors.red.withOpacity(0.1)
                    : Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: isHazardous
                        ? Colors.red.withOpacity(0.3)
                        : Colors.green.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isHazardous ? Icons.warning_amber : Icons.check_circle,
                    color: isHazardous ? Colors.red[300] : Colors.green[300],
                    size: 36,
                  ),
                  const SizedBox(width: 12),
                  Flexible( // Added Flexible here
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isHazardous
                              ? 'Potentially Hazardous Asteroid'
                              : 'Non-Hazardous Asteroid',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isHazardous
                              ? 'This asteroid\'s orbit intersects Earth\'s orbit path and it is large enough to cause significant damage if impact occurs.'
                              : 'This asteroid\'s orbit does not currently pose a threat to Earth.',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApproachesDataTable(BuildContext context, Asteroid asteroid) {
    final approaches = asteroid.closeApproachData;

    return Card(
      elevation: 8,
      color: Colors.blueGrey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_month, color: Colors.white),
                const SizedBox(width: 8),
                Expanded( // Added Expanded here
                  child: Text(
                    'Close Approaches',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    approaches.length.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.white30),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width - 32,
                ),
                child: DataTable(
                  columnSpacing: 12,
                  dataRowMinHeight: 56,
                  dataRowMaxHeight: 56,
                  headingRowHeight: 56,
                  headingRowColor: WidgetStateProperty.all(Colors.white10),
                  headingTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  dataTextStyle: const TextStyle(color: Colors.white70),
                  columns: const [
                    DataColumn(
                        label: Row(
                          children: [
                            Icon(Icons.calendar_today,
                                size: 14, color: Colors.white),
                            SizedBox(width: 4),
                            Text('Date'),
                          ],
                        )),
                    DataColumn(
                      label: Row(
                        children: [
                          Icon(Icons.speed, size: 14, color: Colors.white),
                          SizedBox(width: 4),
                          Text('Velocity (km/s)'),
                        ],
                      ),
                    ),
                    DataColumn(
                      label: Row(
                        children: [
                          Icon(Icons.straighten,
                              size: 14, color: Colors.white),
                          SizedBox(width: 4),
                          Text('Distance (km)'),
                        ],
                      ),
                    ),
                    DataColumn(
                      label: Row(
                        children: [
                          Icon(Icons.public, size: 14, color: Colors.white),
                          SizedBox(width: 4),
                          Text('Orbiting Body'),
                        ],
                      ),
                    ),
                  ],
                  rows: approaches.asMap().entries.map((entry) {
                    final index = entry.key;
                    final approach = entry.value;
                    final isClosest = index == 0;

                    return DataRow(
                      color: isClosest
                          ? WidgetStateProperty.all(
                          Colors.blue.withOpacity(0.1))
                          : null,
                      cells: [
                        DataCell(
                          Text(
                            approach.date.substring(0, 10),
                            style: TextStyle(
                              color: isClosest ? Colors.white : null,
                              fontWeight: isClosest ? FontWeight.bold : null,
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
                            mainAxisSize: MainAxisSize.min, // Added this
                            children: [
                              if (index > 0 &&
                                  approach.relativeVelocity
                                      .kilometersPerSecond >
                                      approaches[index - 1]
                                          .relativeVelocity
                                          .kilometersPerSecond)
                                const Icon(Icons.arrow_upward,
                                    color: Colors.red, size: 14)
                              else if (index > 0)
                                const Icon(Icons.arrow_downward,
                                    color: Colors.green, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                approach.relativeVelocity.kilometersPerSecond
                                    .toStringAsFixed(2),
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Text(
                            _formatLargeNumber(
                                approach.missDistance.kilometers),
                            style: TextStyle(
                              color: isClosest ? Colors.white : null,
                              fontWeight: isClosest ? FontWeight.bold : null,
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
                            mainAxisSize: MainAxisSize.min, // Added this
                            children: [
                              _getBodyIcon(approach.orbitingBody),
                              const SizedBox(width: 4),
                              Text(approach.orbitingBody),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            if (approaches.isNotEmpty) const SizedBox(height: 16),
            if (approaches.isNotEmpty)
              Center(
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blue.withOpacity(0.5)),
                  ),
                  child: Text(
                    'Closest Approach: ${approaches.first.date.substring(0, 10)} (${_formatLargeNumber(approaches.first.missDistance.kilometers)} km)',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context, Asteroid asteroid) {
    final theme = Theme.of(context);
    final hazardColor =
    asteroid.isPotentiallyHazardous ? Colors.red[400] : Colors.green[400];

    return Card(
      elevation: 8,
      color: Colors.blueGrey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            AsteroidIconWidget(
              diameter: (asteroid.estimatedDiameter.kilometers.min +
                  asteroid.estimatedDiameter.kilometers.max) /
                  2,
              isHazardous: asteroid.isPotentiallyHazardous,
              size: SizeConfig.width(20),
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
                    'ID: ${asteroid.designation}',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month,
                          size: 14, color: Colors.white70),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          'first Observed: ${asteroid.closeApproachData.isNotEmpty ? _formatDate(asteroid.closeApproachData.last.date) : "Unknown"}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: hazardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: (hazardColor ?? Colors.transparent).withOpacity(0.5),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    asteroid.isPotentiallyHazardous
                        ? Icons.warning_amber_rounded
                        : Icons.verified,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    asteroid.isPotentiallyHazardous ? 'HAZARDOUS' : 'SAFE',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  TableRow _buildTableRow(String unit, String min, String max) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            unit,
            style: const TextStyle(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            min,
            style: const TextStyle(color: Colors.blue),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            max,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  String _formatLargeNumber(double number) {
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(2)}B';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(2)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(2)}K';
    } else {
      return number.toStringAsFixed(2);
    }
  }

  String _formatDate(String dateString) {
    return dateString.substring(0, 10);
  }

  Widget _getBodyIcon(String body) {
    IconData iconData;
    Color color;

    switch (body.toLowerCase()) {
      case 'earth':
        iconData = Icons.public;
        color = Colors.blue;
        break;
      case 'moon':
        iconData = Icons.nightlight_round;
        color = Colors.grey;
        break;
      case 'mars':
        iconData = Icons.circle;
        color = Colors.red;
        break;
      case 'venus':
        iconData = Icons.circle;
        color = Colors.orange;
        break;
      case 'mercury':
        iconData = Icons.circle;
        color = Colors.amber;
        break;
      case 'jupiter':
        iconData = Icons.circle;
        color = Colors.brown;
        break;
      default:
        iconData = Icons.public;
        color = Colors.grey;
    }
    return Icon(iconData, size: 14, color: color);
  }
}

extension EstimatedDiameterExtensions on EstimatedDiameter {
  double get avg => (kilometers.min + kilometers.max) / 2;
}

class AsteroidIconWidget extends StatelessWidget {
  final double diameter;
  final bool isHazardous;
  final double size;

  const AsteroidIconWidget({
    Key? key,
    required this.diameter,
    required this.isHazardous,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext) {
    final baseSize = size;
    final double iconSize =
        baseSize * math.min(1.5, math.max(0.7, (diameter / 5)));

    return Container(
      width: iconSize,
      height: iconSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: isHazardous
              ? [Colors.grey[400]!, Colors.grey[700]!, Colors.grey[900]!]
              : [Colors.grey[300]!, Colors.grey[600]!, Colors.grey[800]!],
          stops: const [0.2, 0.7, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: isHazardous
                ? Colors.red.withOpacity(0.5)
                : Colors.blue.withOpacity(0.5),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
      child: CustomPaint(
        painter: AsteroidSurfacePainter(isHazardous: isHazardous),
      ),
    );
  }
}

class AsteroidSurfacePainter extends CustomPainter {
  final bool isHazardous;
  final Random random = Random(42);

  AsteroidSurfacePainter({required this.isHazardous});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint craterPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final Paint highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 12; i++) {
      final craterSize = size.width * (0.05 + random.nextDouble() * 0.15);
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;

      canvas.drawCircle(Offset(x, y), craterSize, craterPaint);
      canvas.drawCircle(
        Offset(x - craterSize * 0.2, y - craterSize * 0.2),
        craterSize * 0.3,
        highlightPaint,
      );
    }

    final highlightGradient = RadialGradient(
      colors: [Colors.white.withOpacity(0.4), Colors.transparent],
      stops: const [0.0, 1.0],
      center: Alignment.topLeft,
      radius: 0.7,
    );

    final highlightRect = Rect.fromCircle(
      center: Offset(size.width * 0.3, size.height * 0.3),
      radius: size.width * 0.6,
    );

    canvas.drawCircle(
      Offset(size.width * 0.3, size.height * 0.3),
      size.width * 0.6,
      Paint()..shader = highlightGradient.createShader(highlightRect),
    );

    if (isHazardous) {
      final glowGradient = RadialGradient(
        colors: [Colors.red.withOpacity(0.2), Colors.transparent],
        stops: const [0.7, 1.0],
      );

      final glowRect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width * 0.8,
      );

      canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        size.width * 0.8,
        Paint()..shader = glowGradient.createShader(glowRect),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class OrbitPainter extends CustomPainter {
  final bool isHazardous;
  final String asteroidName;
  final double animationValue = 0.75;

  OrbitPainter({required this.isHazardous, required this.asteroidName});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final earthOrbitRadius = math.min(size.width, size.height) * 0.35;
    final asteroidOrbitRadiusX = earthOrbitRadius * (isHazardous ? 0.8 : 1.3);
    final asteroidOrbitRadiusY = earthOrbitRadius * (isHazardous ? 1.2 : 0.7);
    final asteroidOrbitAngle = isHazardous ? math.pi / 6 : math.pi / 4;

    final sunPaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    final sunGlowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.yellow.withOpacity(0.6),
          Colors.yellow.withOpacity(0.0)
        ],
        stops: const [0.5, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: 25));

    canvas.drawCircle(center, 25, sunGlowPaint);
    canvas.drawCircle(center, 15, sunPaint);

    final earthOrbitPaint = Paint()
      ..color = Colors.blue.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, earthOrbitRadius, earthOrbitPaint);

    final asteroidOrbitPaint = Paint()
      ..color = isHazardous
          ? Colors.red.withOpacity(0.8)
          : Colors.green.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final asteroidOrbitRect = Rect.fromCenter(
      center: center,
      width: asteroidOrbitRadiusX * 2,
      height: asteroidOrbitRadiusY * 2,
    );

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(asteroidOrbitAngle);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawOval(asteroidOrbitRect, asteroidOrbitPaint);
    canvas.restore();

    final earthAngle = 2 * math.pi * animationValue;
    final earthX = center.dx + earthOrbitRadius * math.cos(earthAngle);
    final earthY = center.dy + earthOrbitRadius * math.sin(earthAngle);
    final earthPos = Offset(earthX, earthY);

    final earthPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawCircle(earthPos, 10, earthPaint);

    final asteroidAngle = 2 * math.pi * (animationValue + 0.5);
    final asteroidX = center.dx +
        asteroidOrbitRadiusX * math.cos(asteroidAngle + asteroidOrbitAngle);
    final asteroidY = center.dy +
        asteroidOrbitRadiusY * math.sin(asteroidAngle + asteroidOrbitAngle);
    final asteroidPos = Offset(asteroidX, asteroidY);

    final asteroidPaint = Paint()
      ..color = isHazardous ? Colors.red[700]! : Colors.grey[600]!
      ..style = PaintingStyle.fill;

    canvas.drawCircle(asteroidPos, 8, asteroidPaint);

    if (isHazardous) {
      final intersectionPaint = Paint()
        ..color = Colors.orange
        ..style = PaintingStyle.fill;

      final intersectionPoint1 = _calculateIntersectionPoint(
          center,
          earthOrbitRadius,
          asteroidOrbitRadiusX,
          asteroidOrbitRadiusY,
          asteroidOrbitAngle,
          1);

      final intersectionPoint2 = _calculateIntersectionPoint(
          center,
          earthOrbitRadius,
          asteroidOrbitRadiusX,
          asteroidOrbitRadiusY,
          asteroidOrbitAngle,
          2);

      canvas.drawCircle(intersectionPoint1, 6, intersectionPaint);
      canvas.drawCircle(intersectionPoint2, 6, intersectionPaint);

      final warningPaint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      const double warningSize = 12;

      canvas.save();
      canvas.translate(intersectionPoint1.dx, intersectionPoint1.dy);
      canvas.drawPath(
        Path()
          ..moveTo(-warningSize / 2, -warningSize / 2)
          ..lineTo(warningSize / 2, warningSize / 2)
          ..moveTo(-warningSize / 2, warningSize / 2)
          ..lineTo(warningSize / 2, -warningSize / 2),
        warningPaint,
      );
      canvas.restore();

      canvas.save();
      canvas.translate(intersectionPoint2.dx, intersectionPoint2.dy);
      canvas.drawPath(
        Path()
          ..moveTo(-warningSize / 2, -warningSize / 2)
          ..lineTo(warningSize / 2, warningSize / 2)
          ..moveTo(-warningSize / 2, warningSize / 2)
          ..lineTo(warningSize / 2, -warningSize / 2),
        warningPaint,
      );
      canvas.restore();
    }

    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );

    _drawText(canvas, 'Earth', earthPos, textStyle, Colors.blue);
    _drawText(
        canvas,
        asteroidName.length > 12
            ? asteroidName.substring(0, 12) + '...'
            : asteroidName,
        asteroidPos,
        textStyle,
        isHazardous ? Colors.red : Colors.green);
    _drawText(canvas, 'Sun', center, textStyle, Colors.yellow);
  }

  void _drawText(Canvas canvas, String text, Offset position, TextStyle style,
      Color bgColor) {
    final textSpan = TextSpan(
      text: text,
      style: style,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    final bgRect = Rect.fromCenter(
      center: Offset(
        position.dx,
        position.dy + 20,
      ),
      width: textPainter.width + 8,
      height: textPainter.height + 4,
    );

    final bgPaint = Paint()
      ..color = bgColor.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final bgRRect = RRect.fromRectAndRadius(
      bgRect,
      const Radius.circular(4),
    );

    canvas.drawRRect(bgRRect, bgPaint);

    textPainter.paint(
      canvas,
      Offset(
        position.dx - textPainter.width / 2,
        position.dy + 20 - textPainter.height / 2,
      ),
    );
  }

  Offset _calculateIntersectionPoint(
      Offset center,
      double earthRadius,
      double asteroidRadiusX,
      double asteroidRadiusY,
      double asteroidAngle,
      int point) {
    final angle = (point == 1)
        ? asteroidAngle - math.pi / 4
        : asteroidAngle + math.pi / 4;

    return Offset(
      center.dx + earthRadius * math.cos(angle),
      center.dy + earthRadius * math.sin(angle),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/*import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;
import 'dart:math';

// Assuming these models exist in your project
import '../../../../data/models/asteroids/asteroids_model.dart';
import '../../../../utils/size_config.dart';

class AsteroidDetailWidget extends StatelessWidget {
  final Asteroid asteroid;

  const AsteroidDetailWidget({
    Key? key,
    required this.asteroid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final closestApproach = asteroid.closeApproachData.isNotEmpty
        ? asteroid.closeApproachData.first
        : null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderSection(context, asteroid),
          const SizedBox(height: 24),
          _buildEnhancedSizeComparison(context, asteroid),
          const SizedBox(height: 20),
          _buildDiameterRadarChart(context, asteroid),
          const SizedBox(height: 20),
          if (asteroid.closeApproachData.length > 1)
            _buildVelocityLineChart(context, asteroid),
          if (asteroid.closeApproachData.length > 1) const SizedBox(height: 20),
          if (closestApproach != null)
            _buildMissDistanceBarChart(context, closestApproach),
          if (closestApproach != null) const SizedBox(height: 20),
          _buildOrbitVisualization(context, asteroid),
          const SizedBox(height: 20),
          _buildApproachesDataTable(context, asteroid),
        ],
      ),
    );
  }

  Widget _buildEnhancedSizeComparison(BuildContext context, Asteroid asteroid) {
    final minSize = asteroid.estimatedDiameter.kilometers.min;
    final maxSize = asteroid.estimatedDiameter.kilometers.max;
    final avgSize = (minSize + maxSize) / 2;

    const double footballField = 0.11;
    const double eiffelTower = 0.33;
    const double empireState = 0.44;
    const double burjKhalifa = 0.828;

    final comparisons = [
      {'name': 'Football Field', 'size': footballField, 'color': Colors.blue, 'icon': Icons.sports_football},
      {'name': 'Eiffel Tower', 'size': eiffelTower, 'color': Colors.green, 'icon': Icons.location_city},
      {'name': 'Empire State', 'size': empireState, 'color': Colors.orange, 'icon': Icons.apartment},
      {'name': 'Burj Khalifa', 'size': burjKhalifa, 'color': Colors.purple, 'icon': Icons.business},
    ];

    return Card(
      elevation: 8,
      color: Colors.blueGrey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.compare_arrows, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'Size Comparison',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.white30),
            const SizedBox(height: 16),
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Colors.grey[400]!, Colors.grey[700]!],
                    center: Alignment.center,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.5),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '${avgSize.toStringAsFixed(2)} km',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: comparisons.map((item) {
                final ratio = avgSize / (item['size'] as double);
                final isLarger = ratio >= 1;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            item['icon'] as IconData,
                            color: item['color'] as Color,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            (item['name'] as String),
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            width: 50,
                            alignment: Alignment.center,
                            child: Text(
                              '${ratio.toStringAsFixed(1)}x' + (isLarger ? ' larger' : ' smaller'),
                              style: TextStyle(
                                color: isLarger ? Colors.red[300] : Colors.green[300],
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Expanded(
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final maxWidth = constraints.maxWidth * 0.8;
                                final referenceSize = 40.0;
                                final asteroidVisualSize = isLarger ? referenceSize * ratio : referenceSize;
                                final comparisonVisualSize = isLarger ? referenceSize : referenceSize / ratio;

                                return Stack(
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    Container(
                                      width: maxWidth,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Colors.black26,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    Container(
                                      width: math.min(comparisonVisualSize, maxWidth),
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: (item['color'] as Color).withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.white30, width: 1),
                                      ),
                                    ),
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 500),
                                      width: math.min(asteroidVisualSize, maxWidth),
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.white, width: 1),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Asteroid',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue.withOpacity(0.5)),
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Diameter Range: ',
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: '${minSize.toStringAsFixed(2)} - ${maxSize.toStringAsFixed(2)} km',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiameterRadarChart(BuildContext context, Asteroid asteroid) {
    final diameters = asteroid.estimatedDiameter;
    final minKm = diameters.kilometers.min;
    final maxKm = diameters.kilometers.max;
    final minMiles = diameters.miles.min;
    final maxMiles = diameters.miles.max;
    final minMeters = diameters.meters.min;
    final maxMeters = diameters.meters.max;
    final minFeet = diameters.feet.min;
    final maxFeet = diameters.feet.max;

    final maxValue = [maxKm, maxMiles, maxMeters, maxFeet].reduce((a, b) => a > b ? a : b);
    final normalizedMinKm = minKm / maxValue;
    final normalizedMaxKm = maxKm / maxValue;
    final normalizedMinMiles = minMiles / maxValue;
    final normalizedMaxMiles = maxMiles / maxValue;
    final normalizedMinMeters = minMeters / maxValue;
    final normalizedMaxMeters = maxMeters / maxValue;
    final normalizedMinFeet = minFeet / maxValue;
    final normalizedMaxFeet = maxFeet / maxValue;

    return Card(
      elevation: 8,
      color: Colors.blueGrey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.radar, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'Diameter in Different Units',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.white30),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: RadarChart(
                RadarChartData(
                  radarShape: RadarShape.polygon,
                  radarBorderData: BorderSide(color: Colors.white30, width: 1),
                  gridBorderData: BorderSide(color: Colors.white10, width: 1),
                  tickCount: 5,
                  ticksTextStyle: const TextStyle(color: Colors.transparent),
                  // radarBorderWidth: 2,
                  borderData: FlBorderData(show: false),
                  radarTouchData: RadarTouchData(
                    touchCallback: (FlTouchEvent event, response) {},
                    enabled: true,
                  ),
                  getTitle: (index, angle) {
                    const titles = ['Kilometers', 'Miles', 'Meters', 'Feet'];
                    return RadarChartTitle(
                      text: titles[index],
                      angle: angle,
                      // positionPercentageOffset: 0.1,
                    );
                  },
                  titlePositionPercentageOffset: 0.2,
                  titleTextStyle: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                  dataSets: [
                    RadarDataSet(
                      fillColor: Colors.blue.withOpacity(0.2),
                      borderColor: Colors.blue,
                      entryRadius: 5,
                      dataEntries: [
                        RadarEntry(value: normalizedMinKm),
                        RadarEntry(value: normalizedMinMiles),
                        RadarEntry(value: normalizedMinMeters),
                        RadarEntry(value: normalizedMinFeet),
                      ],
                      borderWidth: 2,
                    ),
                    RadarDataSet(
                      fillColor: Colors.red.withOpacity(0.2),
                      borderColor: Colors.red,
                      entryRadius: 5,
                      dataEntries: [
                        RadarEntry(value: normalizedMaxKm),
                        RadarEntry(value: normalizedMaxMiles),
                        RadarEntry(value: normalizedMaxMeters),
                        RadarEntry(value: normalizedMaxFeet),
                      ],
                      borderWidth: 2,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 8,
              children: [
                _buildLegendItem(Colors.blue, 'Minimum Diameter'),
                _buildLegendItem(Colors.red, 'Maximum Diameter'),
              ],
            ),
            const SizedBox(height: 16),
            Table(
              border: TableBorder.all(color: Colors.white30),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.white10),
                  children: [
                    _buildTableHeader('Unit'),
                    _buildTableHeader('Minimum'),
                    _buildTableHeader('Maximum'),
                  ],
                ),
                _buildTableRow('Kilometers', minKm.toStringAsFixed(2), maxKm.toStringAsFixed(2)),
                _buildTableRow('Miles', minMiles.toStringAsFixed(2), maxMiles.toStringAsFixed(2)),
                _buildTableRow('Meters', minMeters.toStringAsFixed(2), maxMeters.toStringAsFixed(2)),
                _buildTableRow('Feet', minFeet.toStringAsFixed(2), maxFeet.toStringAsFixed(2)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVelocityLineChart(BuildContext context, Asteroid asteroid) {
    final approaches = asteroid.closeApproachData;
    final velocities = approaches.map((a) => a.relativeVelocity.kilometersPerSecond).toList();
    final dates = approaches.map((a) => a.date.substring(0, 10)).toList();

    return Card(
      elevation: 8,
      color: Colors.blueGrey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.speed, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'Approach Velocity Over Time',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.white30),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                      getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                        return touchedBarSpots.map((barSpot) {
                          final index = barSpot.x.toInt();
                          return LineTooltipItem(
                            '${dates[index]}\n${velocities[index].toStringAsFixed(2)} km/s',
                            const TextStyle(color: Colors.white),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    horizontalInterval: 5,
                    verticalInterval: 1,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.white10,
                        strokeWidth: 1,
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: Colors.white10,
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < 0 || index >= dates.length) {
                            return const SizedBox();
                          }

                          if (dates.length > 5 && index % 2 != 0) {
                            return const SizedBox();
                          }

                          return Transform.rotate(
                            angle: -math.pi / 4,
                            child: Text(
                              dates[index].substring(0, 7),
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 10,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      axisNameWidget: const Text(
                        'Velocity (km/s)',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 42,
                        interval: 5,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.white30),
                  ),
                  minX: 0,
                  maxX: velocities.length.toDouble() - 1,
                  minY: 0,
                  maxY: velocities.reduce((a, b) => a > b ? a : b) * 1.2,
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(velocities.length, (index) {
                        return FlSpot(index.toDouble(), velocities[index]);
                      }),
                      isCurved: true,
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.withOpacity(0.8),
                          Colors.lightBlueAccent.withOpacity(0.8),
                        ],
                      ),
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 6,
                            color: Colors.white,
                            strokeWidth: 2,
                            strokeColor: Colors.blue,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.withOpacity(0.3),
                            Colors.blue.withOpacity(0.0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue.withOpacity(0.5)),
                ),
                child: Text(
                  'Highest Velocity: ${velocities.reduce((a, b) => a > b ? a : b).toStringAsFixed(2)} km/s',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMissDistanceBarChart(BuildContext context, CloseApproachData approach) {
    final km = approach.missDistance.kilometers;
    final lunar = approach.missDistance.lunar;
    final astronomical = approach.missDistance.astronomical;
    final miles = approach.missDistance.miles;

    final distances = [
      {'name': 'Kilometers', 'value': km, 'color': Colors.blue, 'icon': Icons.straighten},
      {'name': 'Lunar', 'value': lunar, 'color': Colors.green, 'icon': Icons.nightlight_round},
      {'name': 'AU', 'value': astronomical, 'color': Colors.orange, 'icon': Icons.wb_sunny},
      {'name': 'Miles', 'value': miles, 'color': Colors.purple, 'icon': Icons.map},
    ];

    distances.sort((a, b) => (b['value'] as double).compareTo(a['value'] as double));
    final maxValue = distances.first['value'] as double;

    return Card(
      elevation: 8,
      color: Colors.blueGrey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.social_distance, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'Miss Distance Comparison',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        approach.date.substring(0, 10),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.white30),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: maxValue * 1.1,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final item = distances[groupIndex];
                        return BarTooltipItem(
                          '${item['name']}\n${(item['value'] as double).toStringAsFixed(2)}',
                          const TextStyle(color: Colors.white),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < 0 || index >= distances.length) {
                            return const SizedBox();
                          }
                          final item = distances[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  item['icon'] as IconData,
                                  color: item['color'] as Color,
                                  size: 20,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item['name'] as String,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        reservedSize: 60,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 60,
                        getTitlesWidget: (value, meta) {
                          String text;
                          if (value >= 1000000) {
                            text = '${(value / 1000000).toStringAsFixed(1)}M';
                          } else if (value >= 1000) {
                            text = '${(value / 1000).toStringAsFixed(1)}K';
                          } else {
                            text = value.toStringAsFixed(1);
                          }
                          return Text(
                            text,
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 11,
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.white30),
                  ),
                  barGroups: List.generate(distances.length, (index) {
                    final item = distances[index];
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: item['value'] as double,
                          gradient: LinearGradient(
                            colors: [
                              (item['color'] as Color).withOpacity(0.7),
                              (item['color'] as Color),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          width: 40,
                          borderRadius: BorderRadius.circular(8),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: maxValue,
                            color: Colors.white.withOpacity(0.05),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
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
                    'Context:',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '• Lunar = Distance to the Moon (${lunar.toStringAsFixed(2)} lunar distances)',
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    '• AU = Astronomical Unit (${astronomical.toStringAsFixed(6)} AU)',
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    '• 1 AU = Distance from Earth to Sun (149.6 million km)',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrbitVisualization(BuildContext context, Asteroid asteroid) {
    final isHazardous = asteroid.isPotentiallyHazardous;

    return Card(
      elevation: 8,
      color: Colors.blueGrey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.track_changes, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'Orbit Visualization',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.white30),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: CustomPaint(
                painter: OrbitPainter(
                  isHazardous: isHazardous,
                  asteroidName: asteroid.name,
                ),
                size: Size.infinite,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem(Colors.blue, 'Earth\'s Orbit'),
                const SizedBox(width: 24),
                _buildLegendItem(
                    isHazardous ? Colors.red : Colors.green,
                    '${asteroid.name} Orbit'
                ),
                const SizedBox(width: 24),
                _buildLegendItem(Colors.orange, 'Intersection Point'),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isHazardous ? Colors.red.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: isHazardous ? Colors.red.withOpacity(0.3) : Colors.green.withOpacity(0.3)
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isHazardous ? Icons.warning_amber : Icons.check_circle,
                    color: isHazardous ? Colors.red[300] : Colors.green[300],
                    size: 36,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isHazardous ? 'Potentially Hazardous Asteroid' : 'Non-Hazardous Asteroid',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isHazardous
                              ? 'This asteroid\'s orbit intersects Earth\'s orbit path and it is large enough to cause significant damage if impact occurs.'
                              : 'This asteroid\'s orbit does not currently pose a threat to Earth.',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApproachesDataTable(BuildContext context, Asteroid asteroid) {
    final approaches = asteroid.closeApproachData;

    return Card(
      elevation: 8,
      color: Colors.blueGrey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_month, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'Close Approaches',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    approaches.length.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.white30),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white30),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 12,
                    dataRowHeight: 56,
                    headingRowColor: MaterialStateProperty.all(Colors.white10),
                    headingTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    dataTextStyle: const TextStyle(color: Colors.white70),
                    columns: const [
                      DataColumn(
                        label: Row(
                          children: [
                            Icon(Icons.calendar_today, size: 14, color: Colors.white),
                            SizedBox(width: 4),
                            Text('Date'),
                          ],
                        ),
                      ),
                      DataColumn(
                        label: Row(
                          children: [
                            Icon(Icons.speed, size: 14, color: Colors.white),
                            SizedBox(width: 4),
                            Text('Velocity (km/s)'),
                          ],
                        ),
                      ),
                      DataColumn(
                        label: Row(
                          children: [
                            Icon(Icons.straighten, size: 14, color: Colors.white),
                            SizedBox(width: 4),
                            Text('Distance (km)'),
                          ],
                        ),
                      ),
                      DataColumn(
                        label: Row(
                          children: [
                            Icon(Icons.public, size: 14, color: Colors.white),
                            SizedBox(width: 4),
                            Text('Orbiting Body'),
                          ],
                        ),
                      ),
                    ],
                    rows: approaches.asMap().entries.map((entry) {
                      final index = entry.key;
                      final approach = entry.value;
                      final isClosest = index == 0;

                      return DataRow(
                        color: isClosest
                            ? MaterialStateProperty.all(Colors.blue.withOpacity(0.1))
                            : null,
                        cells: [
                          DataCell(
                            Text(
                              approach.date.substring(0, 10),
                              style: TextStyle(
                                color: isClosest ? Colors.white : null,
                                fontWeight: isClosest ? FontWeight.bold : null,
                              ),
                            ),
                          ),
                          DataCell(
                            Row(
                              children: [
                                if (index > 0 &&
                                    approach.relativeVelocity.kilometersPerSecond >
                                        approaches[index - 1].relativeVelocity.kilometersPerSecond)
                                  const Icon(Icons.arrow_upward, color: Colors.red, size: 14)
                                else if (index > 0)
                                  const Icon(Icons.arrow_downward, color: Colors.green, size: 14),
                                const SizedBox(width: 4),
                                Text(
                                  approach.relativeVelocity.kilometersPerSecond.toStringAsFixed(2),
                                ),
                              ],
                            ),
                          ),
                          DataCell(
                            Text(
                              _formatLargeNumber(approach.missDistance.kilometers),
                              style: TextStyle(
                                color: isClosest ? Colors.white : null,
                                fontWeight: isClosest ? FontWeight.bold : null,
                              ),
                            ),
                          ),
                          DataCell(
                            Row(
                              children: [
                                _getBodyIcon(approach.orbitingBody),
                                const SizedBox(width: 4),
                                Text(approach.orbitingBody),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            if (approaches.isNotEmpty) const SizedBox(height: 16),
            if (approaches.isNotEmpty)
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blue.withOpacity(0.5)),
                  ),
                  child: Text(
                    'Closest Approach: ${approaches.first.date.substring(0, 10)} (${_formatLargeNumber(approaches.first.missDistance.kilometers)} km)',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context, Asteroid asteroid) {
    final theme = Theme.of(context);
    final hazardColor = asteroid.isPotentiallyHazardous
        ? Colors.red[400]
        : Colors.green[400];

    return Card(
      elevation: 8,
      color: Colors.blueGrey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            AsteroidIconWidget(
              diameter: asteroid.estimatedDiameter.kilometers.avg,
              isHazardous: asteroid.isPotentiallyHazardous,
              size: SizeConfig.width(20),
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
                    'ID: ${asteroid.designation}',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month, size: 14, color: Colors.white70),
                      const SizedBox(width: 4),
                      Text(
                        'First observed: ${asteroid.closeApproachData.isNotEmpty ? _formatDate(asteroid.closeApproachData.last.date) : "Unknown"}',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: hazardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: (hazardColor ?? Colors.transparent).withOpacity(0.5),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    asteroid.isPotentiallyHazardous
                        ? Icons.warning_amber_rounded
                        : Icons.verified,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    asteroid.isPotentiallyHazardous ? 'HAZARDOUS' : 'SAFE',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  TableRow _buildTableRow(String unit, String min, String max) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            unit,
            style: const TextStyle(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            min,
            style: const TextStyle(color: Colors.blue),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            max,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  String _formatLargeNumber(double number) {
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(2)}B';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(2)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(2)}K';
    } else {
      return number.toStringAsFixed(2);
    }
  }

  String _formatDate(String dateString) {
    return dateString.substring(0, 10);
  }

  Widget _getBodyIcon(String body) {
    IconData iconData;
    Color color;

    switch (body.toLowerCase()) {
      case 'earth':
        iconData = Icons.public;
        color = Colors.blue;
        break;
      case 'moon':
        iconData = Icons.nightlight_round;
        color = Colors.grey;
        break;
      case 'mars':
        iconData = Icons.circle;
        color = Colors.red;
        break;
      case 'venus':
        iconData = Icons.circle;
        color = Colors.orange;
        break;
      case 'mercury':
        iconData = Icons.circle;
        color = Colors.amber;
        break;
      case 'jupiter':
        iconData = Icons.circle;
        color = Colors.brown;
        break;
      default:
        iconData = Icons.public;
        color = Colors.grey;
    }

    return Icon(iconData, size: 14, color: color);
  }
}

extension EstimatedDiameterExtensions on EstimatedDiameter {
  double get avg => (kilometers.min + kilometers.max) / 2;
}

class AsteroidIconWidget extends StatelessWidget {
  final double diameter;
  final bool isHazardous;
  final double size;

  const AsteroidIconWidget({
    Key? key,
    required this.diameter,
    required this.isHazardous,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseSize = size;
    final double iconSize = baseSize * math.min(1.5, math.max(0.7, (diameter / 5)));

    return Container(
      width: iconSize,
      height: iconSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: isHazardous
              ? [Colors.grey[400]!, Colors.grey[700]!, Colors.grey[900]!]
              : [Colors.grey[300]!, Colors.grey[600]!, Colors.grey[800]!],
          stops: const [0.2, 0.7, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: isHazardous ? Colors.red.withOpacity(0.5) : Colors.blue.withOpacity(0.5),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
      child: CustomPaint(
        painter: AsteroidSurfacePainter(isHazardous: isHazardous),
      ),
    );
  }
}

class AsteroidSurfacePainter extends CustomPainter {
  final bool isHazardous;
  final Random random = Random(42);

  AsteroidSurfacePainter({required this.isHazardous});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint craterPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final Paint highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 12; i++) {
      final craterSize = size.width * (0.05 + random.nextDouble() * 0.15);
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;

      canvas.drawCircle(Offset(x, y), craterSize, craterPaint);
      canvas.drawCircle(
        Offset(x - craterSize * 0.2, y - craterSize * 0.2),
        craterSize * 0.3,
        highlightPaint,
      );
    }

    final highlightGradient = RadialGradient(
      colors: [Colors.white.withOpacity(0.4), Colors.transparent],
      stops: const [0.0, 1.0],
      center: Alignment.topLeft,
      radius: 0.7,
    );

    final highlightRect = Rect.fromCircle(
      center: Offset(size.width * 0.3, size.height * 0.3),
      radius: size.width * 0.6,
    );

    canvas.drawCircle(
      Offset(size.width * 0.3, size.height * 0.3),
      size.width * 0.6,
      Paint()..shader = highlightGradient.createShader(highlightRect),
    );

    if (isHazardous) {
      final glowGradient = RadialGradient(
        colors: [Colors.red.withOpacity(0.2), Colors.transparent],
        stops: const [0.7, 1.0],
      );

      final glowRect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width * 0.8,
      );

      canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        size.width * 0.8,
        Paint()..shader = glowGradient.createShader(glowRect),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class OrbitPainter extends CustomPainter {
  final bool isHazardous;
  final String asteroidName;
  final double animationValue = 0.75;

  OrbitPainter({required this.isHazardous, required this.asteroidName});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final earthOrbitRadius = math.min(size.width, size.height) * 0.35;

    final asteroidOrbitRadiusX = earthOrbitRadius * (isHazardous ? 0.8 : 1.3);
    final asteroidOrbitRadiusY = earthOrbitRadius * (isHazardous ? 1.2 : 0.7);
    final asteroidOrbitAngle = isHazardous ? math.pi / 6 : math.pi / 4;

    final sunPaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    final sunGlowPaint = Paint()
      ..shader = RadialGradient(
        colors: [Colors.yellow.withOpacity(0.6), Colors.yellow.withOpacity(0.0)],
        stops: const [0.5, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: 25));

    canvas.drawCircle(center, 25, sunGlowPaint);
    canvas.drawCircle(center, 15, sunPaint);

    final earthOrbitPaint = Paint()
      ..color = Colors.blue.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, earthOrbitRadius, earthOrbitPaint);

    final asteroidOrbitPaint = Paint()
      ..color = isHazardous ? Colors.red.withOpacity(0.8) : Colors.green.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final asteroidOrbitRect = Rect.fromCenter(
      center: center,
      width: asteroidOrbitRadiusX * 2,
      height: asteroidOrbitRadiusY * 2,
    );

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(asteroidOrbitAngle);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawOval(asteroidOrbitRect, asteroidOrbitPaint);
    canvas.restore();

    final earthAngle = 2 * math.pi * animationValue;
    final earthX = center.dx + earthOrbitRadius * math.cos(earthAngle);
    final earthY = center.dy + earthOrbitRadius * math.sin(earthAngle);
    final earthPos = Offset(earthX, earthY);

    final earthPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawCircle(earthPos, 10, earthPaint);

    final asteroidAngle = 2 * math.pi * (animationValue + 0.5);
    final asteroidX = center.dx +
        asteroidOrbitRadiusX * math.cos(asteroidAngle + asteroidOrbitAngle);
    final asteroidY = center.dy +
        asteroidOrbitRadiusY * math.sin(asteroidAngle + asteroidOrbitAngle);
    final asteroidPos = Offset(asteroidX, asteroidY);

    final asteroidPaint = Paint()
      ..color = isHazardous ? Colors.red[700]! : Colors.grey[600]!
      ..style = PaintingStyle.fill;

    canvas.drawCircle(asteroidPos, 8, asteroidPaint);

    if (isHazardous) {
      final intersectionPaint = Paint()
        ..color = Colors.orange
        ..style = PaintingStyle.fill;

      final intersectionPoint1 = _calculateIntersectionPoint(
          center, earthOrbitRadius, asteroidOrbitRadiusX, asteroidOrbitRadiusY,
          asteroidOrbitAngle, 1
      );

      final intersectionPoint2 = _calculateIntersectionPoint(
          center, earthOrbitRadius, asteroidOrbitRadiusX, asteroidOrbitRadiusY,
          asteroidOrbitAngle, 2
      );

      canvas.drawCircle(intersectionPoint1, 6, intersectionPaint);
      canvas.drawCircle(intersectionPoint2, 6, intersectionPaint);

      final warningPaint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      const double warningSize = 12;

      canvas.save();
      canvas.translate(intersectionPoint1.dx, intersectionPoint1.dy);
      canvas.drawPath(
        Path()
          ..moveTo(-warningSize / 2, -warningSize / 2)
          ..lineTo(warningSize / 2, warningSize / 2)
          ..moveTo(-warningSize / 2, warningSize / 2)
          ..lineTo(warningSize / 2, -warningSize / 2),
        warningPaint,
      );
      canvas.restore();

      canvas.save();
      canvas.translate(intersectionPoint2.dx, intersectionPoint2.dy);
      canvas.drawPath(
        Path()
          ..moveTo(-warningSize / 2, -warningSize / 2)
          ..lineTo(warningSize / 2, warningSize / 2)
          ..moveTo(-warningSize / 2, warningSize / 2)
          ..lineTo(warningSize / 2, -warningSize / 2),
        warningPaint,
      );
      canvas.restore();
    }

    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );

    _drawText(canvas, 'Earth', earthPos, textStyle, Colors.blue);
    _drawText(
        canvas,
        asteroidName.length > 12 ? asteroidName.substring(0, 12) + '...' : asteroidName,
        asteroidPos,
        textStyle,
        isHazardous ? Colors.red : Colors.green
    );
    _drawText(canvas, 'Sun', center, textStyle, Colors.yellow);
  }

  void _drawText(Canvas canvas, String text, Offset position, TextStyle style, Color bgColor) {
    final textSpan = TextSpan(
      text: text,
      style: style,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    final bgRect = Rect.fromCenter(
      center: Offset(
        position.dx,
        position.dy + 20,
      ),
      width: textPainter.width + 8,
      height: textPainter.height + 4,
    );

    final bgPaint = Paint()
      ..color = bgColor.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final bgRRect = RRect.fromRectAndRadius(
      bgRect,
      const Radius.circular(4),
    );

    canvas.drawRRect(bgRRect, bgPaint);

    textPainter.paint(
      canvas,
      Offset(
        position.dx - textPainter.width / 2,
        position.dy + 20 - textPainter.height / 2,
      ),
    );
  }

  Offset _calculateIntersectionPoint(
      Offset center,
      double earthRadius,
      double asteroidRadiusX,
      double asteroidRadiusY,
      double asteroidAngle,
      int point
      ) {
    final angle = (point == 1)
        ? asteroidAngle - math.pi / 4
        : asteroidAngle + math.pi / 4;

    return Offset(
      center.dx + earthRadius * math.cos(angle),
      center.dy + earthRadius * math.sin(angle),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

extension DiameterRangeExtensions on DiameterRange {
  double get avg {
    final minValue = min is num ? min as num : double.parse(min.toString());
    final maxValue = max is num ? max as num : double.parse(max.toString());

    return (minValue + maxValue) / 2.0;
  }
}*/
