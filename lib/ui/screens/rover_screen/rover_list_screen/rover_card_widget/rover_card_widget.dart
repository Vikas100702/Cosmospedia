import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../blocs/rover_manifest/rover_manifest_bloc.dart';
import '../../rover_details_screen/rover_details_screen.dart';

class RoverCardWidget extends StatelessWidget {
  final String roverName;

  const RoverCardWidget({super.key, required this.roverName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoverManifestBloc, RoverManifestState>(builder: (context, state){
      // Trigger load when widget is built
      if(state.roverName != roverName) {
        context.read<RoverManifestBloc>().add(LoadRoverManifest(roverName: roverName));
      }

      final roverManifest = state.roverName == roverName ? state.roverManifestModel : null;

      final isLoading = state.status == RoverManifestStatus.loading && state.roverName == roverName;

      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RoverDetailsScreen(roverName: roverName),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roverName.toUpperCase(),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                if (isLoading)
                  const Center(child: CircularProgressIndicator())
                else if (roverManifest != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Status: ${roverManifest.status}'),
                      Text('Landing Date: ${roverManifest.landingDate}'),
                      Text('Total Photos: ${roverManifest.totalPhotos}'),
                    ],
                  )
                else if (state.error != null && state.roverName == roverName)
                    Text('Error: ${state.error}'),
              ],
            ),
          ),
        ),
      );

    },);
  }
}

/*
class RoverCardWidget extends StatefulWidget {
  final String roverName;

  const RoverCardWidget({super.key, required this.roverName});

  @override
  State<RoverCardWidget> createState() => _RoverCardWidgetState();
}

class _RoverCardWidgetState extends State<RoverCardWidget> {
  bool _hasLoaded = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoverManifestBloc, RoverManifestState>(
      listener: (context, state) {
        if (state.roverName == widget.roverName &&
            state.status == RoverManifestStatus.success) {
          _hasLoaded = true;
        }
      },
      builder: (context, state) {
        // Only load once when the widget is first built
        if (!_hasLoaded && state.roverName != widget.roverName) {
          WidgetsBinding.instance.addPostFrameCallback((_){
            context.read<RoverManifestBloc>().add(
              LoadRoverManifest(roverName: widget.roverName),
            );
          });
        }

        final isLoading = state.status == RoverManifestStatus.loading && state.roverName == widget.roverName;

        final manifest = state.roverName == widget.roverName ? state.roverManifestModel : null;

        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.roverName.toUpperCase(),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                if (isLoading)
                  const Center(child: CircularProgressIndicator())
                else if (manifest != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Status: ${manifest.status}'),
                      Text('Landing Date: ${manifest.landingDate}'),
                      Text('Total Photos: ${manifest.totalPhotos}'),
                    ],
                  )
                else if (state.error != null && state.roverName == widget.roverName)
                    Text('Error: ${state.error}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
*/
