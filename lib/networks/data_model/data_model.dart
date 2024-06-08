class WeatherModel {
  final String main;
  final String description;
  final double temp;
  final int humidity;
  final double wind;
  final double feelsLike;
  final int timezone;

  WeatherModel(
      {required this.main,
      required this.description,
      required this.temp,
      required this.humidity,
      required this.wind,
      required this.feelsLike,
        required this.timezone
      });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    var weatherList = json['weather'] as List<dynamic>?;
    if (weatherList == null || weatherList.isEmpty) {
      throw Exception("Weather data is missing or empty");
    }
    var weather = weatherList[0];
    var main = json['main'];
    var wind = json['wind'];
    return WeatherModel(
        main: weather['main'] ?? 'No data',
        description: weather['description'] ?? 'No data',
        temp: main['temp'] ?? 0.0,
        humidity: main['humidity'] ?? 0,
        wind: wind['speed'] ?? 0.0,
        feelsLike: main['feels_like'] ?? 0,
        timezone: json['timezone']

    );
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
