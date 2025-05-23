import 'dart:convert';
import 'package:cosmospedia/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../../models/space_weather/gst_model.dart';


class GstRepository {

  Future<List<GstModel>> getGstEvents(
      String startDate, String endDate) async {
    final response = await http.get(
      Uri.parse('${Constants.NASA_DONKI_BASE_URL}/GST?startDate=$startDate&endDate=$endDate&api_key=${Constants.NASA_API_KEY}'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => GstModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load GST events');
    }
  }
}