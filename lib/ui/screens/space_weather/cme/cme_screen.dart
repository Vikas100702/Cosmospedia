import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../blocs/space_weather/cme/cme_bloc.dart';
import '../../../../data/models/space_weather/cme_model.dart';
import '../../../../data/repositories/space_weather/cme_repository.dart';
import '../../../../utils/app_colors.dart';
import '../../../components/custom_app_bar/custom_app_bar.dart';

class CMEScreen extends StatelessWidget {
  final String startDate;
  final String endDate;

  const CMEScreen({
    super.key,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    final cmeBloc = BlocProvider.of<CMEBloc>(context);

    if (cmeBloc.state.status == CMEStatus.initial) {
      cmeBloc.add(LoadCMEData(startDate: startDate, endDate: endDate));
    }

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/background.png"),
          opacity: 0.4,
        ),
      ),
      child: Scaffold(
        backgroundColor: AppColors.transparentColor,
        appBar: customAppBar(
          context: context,
          titleWidget: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Coronal Mass Ejections',
              style: TextStyle(
                color: AppColors.backgroundLight,
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.width * 0.045,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        body: BlocBuilder<CMEBloc, CMEState>(
          bloc: cmeBloc,
          builder: (context, state) {
            return DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TabBar(
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.blue.withOpacity(0.3),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white70,
                      tabs: const [
                        Tab(text: 'CME Events'),
                        Tab(text: 'CME Analysis'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildCMEEventsTab(context, state),
                        _buildCMEAnalysisTab(context, state),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCMEEventsTab(BuildContext context, CMEState state) {
    if (state.status == CMEStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.status == CMEStatus.failure) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              const Text(
                'Failed to load CME data',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                state.error ?? 'Unknown error occurred',
                style: const TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.read<CMEBloc>().add(
                    LoadCMEData(
                      startDate: startDate,
                      endDate: endDate,
                    ),
                  );
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }
    if (state.cmeList.isEmpty) {
      return const Center(
        child: Text(
          'No CME events available for selected dates',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    // Group CMEs by date for the chart
    final cmeCountByDate = _groupCMEsByDate(state.cmeList);

    return RefreshIndicator(
      onRefresh: () async {
        context.read<CMEBloc>().add(
          LoadCMEData(
            startDate: startDate,
            endDate: endDate,
          ),
        );
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Summary card with key stats
            _buildCMESummaryCard(state.cmeList),
            const SizedBox(height: 16),
            // CME Events Over Time Chart
            _buildCMETimelineChart(cmeCountByDate),
            const SizedBox(height: 16),
            // Speed Distribution Chart
            if (state.cmeList.any((cme) => cme.cmeAnalyses?.isNotEmpty ?? false))
              _buildSpeedDistributionChart(state.cmeList),
            const SizedBox(height: 16),
            // Location Distribution Visualization
            _buildLocationDistributionChart(state.cmeList),
            const SizedBox(height: 16),
            // CME Events List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: state.cmeList.length,
              itemBuilder: (context, index) {
                final cme = state.cmeList[index];
                return _buildCMECard(context, cme);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCMESummaryCard(List<CmeModel> cmeList) {
    // Calculate key statistics
    final totalEvents = cmeList.length;
    final hasAnalyses = cmeList.where((cme) => cme.cmeAnalyses?.isNotEmpty ?? false).length;
    final averageSpeed = cmeList
        .expand((cme) => cme.cmeAnalyses ?? [])
        .where((analysis) => analysis.speed != null)
        .map((analysis) => analysis.speed!)
        .fold<double>(0, (prev, speed) => prev + speed) /
        (cmeList.expand((cme) => cme.cmeAnalyses ?? []).where((analysis) => analysis.speed != null).length > 0 ?
        cmeList.expand((cme) => cme.cmeAnalyses ?? []).where((analysis) => analysis.speed != null).length : 1);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white.withOpacity(0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CME Summary',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  icon: Icons.event,
                  value: totalEvents.toString(),
                  label: 'Total Events',
                  color: Colors.blue,
                ),
                _buildStatItem(
                  icon: Icons.analytics,
                  value: hasAnalyses.toString(),
                  label: 'With Analysis',
                  color: Colors.green,
                ),
                _buildStatItem(
                  icon: Icons.speed,
                  value: '${averageSpeed.toInt()} km/s',
                  label: 'Avg. Speed',
                  color: Colors.orange,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildCMEAnalysisTab(BuildContext context, CMEState state) {
    if (state.status == CMEStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.status == CMEStatus.failure) {
      return Center(
        child: Text(
          state.error ?? 'Failed to load CME Analysis data',
          style: const TextStyle(color: Colors.white),
        ),
      );
    }
    if (state.cmeAnalysisList.isEmpty) {
      return const Center(
        child: Text(
          'No CME analysis available for selected dates',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    // Prepare data for analysis charts
    final speedData = state.cmeAnalysisList
        .where((analysis) => analysis.speed != null)
        .map((analysis) => analysis.speed!)
        .toList();

    final angleData = state.cmeAnalysisList
        .where((analysis) => analysis.halfAngle != null)
        .map((analysis) => analysis.halfAngle!)
        .toList();

    return RefreshIndicator(
      onRefresh: () async {
        context.read<CMEBloc>().add(
          LoadCMEAnalysisData(
            startDate: startDate,
            endDate: endDate,
          ),
        );
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Analysis Summary Card
            _buildAnalysisSummaryCard(state.cmeAnalysisList),
            const SizedBox(height: 16),
            // Speed Analysis Chart
            if (speedData.isNotEmpty)
              _buildEnhancedSpeedAnalysisChart(speedData),
            const SizedBox(height: 16),
            // Angle Distribution Chart
            if (angleData.isNotEmpty)
              _buildAngleDistributionChart(angleData),
            const SizedBox(height: 16),
            // CME Type Distribution
            _buildTypeDistributionChart(state.cmeAnalysisList),
            const SizedBox(height: 16),
            // Earth Impact Probability
            _buildEarthImpactProbabilityChart(state.cmeAnalysisList),
            const SizedBox(height: 16),
            // Analysis List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: state.cmeAnalysisList.length,
              itemBuilder: (context, index) {
                final analysis = state.cmeAnalysisList[index];
                return _buildAnalysisCard(analysis);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalysisSummaryCard(List<CMEAnalysisModel> analysisList) {
    // Calculate speed statistics
    final speeds = analysisList
        .where((a) => a.speed != null)
        .map((a) => a.speed!)
        .toList();

    double? minSpeed = speeds.isNotEmpty ? speeds.reduce((a, b) => a < b ? a : b) : null;
    double? maxSpeed = speeds.isNotEmpty ? speeds.reduce((a, b) => a > b ? a : b) : null;
    double? avgSpeed = speeds.isNotEmpty ? speeds.reduce((a, b) => a + b) / speeds.length : null;

    // Calculate angle statistics
    final angles = analysisList
        .where((a) => a.halfAngle != null)
        .map((a) => a.halfAngle!)
        .toList();

    double? avgAngle = angles.isNotEmpty ? angles.reduce((a, b) => a + b) / angles.length : null;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white.withOpacity(0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Analysis Summary',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  icon: Icons.speed,
                  value: maxSpeed != null ? '${maxSpeed.toInt()} km/s' : 'N/A',
                  label: 'Max Speed',
                  color: Colors.red,
                ),
                _buildStatItem(
                  icon: Icons.speed_outlined,
                  value: avgSpeed != null ? '${avgSpeed.toInt()} km/s' : 'N/A',
                  label: 'Avg Speed',
                  color: Colors.orange,
                ),
                _buildStatItem(
                  icon: Icons.aspect_ratio,
                  value: avgAngle != null ? '${avgAngle.toInt()}°' : 'N/A',
                  label: 'Avg Width',
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to group CMEs by date
  Map<String, int> _groupCMEsByDate(List<CmeModel> cmeList) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final Map<String, int> result = {};

    for (final cme in cmeList) {
      try {
        final date = DateTime.parse(cme.startTime.replaceAll('Z', ''));
        final dateStr = dateFormat.format(date);
        result[dateStr] = (result[dateStr] ?? 0) + 1;
      } catch (e) {
        continue;
      }
    }

    return result;
  }

  Widget _buildCMETimelineChart(Map<String, int> cmeCountByDate) {
    // Sort dates chronologically
    final dates = cmeCountByDate.keys.toList()..sort();
    final values = dates.map((date) => cmeCountByDate[date]!.toDouble()).toList();

    // Calculate max Y value for better scaling
    final maxY = values.isEmpty ? 1.0 : values.reduce((a, b) => a > b ? a : b) + 1;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CME Events Over Time',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Number of Coronal Mass Ejections detected per day',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    horizontalInterval: 1,
                    verticalInterval: 1,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.white.withOpacity(0.1),
                        strokeWidth: 1,
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: Colors.white.withOpacity(0.1),
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
                        interval: dates.length > 5 ? (dates.length / 5).ceilToDouble() : 1,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= 0 && index < dates.length) {
                            // Format date to show just month/day for better readability
                            final parts = dates[index].split('-');
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                '${parts[1]}/${parts[2]}',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 10,
                                ),
                              ),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: maxY > 10 ? 2 : 1,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  minX: 0,
                  maxX: (dates.length - 1).toDouble(),
                  minY: 0,
                  maxY: maxY,
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipColor: (_) => Colors.blueGrey.withOpacity(0.8),  // Fixed this line
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          final index = spot.x.toInt();
                          final date = dates[index];
                          return LineTooltipItem(
                            '${date}: ${spot.y.toInt()} events',
                            const TextStyle(color: Colors.white),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(dates.length, (index) {
                        return FlSpot(index.toDouble(), values[index]);
                      }),
                      isCurved: true,
                      color: Colors.blueAccent,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 3,
                            color: Colors.white,
                            strokeWidth: 2,
                            strokeColor: Colors.blueAccent,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.blueAccent.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeedDistributionChart(List<CmeModel> cmeList) {
    // Extract speeds from CME analyses
    final speeds = cmeList
        .expand((cme) => cme.cmeAnalyses ?? [])
        .where((analysis) => analysis.speed != null)
        .map((analysis) => analysis.speed!)
        .toList();

    if (speeds.isEmpty) return const SizedBox();

    // Categorize speeds
    final speedRanges = {
      '< 500': speeds.where((s) => s <= 500).length,
      '500-1000': speeds.where((s) => s > 500 && s <= 1000).length,
      '1000-1500': speeds.where((s) => s > 1000 && s <= 1500).length,
      '> 1500': speeds.where((s) => s > 1500).length,
    };

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CME Speed Distribution',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'How fast are these solar eruptions traveling?',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: speedRanges.values.reduce((a, b) => a > b ? a : b).toDouble() + 1,
                  barGroups: speedRanges.entries.map((entry) {
                    return BarChartGroupData(
                      x: speedRanges.keys.toList().indexOf(entry.key),
                      barRods: [
                        BarChartRodData(
                          toY: entry.value.toDouble(),
                          color: _getSpeedColor(entry.key),
                          width: 40,
                          borderRadius: BorderRadius.circular(4),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: speedRanges.values.reduce((a, b) => a > b ? a : b).toDouble() + 1,
                            color: Colors.white.withOpacity(0.05),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 38,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= 0 && index < speedRanges.keys.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                '${speedRanges.keys.elementAt(index)} km/s',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 36,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.white.withOpacity(0.1),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (_) => Colors.blueGrey.withOpacity(0.8),
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final speedRange = speedRanges.keys.elementAt(group.x);
                        return BarTooltipItem(
                          '$speedRange km/s: ${rod.toY.toInt()} events',
                          const TextStyle(color: Colors.white),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationDistributionChart(List<CmeModel> cmeList) {
    // Extract location data from CME analyses
    final locationData = cmeList
        .expand((cme) => cme.cmeAnalyses ?? [])
        .where((analysis) => analysis.latitude != null && analysis.longitude != null)
        .map((analysis) => MapEntry(analysis.latitude!, analysis.longitude!))
        .toList();

    if (locationData.isEmpty) return const SizedBox();

    // Basic regions for simplicity
    final regions = {
      'North': locationData.where((loc) => loc.key > 30).length,
      'Equatorial': locationData.where((loc) => loc.key >= -30 && loc.key <= 30).length,
      'South': locationData.where((loc) => loc.key < -30).length,
    };

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CME Source Locations',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Where on the Sun are these eruptions coming from?',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: regions.entries.map((entry) {
                    return PieChartSectionData(
                      color: _getRegionColor(entry.key),
                      value: entry.value.toDouble(),
                      title: '${entry.key}\n${entry.value}',
                      radius: 60,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            // Add a simple legend
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: regions.keys.map((region) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _getRegionColor(region),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        region,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnhancedSpeedAnalysisChart(List<double> speedData) {
    // Sort speeds for better visualization
    speedData.sort();

    // Calculate some statistics
    final minSpeed = speedData.first;
    final maxSpeed = speedData.last;
    final avgSpeed = speedData.reduce((a, b) => a + b) / speedData.length;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CME Speed Analysis',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Distribution of CME speeds (km/s)',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSpeedStatItem('Min', '${minSpeed.toInt()} km/s', Colors.green),
                _buildSpeedStatItem('Avg', '${avgSpeed.toInt()} km/s', Colors.orange),
                _buildSpeedStatItem('Max', '${maxSpeed.toInt()} km/s', Colors.red),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipColor: (_) => Colors.blueGrey.withOpacity(0.8),
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          final index = spot.x.toInt();
                          if (index >= 0 && index < speedData.length) {
                            return LineTooltipItem(
                              'Speed: ${speedData[index].toInt()} km/s',
                              const TextStyle(color: Colors.white),
                            );
                          }
                          return LineTooltipItem('', const TextStyle());
                        }).toList();
                      },
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 200,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.white.withOpacity(0.1),
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
                        reservedSize: 32,
                        interval: speedData.length > 10 ? (speedData.length / 10).ceilToDouble() : 1,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index == 0 || index == speedData.length - 1 || index % 5 == 0) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                'CME',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 10,
                                ),
                              ),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 250,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  minX: 0,
                  maxX: (speedData.length - 1).toDouble(),
                  minY: (minSpeed - 50).clamp(0, double.infinity),
                  maxY: maxSpeed + 50,
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(speedData.length, (index) {
                        return FlSpot(index.toDouble(), speedData[index]);
                      }),
                      isCurved: true,
                      gradient: LinearGradient(
                        colors: [
                          Colors.green.withOpacity(0.8),
                          Colors.yellow.withOpacity(0.8),
                          Colors.red.withOpacity(0.8),
                        ],
                      ),
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: speedData.length < 20,
                        getDotPainter: (spot, percent, barData, index) {
                          final speed = speedData[index.toInt()];
                          Color dotColor;
                          if (speed < 500) {
                            dotColor = Colors.green;
                          } else if (speed < 1000) {
                            dotColor = Colors.yellow;
                          } else {
                            dotColor = Colors.red;
                          }
                          return FlDotCirclePainter(
                            radius: 3,
                            color: dotColor,
                            strokeWidth: 1,
                            strokeColor: Colors.white,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            Colors.green.withOpacity(0.1),
                            Colors.yellow.withOpacity(0.1),
                            Colors.red.withOpacity(0.1),
                          ],
                        ),
                      ),
                    ),
                    // Add average line
                    LineChartBarData(
                      spots: [
                        FlSpot(0, avgSpeed),
                        FlSpot((speedData.length - 1).toDouble(), avgSpeed),
                      ],
                      isCurved: false,
                      color: Colors.white.withOpacity(0.5),
                      barWidth: 1,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      dashArray: [5, 5],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeedStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildAngleDistributionChart(List<double> angleData) {
    // Calculate statistics
    final minAngle = angleData.reduce((a, b) => a < b ? a : b);
    final maxAngle = angleData.reduce((a, b) => a > b ? a : b);
    final avgAngle = angleData.reduce((a, b) => a + b) / angleData.length;

    // Categorize angles for histogram
    final angleBins = {
      '< 20°': angleData.where((a) => a < 20).length,
      '20°-40°': angleData.where((a) => a >= 20 && a < 40).length,
      '40°-60°': angleData.where((a) => a >= 40 && a < 60).length,
      '> 60°': angleData.where((a) => a >= 60).length,
    };

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CME Angle Distribution',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Angular width of Coronal Mass Ejections',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSpeedStatItem('Min', '${minAngle.toInt()}°', Colors.green),
                _buildSpeedStatItem('Avg', '${avgAngle.toInt()}°', Colors.blue),
                _buildSpeedStatItem('Max', '${maxAngle.toInt()}°', Colors.purple),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: angleBins.values.reduce((a, b) => a > b ? a : b).toDouble() + 1,
                  barGroups: angleBins.entries.map((entry) {
                    return BarChartGroupData(
                      x: angleBins.keys.toList().indexOf(entry.key),
                      barRods: [
                        BarChartRodData(
                          toY: entry.value.toDouble(),
                          color: _getAngleColor(entry.key),
                          width: 40,
                          borderRadius: BorderRadius.circular(4),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: angleBins.values.reduce((a, b) => a > b ? a : b).toDouble() + 1,
                            color: Colors.white.withOpacity(0.05),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 38,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= 0 && index < angleBins.keys.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                angleBins.keys.elementAt(index),
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 36,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.white.withOpacity(0.1),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeDistributionChart(List<CMEAnalysisModel> analysisList) {
    // Extract CME types
    final typeCount = <String, int>{};
    for (final analysis in analysisList) {
      final type = analysis.type?.isNotEmpty == true ? analysis.type! : 'Unknown';
      typeCount[type] = (typeCount[type] ?? 0) + 1;
    }

    if (typeCount.isEmpty) return const SizedBox();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CME Type Distribution',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Categories of observed Coronal Mass Ejections',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                  sections: typeCount.entries.map((entry) {
                    return PieChartSectionData(
                      color: _getTypeColor(entry.key),
                      value: entry.value.toDouble(),
                      title: '${entry.value}',
                      radius: 60,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            // Add legend
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: typeCount.keys.map((type) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _getTypeColor(type),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      type,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEarthImpactProbabilityChart(List<CMEAnalysisModel> analysisList) {
    // Extract earth impact data
    final impactData = analysisList
        .where((a) => a.note != null && a.note!.isNotEmpty)
        .map((a) => a.note!)
        .toList();

    // Simplistic analysis - look for keywords suggesting earth impact
    final earthBoundCount = impactData
        .where((note) =>
    note.toLowerCase().contains('earth') ||
        note.toLowerCase().contains('geomagnetic') ||
        note.toLowerCase().contains('impact'))
        .length;

    final nonEarthBoundCount = impactData.length - earthBoundCount;

    if (impactData.isEmpty) return const SizedBox();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Earth Impact Probability',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Likelihood of CMEs affecting Earth\'s magnetosphere',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 60,
                      sections: [
                        PieChartSectionData(
                          color: Colors.red.withOpacity(0.7),
                          value: earthBoundCount.toDouble(),
                          title: 'Earth-directed',
                          radius: 50,
                          titleStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        PieChartSectionData(
                          color: Colors.blue.withOpacity(0.7),
                          value: nonEarthBoundCount.toDouble(),
                          title: 'Non-Earth',
                          radius: 50,
                          titleStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${(impactData.isNotEmpty ? (earthBoundCount / impactData.length * 100).round() : 0)}%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const Text(
                            'Earth Impact',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
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

  Widget _buildCMECard(BuildContext context, CmeModel cme) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(
          _formatDateTime(cme.startTime),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        /*subtitle: Text(
          'Type: ${cme.type ?? 'Unknown'} | Source: ${cme.sourceLocation ?? 'Unknown'}',
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),*/
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            /*color: _getCMETypeColor(cme.type),*/
          ),
          child: const Icon(
            Icons.solar_power,
            color: Colors.white,
          ),
        ),
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        childrenPadding: const EdgeInsets.all(16),
        children: [
          _buildCMEDetails(cme),
        ],
      ),
    );
  }

  Widget _buildCMEDetails(CmeModel cme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: Colors.white24),
        const SizedBox(height: 8),
        _buildDetailRow('Start Time', _formatDateTime(cme.startTime)),
        /*if (cme.endTime != null) _buildDetailRow('End Time', _formatDateTime(cme.endTime!)),*/
        if (cme.note != null && cme.note!.isNotEmpty) _buildDetailRow('Note', cme.note!),

        if (cme.cmeAnalyses != null && cme.cmeAnalyses!.isNotEmpty) ...[
          const SizedBox(height: 16),
          const Text(
            'Analysis Data',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          ...cme.cmeAnalyses!.map((analysis) {
            return Card(
              color: Colors.white.withOpacity(0.05),
              margin: const EdgeInsets.only(bottom: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (analysis.speed != null) _buildDetailRow('Speed', '${analysis.speed} km/s'),
                    if (analysis.type != null) _buildDetailRow('Type', analysis.type!),
                    if (analysis.latitude != null && analysis.longitude != null)
                      _buildDetailRow('Location', 'Lat: ${analysis.latitude}°, Lon: ${analysis.longitude}°'),
                    if (analysis.halfAngle != null) _buildDetailRow('Half Angle', '${analysis.halfAngle}°'),
                    if (analysis.note != null && analysis.note!.isNotEmpty)
                      _buildDetailRow('Note', analysis.note!),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ],
    );
  }

  Widget _buildAnalysisCard(CMEAnalysisModel analysis) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Analysis: ${analysis.type ?? 'Unknown'}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (analysis.speed != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getSpeedColor('${analysis.speed}'),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${analysis.speed} km/s',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            /*if (analysis.time != null) _buildDetailRow('Time', _formatDateTime(analysis.time!)),*/
            if (analysis.latitude != null && analysis.longitude != null)
              _buildDetailRow('Location', 'Lat: ${analysis.latitude}°, Lon: ${analysis.longitude}°'),
            if (analysis.halfAngle != null) _buildDetailRow('Angular Width', '${analysis.halfAngle! * 2}°'),
            if (analysis.note != null && analysis.note!.isNotEmpty)
              _buildDetailRow('Note', analysis.note!),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Functions
  String _formatDateTime(String dateTimeStr) {
    try {
      final dateTime = DateTime.parse(dateTimeStr.replaceAll('Z', ''));
      return DateFormat('MMM dd, yyyy - HH:mm UTC').format(dateTime);
    } catch (e) {
      return dateTimeStr;
    }
  }

  Color _getCMETypeColor(String? type) {
    if (type == null) return Colors.grey;

    switch (type.toLowerCase()) {
      case 'cme':
        return Colors.orange;
      case 'partial halo':
        return Colors.yellow;
      case 'halo':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  Color _getSpeedColor(String speedRange) {
    switch (speedRange) {
      case '< 500':
        return Colors.green;
      case '500-1000':
        return Colors.yellow;
      case '1000-1500':
        return Colors.orange;
      case '> 1500':
        return Colors.red;
      default:
        if (speedRange.contains('<')) return Colors.green;
        if (speedRange.contains('>')) return Colors.red;

        // Try to parse a numeric speed
        try {
          final speed = double.parse(speedRange);
          if (speed < 500) return Colors.green;
          if (speed < 1000) return Colors.yellow;
          if (speed < 1500) return Colors.orange;
          return Colors.red;
        } catch (_) {
          return Colors.blue;
        }
    }
  }

  Color _getRegionColor(String region) {
    switch (region) {
      case 'North':
        return Colors.blue;
      case 'Equatorial':
        return Colors.green;
      case 'South':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Color _getAngleColor(String angleRange) {
    switch (angleRange) {
      case '< 20°':
        return Colors.blue;
      case '20°-40°':
        return Colors.green;
      case '40°-60°':
        return Colors.yellow;
      case '> 60°':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Color _getTypeColor(String type) {
    // Simple hash to generate somewhat consistent colors
    final hash = type.hashCode.abs() % 5;
    switch (hash) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.green;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.purple;
      case 4:
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }
}