class WeatherModel {
  final String main;
  final String description;

  WeatherModel({required this.main, required this.description});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    var weatherList = json['weather'] as List<dynamic>?;
    if (weatherList == null || weatherList.isEmpty) {
      throw Exception("Weather data is missing or empty");
    }
    var weather = weatherList[0];
    return WeatherModel(
        main: weather['main'] ?? 'No data',
        description: weather['description'] ?? 'No data');
  }
}

class MainModel {
  final double temp;
  final int humidity;

  MainModel({required this.temp, required this.humidity});

  factory MainModel.fromJson(Map<String, dynamic> json) {
    return MainModel(temp: json['temp'] ?? 0.0, humidity: json['humidity'] ?? 0);
  }
}
