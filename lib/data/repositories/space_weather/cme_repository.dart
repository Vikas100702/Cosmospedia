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
        '${Constants.NASA_DONKI_BASE_URL}/CME?startDate=$startDate&endDate=$endDate&api_key=${Constants.NASA_API_KEY}',
      );

      final response = await client.get(url);
      print('CME API Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData is List) {
          return responseData.map<CmeModel>((e) {
            try {
              if (e is Map<String, dynamic>) {
                return CmeModel.fromJson(e);
              } else {
                print('Unexpected item type: ${e.runtimeType}');
                return _createErrorCMEModel();
              }
            } catch (e, stack) {
              print('Error parsing CME item: $e\n$stack');
              print('Problematic item: $e');
              return _createErrorCMEModel();
            }
          }).where((model) => model.activityID != 'error').toList();
        } else if (responseData is Map<String, dynamic>) {
          // Handle single object response
          return [CmeModel.fromJson(responseData)];
        }
        return [];
      } else {
        throw Exception('Failed to fetch CME data: ${response.statusCode} - ${response.body}');
      }
    } catch (error, stackTrace) {
      print('Error loading CME data: $error\n$stackTrace');
      throw Exception('Failed to load CME data: $error');
    }
  }

  CmeModel _createErrorCMEModel() {
    return const CmeModel(
      activityID: 'error',
      catalog: 'error',
      startTime: '1970-01-01T00:00Z',
      instruments: [],
      note: 'Error parsing data',
      submissionTime: '1970-01-01T00:00Z',
      versionId: 0,
      link: '',
      cmeAnalyses: null,
      linkedEvents: null,
    );
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
        '${Constants.NASA_DONKI_BASE_URL}/CMEAnalysis?'
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
        throw Exception(
            'Failed to fetch CME Analysis data: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load CME Analysis data: $error');
    }
  }
}
