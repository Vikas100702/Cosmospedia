import 'dart:io';
import 'package:cosmospedia/utils/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:http/http.dart' as http;
import '../../../../data/models/apod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../utils/size_config.dart';

class ImagePreview extends StatefulWidget {
  final ApodModel apod;

  const ImagePreview({
    super.key,
    required this.apod,
  });

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  bool _isDownloading = false;
  double _downloadProgress = 0;

  Future<void> _downloadImage() async {
    final l10n = AppLocalizations.of(context)!;

    // Check storage permission
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.storagePermissionDenied),
            ),
          );
        }
        return;
      }
    }

    try {
      setState(() {
        _isDownloading = true;
        _downloadProgress = 0;
      });

      // Get image URL (prefer HD if available)
      final imageUrl = widget.apod.hdurl ?? widget.apod.url;

      //Start Download
      final response =
          await http.Client().send(http.Request('GET', Uri.parse(imageUrl)));
      final contentLength = response.contentLength ?? 0;

      // Ask the user for a directory to save the file
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

      if (selectedDirectory == null) {
        // User canceled the picker
        return;
      }

      //Prepare file path
      final directory = await getApplicationDocumentsDirectory();
      final filName =
          '${widget.apod.date}_${widget.apod.title.replaceAll(' ', '_')}.jpg';
      final filePath = "$selectedDirectory/$filName";
      final file = File(filePath);

      // Debugging: Print file path
      print('Saving file to: $file');

      // Download with progress
      List<int> bytes = [];
      await for (final chunk in response.stream) {
        bytes.addAll(chunk);
        if (contentLength > 0) {
          setState(() {
            _downloadProgress = bytes.length / contentLength;
          });
        }
      }

      //Save file
      await file.writeAsBytes(bytes);

      if (mounted) {
        // Debugging: Confirm file saved
        print('File saved successfully: ${await file.exists()}');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.imageDownloadSuccess),
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        print('Error downloading image: $error'); // Debugging error message

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.imageDownloadError),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      setState(() {
        _isDownloading = false;
        _downloadProgress = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Stack(
        children: [
          // Zoomable image viewer
          PhotoView(
            imageProvider: NetworkImage(widget.apod.hdurl ?? widget.apod.url),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
            backgroundDecoration: const BoxDecoration(
              color: AppColors.transparentColor,
            ),
            loadingBuilder: (context, event) => Center(
              child: CircularProgressIndicator(
                value: event?.expectedTotalBytes != null
                    ? event!.cumulativeBytesLoaded / event.expectedTotalBytes!
                    : null,
                color: AppColors.backgroundLight,
              ),
            ),
          ),

          // Top gradient for better visibility of back button and title
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: SizeConfig.height(15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: AppColors.imagePreviewGradient,
                ),
              ),
            ),
          ),

          //Back Button and Title
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.width(4),
                  vertical: SizeConfig.width(2),
                ),
                child: Row(
                  children: [
                    //Back  Button
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.backgroundLight,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: SizeConfig.width(4)),

                    //Title
                    Expanded(
                      child: Text(
                        widget.apod.title,
                        style: TextStyle(
                          color: AppColors.backgroundLight,
                          fontSize: SizeConfig.devicePixelRatio(20),
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Download button and progress
          Positioned(
            bottom: SizeConfig.height(4),
            right: SizeConfig.width(4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_isDownloading && _downloadProgress > 0)
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: SizeConfig.height(2),
                    ),
                    child: CircularProgressIndicator(
                      value: _downloadProgress,
                      color: AppColors.backgroundLight,
                      strokeWidth: 3,
                    ),
                  ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: AppColors.imagePreviewGradient,
                    ),
                    borderRadius: BorderRadius.circular(
                      SizeConfig.devicePixelRatio(30),
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(
                      _isDownloading ? Icons.hourglass_bottom : Icons.download,
                      color: AppColors.backgroundLight,
                    ),
                    onPressed: _isDownloading ? null : _downloadImage,
                    tooltip: l10n.downloadImage,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
