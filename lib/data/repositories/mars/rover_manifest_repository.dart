import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utils/constants.dart';
import '../../models/mars/rover_manifest.dart';

class RoverManifestRepository {
  final http.Client client;

  RoverManifestRepository({http.Client? client}) : client = client ?? http.Client();

  Future<RoverManifestModel> getRoverManifest(String roverName) async {
    try {
      final url = Uri.parse(
        '${Constants.NASA_MARS_ROVER_BASE_URL}/manifests/$roverName?api_key=${Constants.NASA_API_KEY}',
      );

      final response = await client.get(url);

      if(response.statusCode == 200) {
        final data = json.decode(response.body);
        return RoverManifestModel.fromJson(data['photo_manifest']);
      } else {
        throw Exception('Failed to fetch rover manifest : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load Rover image: $e');
    }
  }
}