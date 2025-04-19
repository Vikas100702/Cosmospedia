import 'package:cosmospedia/blocs/space_weather/gst/gst_bloc.dart';
import 'package:cosmospedia/data/repositories/space_weather/cme_repository.dart';
import 'package:cosmospedia/ui/components/custom_app_bar/custom_app_bar.dart';
import 'package:cosmospedia/ui/screens/coming_soon_screen.dart';
import 'package:cosmospedia/ui/screens/space_weather/cme/cme_screen.dart';
import 'package:cosmospedia/ui/screens/space_weather/gst/gst_screen.dart';
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
      {
        'title': 'Solar Flares',
        'icon': Icons.whatshot,
        'description':
            'Solar flares are sudden explosions of energy on the Sun, classified by their strength (X being the strongest). They can disrupt communication and navigation systems. These details explain when the flare occurred, how strong it was, and from which region of the Sun it came.',
        'onTap': const ComingSoonScreen(title: 'Interplanetary Shocks'),
      },
      {
        'title': 'Geomagnetic Storms',
        'icon': Icons.thunderstorm,
        'description':
            'A geomagnetic storm is a temporary disturbance of Earth\'s magnetic field caused by solar activity. It can affect power grids, satellite operations, and even cause auroras. The Kp index here tells how strong the storm was, and related events show what caused it.',
        'onTap': (BuildContext context) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const GstScreen(),
            ),
          );
        },
      },
      {
        'title': 'Interplanetary Shocks',
        'icon': Icons.waves,
        'description':
            'Interplanetary shocks are sudden disturbances in the solar wind, usually caused by fast CMEs. When they pass satellites or planets, they can impact space missions. These fields help locate when and where the shock was detected and what solar activity triggered it.',
        'onTap': const ComingSoonScreen(title: 'Interplanetary Shocks'),
      },
      {
        'title': 'Solar Energetic Particles',
        'icon': Icons.bolt,
        'description':
            'SEPs are high-energy particles ejected by solar flares or CMEs that travel through space. They can be dangerous for astronauts and satellites. This info tells when they were detected, what caused them, and where they were observed.',
        'onTap': const ComingSoonScreen(title: 'Solar Energetic Particles'),
      },
      {
        'title': 'Magnetopause Crossings',
        'icon': Icons.compare_arrows,
        'description':
            'SEPs are high-energy particles ejected by solar flares or CMEs that travel through space. They can be dangerous for astronauts and satellites. This info tells when they were detected, what caused them, and where they were observed.',
        'onTap': const ComingSoonScreen(title: 'Magnetopause Crossings'),
      },
      {
        'title': 'Radiation Belt Enhancements',
        'icon': Icons.radio,
        'description':
            'Radiation belts around Earth can become more intense due to space weather, which may damage spacecraft electronics. These enhancements are tracked to warn satellite operators. The data shows when the belts were energized and which satellite observed it.',
        'onTap': const ComingSoonScreen(title: 'Radiation Belt Enhancements'),
      },
      {
        'title': 'High Speed Streams',
        'icon': Icons.air,
        'description':
            'High-speed solar wind streams from coronal holes can stir up geomagnetic storms on Earth. These winds are not as explosive as CMEs but can still affect satellites and cause auroras. The fields indicate when this stream reached Earth and its possible source.',
        'onTap': const ComingSoonScreen(title: 'High Speed Streams'),
      },
      {
        'title': 'WSA+Enlil Simulations',
        'icon': Icons.sim_card,
        'description':
            'This is a computer simulation predicting the path of a CME through space. It helps forecast when and where it might hit Earth or spacecraft. Users can see the estimated impact time, duration, and whether other planets or probes are affected too.',
        'onTap': const ComingSoonScreen(title: 'WSA+Enlil Simulations'),
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
