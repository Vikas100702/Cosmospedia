import 'package:cosmospedia/blocs/asteroids/asteroids_bloc.dart';
import 'package:cosmospedia/ui/components/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/asteroids/asteroids_model.dart';
import '../../../l10n/app_localizations.dart';

class AsteroidsScreen extends StatelessWidget {
  const AsteroidsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: l10n?.asteroidsTitle,
      ),
      body:
          BlocBuilder<AsteroidsBloc, AsteroidsState>(builder: (context, state) {
        if (state is AsteroidsLoading) {
          context.read<AsteroidsBloc>().add(LoadAsteroids());
          return const Center(child: CircularProgressIndicator());
        } else if (state is AsteroidsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AsteroidsError) {
          return Center(child: Text(state.error));
        } else if (state is AsteroidsLoaded) {
          return _buildAsteroidsList(state.asteroids, context);
        }
        return const SizedBox();
      }),
    );
  }

  Widget _buildAsteroidsList(
      List<Asteroid> asteroids, BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Asteroids List',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  // TODO: Implement filter functionality
                },
              ),
            ],
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

  Widget _buildAsteroidsCard(Asteroid asteroids, BuildContext context) {
    final closestApproach = asteroids.closeApproachData.isNotEmpty
        ? asteroids.closeApproachData.first
        : null;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${asteroids.name} (${asteroids.designation})',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Diameter: ${asteroids.estimatedDiameter.kilometers.min.toStringAsFixed(2)} - ${asteroids.estimatedDiameter.kilometers.max.toStringAsFixed(2)} km',
            ),
            Text(
              'Absolute Magnitude: ${asteroids.absoluteMagnitudeH}',
            ),
            Text(
              'Potentially Hazardous: ${asteroids.isPotentiallyHazardous ? 'Yes' : 'No'}',
              style: TextStyle(
                color: asteroids.isPotentiallyHazardous ? Colors.red : Colors.green,
              ),
            ),
            if (closestApproach != null) ...[
              const SizedBox(height: 8),
              Text(
                'Closest Approach:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text('Date: ${closestApproach.date}'),
              Text(
                  'Distance: ${closestApproach.missDistance.kilometers.toStringAsFixed(2)} km'),
              Text(
                  'Relative Velocity: ${closestApproach.relativeVelocity.kilometersPerSecond.toStringAsFixed(2)} km/s'),
            ],
          ],
        ),
      ),
    );
  }
}
