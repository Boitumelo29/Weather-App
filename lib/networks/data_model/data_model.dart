class DataModel {
  final String main;
  final String description;

  DataModel({required this.main, required this.description});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    var weatherList = json['weather'] as List<dynamic>?;
    if (weatherList == null || weatherList.isEmpty) {
      throw Exception("Weather data is missing or empty");
    }
    var weather = weatherList[0];
    return DataModel(
        main: weather['main'] ?? 'No data',
        description: weather['description'] ?? 'No data');
  }
}
