// lib/data/repositories/apod_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/apod.dart';
import '../../utils/constants.dart';

class ApodRepository {
  final http.Client client;
  List<ApodModel>? _cachedApods;

  ApodRepository({http.Client? client}) : client = client ?? http.Client();

  Future<List<ApodModel>> getRecentApods(int count) async {
    // Return cached data if available
    if (_cachedApods != null && _cachedApods!.length >= count) {
      return _cachedApods!.sublist(0, count);
    }
    final List<ApodModel> apods = [];
    final List<Future<ApodModel?>> futures = [];

    try {
      // Fetch multiple APOD images concurrently
      for (int i = 0; i < count; i++) {
        futures.add(_fetchApod(i));
      }

      // Wait for all requests to complete
      final results = await Future.wait(futures);

      // Filter out null values (failed requests)
      for (var result in results) {
        if (result != null) {
          apods.add(result);
        }
      }

      // Cache the results
      _cachedApods = apods;

      return apods;
    } catch (e) {
      throw Exception('Failed to load APOD data: $e');
    }

    /*try {
      // Fetch multiple APOD images
      for (int i = 0; i < count; i++) {
        final url = Uri.parse(
            '${Constants.NASA_API_BASE_URL}/planetary/apod?api_key=${Constants.NASA_API_KEY}&date=${_getPastDate(i)}'
        );

        final response = await client.get(url);

        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);

          // Only add if the media type is an image
          if (data['media_type'] == 'image') {
            apods.add(ApodModel.fromJson(data));
          }
        }
      }

      return apods;
    } catch (e) {
      throw Exception('Failed to load APOD data: $e');
    }*/
  }

  Future<ApodModel?> _fetchApod(int daysAgo) async {
    try {
      final url = Uri.parse(
          '${Constants.NASA_API_BASE_URL}/planetary/apod?api_key=${Constants.NASA_API_KEY}&date=${_getPastDate(daysAgo)}');

      final response = await client.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Only add if the media type is an image
        if (data['media_type'] == 'image') {
          return ApodModel.fromJson(data);
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  String _getPastDate(int daysAgo) {
    final now = DateTime.now();
    final pastDate = now.subtract(Duration(days: daysAgo));
    return '${pastDate.year}-${_twoDigits(pastDate.month)}-${_twoDigits(pastDate.day)}';
  }

  String _twoDigits(int n) {
    return n >= 10 ? '$n' : '0$n';
  }
}
