class WeatherModel {
  final String main;
  final String description;
  final double temp;
  final int humidity;

  WeatherModel(
      {required this.main,
      required this.description,
      required this.temp,
      required this.humidity});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    var weatherList = json['weather'] as List<dynamic>?;
    if (weatherList == null || weatherList.isEmpty) {
      throw Exception("Weather data is missing or empty");
    }
    var weather = weatherList[0];
    var main = json['main'];
    return WeatherModel(
        main: weather['main'] ?? 'No data',
        description: weather['description'] ?? 'No data',
        temp: main['temp'] ?? 0.0,
        humidity: main['humidity'] ?? 0);
  }
}

class MainModel {
  final double temp;
  final int humidity;

  MainModel({required this.temp, required this.humidity});

  factory MainModel.fromJson(Map<String, dynamic> json) {
    return MainModel(
        temp: json['temp'] ?? 0.0, humidity: json['humidity'] ?? 0);
  }
}
