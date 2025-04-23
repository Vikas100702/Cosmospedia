import 'package:cosmospedia/data/repositories/space_weather/cme_repository.dart';
import 'package:cosmospedia/ui/components/custom_app_bar/custom_app_bar.dart';
import 'package:cosmospedia/ui/screens/space_weather/cme/cme_screen.dart';
import 'package:cosmospedia/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../blocs/space_weather/cme/cme_bloc.dart';

class SpaceWeatherDashboard extends StatelessWidget {
  const SpaceWeatherDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocProvider(
      create: (context) => CMEBloc(cmeRepository: CMERepository()),
      child: Container(
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
                'Space Weather Explorer',
                style: TextStyle(
                  color: AppColors.backgroundLight,
                  fontWeight: FontWeight.w600,
                  fontSize: screenSize.width * 0.045,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          body: const _SpaceWeatherContent(),
        ),
      ),
    );
  }
}

class _SpaceWeatherContent extends StatelessWidget {
  const _SpaceWeatherContent();

  @override
  Widget build(BuildContext context) {
    // List of space weather events with icons
    final spaceEvents = [
      {
        'title': 'Coronal Mass Ejections',
        'icon': Icons.flare,
        'description':
            'A CME is a massive burst of solar plasma and magnetic fields from the Sun’s surface. It can travel through space and, if directed at Earth, may disrupt satellites, GPS, and power systems. These fields tell us when and where the CME happened, which satellite observed it, and how it\'s linked to other solar events.',
        'onTap': (BuildContext context) {
          // Handle event card tap
          final now = DateTime.now();
          final weekAgo = now.subtract(const Duration(days: 7));
          final dateFormat = DateFormat('yyyy-MM-dd');

          // Ensure dates are in correct format
          final formattedStartDate = dateFormat.format(weekAgo);
          final formattedEndDate = dateFormat.format(now);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CMEScreen(
                startDate: formattedStartDate,
                endDate: formattedEndDate,
              ),
            ),
          );
        }
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: spaceEvents.length,
        itemBuilder: (context, index) {
          final event = spaceEvents[index];
          return _buildEventCard(
            context,
            title: event['title'] as String,
            icon: event['icon'] as IconData,
            description: event['description'] as String,
            onTap: () =>
                (event['onTap'] as Function(BuildContext context))(context),
          );
        },
      ),
    );
  }

  Widget _buildEventCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white.withOpacity(0.1),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          constraints: BoxConstraints(
            minHeight: 0, // Remove minimum height constraint
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Make column take minimum space
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 28, // Reduced from 32
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12), // Reduced from 16
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14, // Reduced from 16
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              const Spacer(), // Reduced from 8
              IconButton(
                  onPressed: () {
                    _showDescriptionDialog(context, title, description);
                  },
                  icon: Icon(
                    Icons.info_outline,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _showDescriptionDialog(
      BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black.withOpacity(0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Close',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
