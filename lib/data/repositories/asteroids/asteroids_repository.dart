import 'dart:convert';

import 'package:cosmospedia/data/models/asteroids/asteroids_model.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constants.dart';

class AsteroidsRepository {
  final http.Client client;

  AsteroidsRepository({http.Client? client}) : client = client ?? http.Client();

  Future<List<Asteroid>> getAsteroids() async {
    try {
      final url = Uri.parse(
          '${Constants.NASA_ASTEROIDS_NEOS_BASE_URL}browse?api_key=${Constants
              .NASA_API_KEY}');
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final asteroids = (data['near_earth_objects'] as List).map((e) =>
            Asteroid.fromJson(e)).toList();
        return asteroids;
      } else {
        throw Exception('Failed to fetch asteroids: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load asteroids: $error');
    }
  }
}
