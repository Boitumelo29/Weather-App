import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/networks/data_model/data_model.dart';

class DataService {
  Future<WeatherModel> fetchData(String city) async {
   //https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
    final queryParameter = {
      'q': city,
      'appid': '4b607a8cacc92ab5153f2f69b3ae5b80'
    };
    final uri =
        Uri.https('api.openweathermap.org', 'data/2.5/weather', queryParameter);

    final response = await http.get(uri);
    print(response.body);

    try {
      final jsonData = json.decode(response.body);
      return WeatherModel.fromJson(jsonData);
    } catch (e) {
      print(e);
    }

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      return WeatherModel.fromJson(jsonResponse);
    } else {
      throw "Error fetching weather data";
    }
  }

  Future<MainModel> fetchMainData(String city) async {
    final queryParameter = {
      'q': city,
      'appid': '683a928354e9a6a491bf5e5e8f6cdc2d'
    };
    final uri =
        Uri.https('api.openweathermap.org', 'data/2.5/weather', queryParameter);

    final response = await http.get(uri);
    print(response.body);

    try {
      return MainModel.fromJson(json.decode(response.body));
    } catch (e) {
      print(e);
    }
    throw "";
  }
}
