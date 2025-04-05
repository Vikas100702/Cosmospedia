import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';

class RoverCameraAlertDialog extends StatelessWidget {
  final List<String> cameras;
  final ValueChanged<String> onCameraSelected;

  const RoverCameraAlertDialog({
    super.key,
    required this.cameras,
    required this.onCameraSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Select Camera',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: cameras.length,
              itemBuilder: (context, index) {
                final camera = cameras[index];
                return Card(
                  color: Colors.white.withOpacity(0.1),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(
                      camera,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      onCameraSelected(camera);
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
Future<String?> showRoverCameraDialog({
  required BuildContext context,
  required List<String> cameras,
}) async {
  return await showDialog<String>(
    context: context,
    builder: (context) {
      String? selectedCamera;
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: RoverCameraAlertDialog(
          cameras: cameras,
          onCameraSelected: (camera) {
            selectedCamera = camera;
            Navigator.pop(context, camera);
          },
        ),
      );
    },
  );
}
