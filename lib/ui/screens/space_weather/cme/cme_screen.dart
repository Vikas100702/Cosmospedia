// lib/ui/screens/space_weather/cme_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
    return BlocProvider(
      create: (context) => CMEBloc(
        cmeRepository: CMERepository(),
      )..add(LoadCMEData(startDate: startDate, endDate: endDate)),
      child: Container(
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
          body: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      _buildCMEEventsTab(context),
                      _buildCMEAnalysisTab(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCMEEventsTab(BuildContext context) {
    return BlocBuilder<CMEBloc, CMEState>(
      builder: (context, state) {
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
        return RefreshIndicator(
          onRefresh: () async {
            context.read<CMEBloc>().add(
                  LoadCMEData(
                    startDate: startDate,
                    endDate: endDate,
                  ),
                );
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.cmeList.length,
            itemBuilder: (context, index) {
              final cme = state.cmeList[index];
              return _buildCMECard(context, cme);
            },
          ),
        );
      },
    );
  }

  Widget _buildCMEAnalysisTab(BuildContext context) {
    return BlocBuilder<CMEBloc, CMEState>(
      builder: (context, state) {
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
        return RefreshIndicator(
          onRefresh: () async {
            context.read<CMEBloc>().add(
                  LoadCMEAnalysisData(
                    startDate: startDate,
                    endDate: endDate,
                  ),
                );
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.cmeAnalysisList.length,
            itemBuilder: (context, index) {
              final analysis = state.cmeAnalysisList[index];
              return _buildAnalysisCard(analysis);
            },
          ),
        );
      },
    );
  }

  Widget _buildCMECard(BuildContext context, CmeModel cme) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white.withOpacity(0.1),
      child: ExpansionTile(
        title: Text(
          cme.activityID,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Start: ${dateFormat.format(DateTime.parse(cme.startTime.replaceAll('Z', '')))}',
          style: const TextStyle(color: Colors.white70),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow('Catalog', cme.catalog),
                _buildDetailRow('Source Location', cme.sourceLocation ?? 'N/A'),
                _buildDetailRow(
                    'Active Region', cme.activeRegionNum?.toString() ?? 'N/A'),
                _buildDetailRow('Note', cme.note),
                const SizedBox(height: 16),
                const Text(
                  'Instruments:',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...cme.instruments.map(
                  (instrument) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      '- ${instrument.displayName}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'CME Analyses:',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...cme.cmeAnalyses.map(
                  (analysis) => _buildCMEAnalysisItem(analysis),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisCard(CMEAnalysisModel analysis) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              analysis.isMostAccurate ? '★ Most Accurate Analysis' : 'Analysis',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            _buildDetailRow('Time at 21.5°', analysis.time21_5),
            _buildDetailRow('Latitude', '${analysis.latitude}°'),
            _buildDetailRow('Longitude', '${analysis.longitude}°'),
            _buildDetailRow('Half Angle', '${analysis.halfAngle}°'),
            _buildDetailRow('Speed', '${analysis.speed} km/s'),
            _buildDetailRow('Type', analysis.type),
            _buildDetailRow('Catalog', analysis.catalog),
            _buildDetailRow('Data Level', analysis.dataLevel),
            if (analysis.associatedCMEID != null)
              _buildDetailRow('Associated CME ID', analysis.associatedCMEID!),
            if (analysis.associatedCMEstartTime != null)
              _buildDetailRow(
                'Associated CME Start Time',
                analysis.associatedCMEstartTime!,
              ),
            if (analysis.note != null && analysis.note!.isNotEmpty)
              _buildDetailRow('Note', analysis.note!),
            if (analysis.link.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: InkWell(
                  onTap: () {
                    // Handle link tap
                  },
                  child: Text(
                    'View Details',
                    style: TextStyle(
                      color: Colors.blue[200],
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCMEAnalysisItem(CMEAnalysis analysis) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.black.withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              analysis.isMostAccurate ? 'Most Accurate Analysis' : 'Analysis',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildDetailRow('Time at 21.5°', analysis.time21_5),
            _buildDetailRow('Latitude', '${analysis.latitude}°'),
            _buildDetailRow('Longitude', '${analysis.longitude}°'),
            _buildDetailRow('Half Angle', '${analysis.halfAngle}°'),
            _buildDetailRow('Speed', '${analysis.speed} km/s'),
            _buildDetailRow('Type', analysis.type),
            if (analysis.note != null && analysis.note!.isNotEmpty)
              _buildDetailRow('Note', analysis.note!),
            if (analysis.enlilList != null && analysis.enlilList!.isNotEmpty)
              ...analysis.enlilList!.map((enlil) => _buildEnlilCard(enlil)),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnlilCard(Enlil enlil) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.black.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enlil Simulation:',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildDetailRow('Model Completion Time', enlil.modelCompletionTime),
            _buildDetailRow('AU', '${enlil.au}'),
            if (enlil.estimatedShockArrivalTime != null)
              _buildDetailRow(
                'Estimated Shock Arrival',
                enlil.estimatedShockArrivalTime!,
              ),
            if (enlil.impactList.isNotEmpty) ...[
              const SizedBox(height: 8),
              const Text(
                'Impact List:',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...enlil.impactList.map(
                (impact) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '- ${impact.location}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      Text(
                        '  Arrival: ${impact.arrivalTime}',
                        style: const TextStyle(color: Colors.white54),
                      ),
                      Text(
                        '  ${impact.isGlancingBlow ? 'Glancing Blow' : 'Direct Hit'}',
                        style: const TextStyle(color: Colors.white54),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
