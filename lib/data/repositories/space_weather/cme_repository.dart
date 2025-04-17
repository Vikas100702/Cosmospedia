// lib/data/repositories/space_weather/cme_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/space_weather/cme_model.dart';
import '../../../utils/constants.dart';

class CMERepository {
  final http.Client client;

  CMERepository({http.Client? client}) : client = client ?? http.Client();

  Future<List<CmeModel>> getCMEs({
    required String startDate,
    required String endDate,
  }) async {
    try {
      final url = Uri.parse(
        '${Constants.NASA_CME_BASE_URL}/CME?startDate=$startDate&endDate=$endDate&api_key=${Constants.NASA_API_KEY}',
      );

      final response = await client.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((e) => CmeModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to fetch CME data: ${response.statusCode}- ${response.body}');
      }
    } catch (error) {
      throw Exception('Failed to load CME data: $error');
    }
  }

  Future<List<CMEAnalysisModel>> getCMEAnalyses({
    required String startDate,
    required String endDate,
    bool mostAccurateOnly = true,
    double? speed,
    double? halfAngle,
    String catalog = 'ALL',
  }) async {
    try {
      var url = Uri.parse(
        '${Constants.NASA_CME_BASE_URL}/CMEAnalysis?'
            'startDate=$startDate&'
            'endDate=$endDate&'
            'mostAccurateOnly=$mostAccurateOnly&'
            'catalog=$catalog&'
            'api_key=${Constants.NASA_API_KEY}',
      );

      if (speed != null) {
        url = Uri.parse('$url&speed=$speed');
      }
      if (halfAngle != null) {
        url = Uri.parse('$url&halfAngle=$halfAngle');
      }

      final response = await client.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((e) => CMEAnalysisModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to fetch CME Analysis data: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load CME Analysis data: $error');
    }
  }
}