import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/networks/data_model/data_model.dart';

class DataService {
  Future<DataModel> fetchData(String city) async {
    final queryParameter = {
      'q': city,
      'appid': '683a928354e9a6a491bf5e5e8f6cdc2d'
    };
    final uri =
        Uri.https('api.openweathermap.org', 'data/2.5/weather', queryParameter);

    final response = await http.get(uri);

    try {
      final jsonData = json.decode(response.body);
      return DataModel.fromJson(jsonData);
    } catch (e) {
      print(e);
    }

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      return DataModel.fromJson(jsonResponse);
    } else {
      throw "Error fetching weather data";
    }
  }
}
