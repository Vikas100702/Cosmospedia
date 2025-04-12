import 'package:flutter/cupertino.dart';
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
}

/*
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
          _buildHeaderSection(context, asteroid),
          const SizedBox(height: 24),

          // 1. Size Comparison Radar Chart (replaced with custom visualization)
          _buildSizeComparisonVisualization(context, asteroid),
          const SizedBox(height: 20),

          // 2. Diameter Range Bar Chart (custom implementation)
          _buildCustomDiameterBarChart(context, asteroid),
          const SizedBox(height: 20),

          // 3. Close Approach Velocity Line Chart (custom implementation)
          if (asteroid.closeApproachData.length > 1)
            _buildCustomVelocityChart(context, asteroid),
          if (asteroid.closeApproachData.length > 1) const SizedBox(height: 20),

          // 4. Miss Distance Comparison (custom implementation)
          if (closestApproach != null)
            _buildCustomMissDistanceChart(context, closestApproach),
          if (closestApproach != null) const SizedBox(height: 20),

          // 5. All Approaches Data Table
          _buildApproachesDataTable(context, asteroid),
        ],
      ),
    );
  }

  // Custom Size Comparison Visualization
  Widget _buildSizeComparisonVisualization(BuildContext context, Asteroid asteroid) {
    final minSize = asteroid.estimatedDiameter.kilometers.min;
    final maxSize = asteroid.estimatedDiameter.kilometers.max;
    final avgSize = (minSize + maxSize) / 2;

    // Comparison objects (in km)
    const double footballField = 0.11;
    const double eiffelTower = 0.33;
    const double empireState = 0.44;
    const double burjKhalifa = 0.828;

    final comparisons = [
      {'name': 'Football Field', 'size': footballField, 'color': Colors.blue},
      {'name': 'Eiffel Tower', 'size': eiffelTower, 'color': Colors.green},
      {'name': 'Empire State', 'size': empireState, 'color': Colors.orange},
      {'name': 'Burj Khalifa', 'size': burjKhalifa, 'color': Colors.purple},
    ];

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
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Custom visualization using comparison bars
            Column(
              children: comparisons.map((item) {
                final ratio = avgSize / (item['size'] as double);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (item['name'] as String),
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            width: 40,
                            alignment: Alignment.center,
                            child: Text(
                              '${ratio.toStringAsFixed(1)}x',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Expanded(
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final asteroidWidth = constraints.maxWidth * 0.3;
                                final comparisonWidth = asteroidWidth / ratio;
                                return Stack(
                                  children: [
                                    // Comparison object
                                    Container(
                                      width: comparisonWidth,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: item['color'] as Color,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    // Asteroid size
                                    Container(
                                      width: asteroidWidth,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(color: Colors.white),
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
              child: Text(
                'Average Diameter: ${avgSize.toStringAsFixed(2)} km',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Custom Diameter Bar Chart
  Widget _buildCustomDiameterBarChart(BuildContext context, Asteroid asteroid) {
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
              'Diameter Range Comparison',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            SizedBox(
              height: 200,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCustomBar(
                    context: context,
                    minValue: minKm,
                    maxValue: maxKm,
                    label: 'Km',
                    color: Colors.blue,
                    maxBarValue: maxValue,
                  ),
                  _buildCustomBar(
                    context: context,
                    minValue: minMiles,
                    maxValue: maxMiles,
                    label: 'Miles',
                    color: Colors.green,
                    maxBarValue: maxValue,
                  ),
                  _buildCustomBar(
                    context: context,
                    minValue: minMeters,
                    maxValue: maxMeters,
                    label: 'Meters',
                    color: Colors.orange,
                    maxBarValue: maxValue,
                  ),
                  _buildCustomBar(
                    context: context,
                    minValue: minFeet,
                    maxValue: maxFeet,
                    label: 'Feet',
                    color: Colors.purple,
                    maxBarValue: maxValue,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            _buildDiameterLegend(),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomBar({
    required BuildContext context,
    required double minValue,
    required double maxValue,
    required String label,
    required Color color,
    required double maxBarValue,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Container(
          width: 30,
          height: 150 * (maxValue / maxBarValue),
          decoration: BoxDecoration(
            color: color.withOpacity(0.6),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  width: 30,
                  height: 150 * (minValue / maxBarValue),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${minValue.toStringAsFixed(1)}-${maxValue.toStringAsFixed(1)}',
          style: const TextStyle(color: Colors.white70, fontSize: 10),
        ),
      ],
    );
  }

  // Custom Velocity Chart
  Widget _buildCustomVelocityChart(BuildContext context, Asteroid asteroid) {
    final approaches = asteroid.closeApproachData;
    final velocities = approaches.map((a) => a.relativeVelocity.kilometersPerSecond).toList();
    final dates = approaches.map((a) => a.date.substring(0, 4)).toList();
    final maxVelocity = velocities.reduce((a, b) => a > b ? a : b);

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
              'Approach Velocity Over Time',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            SizedBox(
              height: 200,
              child: CustomPaint(
                painter: _VelocityChartPainter(
                  velocities: velocities,
                  dates: dates,
                  maxVelocity: maxVelocity,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Custom Miss Distance Chart
  Widget _buildCustomMissDistanceChart(BuildContext context, CloseApproachData approach) {
    final km = approach.missDistance.kilometers;
    final lunar = approach.missDistance.lunar;
    final astronomical = approach.missDistance.astronomical;
    final miles = approach.missDistance.miles;

    final maxValue = [km, lunar, astronomical, miles].reduce((a, b) => a > b ? a : b);

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
              'Miss Distance Comparison',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _buildDistanceBar(
                        value: km,
                        maxValue: maxValue,
                        label: 'Kilometers',
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 8),
                      _buildDistanceBar(
                        value: lunar,
                        maxValue: maxValue,
                        label: 'Lunar Distances',
                        color: Colors.green,
                      ),
                      const SizedBox(height: 8),
                      _buildDistanceBar(
                        value: astronomical,
                        maxValue: maxValue,
                        label: 'Astronomical Units',
                        color: Colors.orange,
                      ),
                      const SizedBox(height: 8),
                      _buildDistanceBar(
                        value: miles,
                        maxValue: maxValue,
                        label: 'Miles',
                        color: Colors.purple,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Closest Approach:',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      approach.date,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDistanceBar({
    required double value,
    required double maxValue,
    required String label,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Container(
          height: 20,
          width: 200 * (value / maxValue),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 8),
          child: Text(
            value.toStringAsFixed(2),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // Keep the existing methods that don't use fl_chart
  Widget _buildDiameterLegend() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 16,
      runSpacing: 8,
      children: [
        _buildLegendItem(Colors.blue, 'Kilometers'),
        _buildLegendItem(Colors.green, 'Miles'),
        _buildLegendItem(Colors.orange, 'Meters'),
        _buildLegendItem(Colors.purple, 'Feet'),
      ],
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

  Widget _buildApproachesDataTable(BuildContext context, Asteroid asteroid) {
    final approaches = asteroid.closeApproachData;

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
              'All Close Approaches (${approaches.length})',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 16,
                dataRowHeight: 48,
                headingTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                dataTextStyle: TextStyle(color: Colors.white),
                columns: const [
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Velocity (km/s)')),
                  DataColumn(label: Text('Distance (km)')),
                  DataColumn(label: Text('Orbiting Body')),
                ],
                rows: approaches.map((approach) {
                  return DataRow(
                    cells: [
                      DataCell(Text(approach.date)),
                      DataCell(Text(
                          approach.relativeVelocity.kilometersPerSecond.toStringAsFixed(2))),
                      DataCell(Text(
                          approach.missDistance.kilometers.toStringAsFixed(2))),
                      DataCell(Text(approach.orbitingBody)),
                    ],
                  );
                }).toList(),
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
}

// Custom Painter for the Velocity Chart
class _VelocityChartPainter extends CustomPainter {
  final List<double> velocities;
  final List<String> dates;
  final double maxVelocity;

  _VelocityChartPainter({
    required this.velocities,
    required this.dates,
    required this.maxVelocity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final fillPaint = Paint()
      ..color = Colors.blue.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final dotPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 10,
    );

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // Calculate points
    final points = <Offset>[];
    final xStep = size.width / (velocities.length - 1);
    final yScale = size.height / maxVelocity;

    for (int i = 0; i < velocities.length; i++) {
      final x = i * xStep;
      final y = size.height - (velocities[i] * yScale);
      points.add(Offset(x, y));
    }

    // Draw filled area
    final path = Path();
    path.moveTo(0, size.height);
    for (final point in points) {
      path.lineTo(point.dx, point.dy);
    }
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, fillPaint);

    // Draw line
    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }

    // Draw dots and labels
    for (int i = 0; i < points.length; i++) {
      // Draw dot
      canvas.drawCircle(points[i], 4, dotPaint);

      // Draw value label
      textPainter.text = TextSpan(
        text: velocities[i].toStringAsFixed(1),
        style: textStyle,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(points[i].dx - textPainter.width / 2, points[i].dy - 20),
      );

      // Draw date label (only for every other point if many)
      if (i % 2 == 0 || velocities.length <= 5) {
        textPainter.text = TextSpan(
          text: dates[i],
          style: textStyle,
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(points[i].dx - textPainter.width / 2, size.height - 15),
        );
      }
    }

    // Draw grid lines
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1.0;

    // Horizontal grid lines
    const int horizontalLines = 5;
    for (int i = 1; i <= horizontalLines; i++) {
      final y = size.height - (i * size.height / horizontalLines);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);

      // Y-axis labels
      final value = (i * maxVelocity / horizontalLines).toStringAsFixed(0);
      textPainter.text = TextSpan(
        text: value,
        style: textStyle,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(0, y - 10));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}*/
