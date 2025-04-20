import 'dart:convert';

import 'package:cosmospedia/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../../models/mars/rover.dart';

class RoverRepository {
  final http.Client client;

  RoverRepository({http.Client? client}) : client = client ?? http.Client();

  Future<List<RoverModel>> getRoverPhotos({
    int count = 20, // Limit for featured images
    required String roverName,
    String? earthDate,
    int? sol, // Default sol day
    String? cameraName,
  }) async {
    // final List<RoverModel> roverPhotos = [];

    try {
      /*final url = Uri.parse(
        '${Constants.NASA_MARS_ROVER_BASE_URL}/rovers/$roverName/photos?sol=$sol'
            '${cameraName != null ? '&camera=$cameraName' : ''}'
            '&api_key=${Constants.NASA_API_KEY}',
      );*/
      final url = Uri.parse(
        '${Constants.NASA_MARS_ROVER_BASE_URL}/rovers/$roverName/photos?'
        '${earthDate != null ? 'earth_date=$earthDate&' : ''}'
        '${sol != null ? 'sol=$sol&' : ''}'
        '${cameraName != null ? 'camera=$cameraName&' : ''}'
        'api_key=${Constants.NASA_API_KEY}',
      );
      // Fetch multiple APOD images
      /*for (int i = 0; i < count; i++) {
        final url = Uri.parse(
            '${Constants.NASA_MARS_ROVER_BASE_URL}/rovers/$roverName/photos?sol=$sol'
            '${cameraName != null ? '&camera=$cameraName' : ''}'
            '&api_key=${Constants.NASA_API_KEY}',
        );

        final response = await client.get(url);

        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);

          // Only add if the media type is an image
          if (data['media_type'] == 'image') {
            roverPhotos.add(RoverModel.fromJson(data));
          }
        }
      }*/

      // return roverPhotos;

      final response = await client.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final photos = data['photos'] as List<dynamic>;

        // Take only the requested number of photos
        // final limitedPhotos = photos.take(count).toList();

        /*return limitedPhotos.map((photo){
          return RoverModel.fromJson({'photos': [photo]});
        }).toList();*/

        // Create a list of RoverModel with each photo
        return photos
            .map((photo) => RoverModel.fromJson({
                  'photos': [photo]
                }))
            .toList();
      } else {
        throw Exception('Failed to load Rover image : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load Rover image: $e');
    }
  }
}
