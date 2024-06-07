class DataModel {
  final String main;
  final String description;

  DataModel({required this.main, required this.description});

  factory DataModel.toJson(Map<String, dynamic> json) {
    var weather = json['weather'];
    return DataModel(
        main: weather['main'], description: weather['description']);
  }
}
