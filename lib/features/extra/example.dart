import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: WeatherPage(),
      ),
    );
  }
}

class WeatherPage extends StatefulWidget {
  final String? city;

  const WeatherPage({super.key, this.city});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final DataServices dataServices = DataServices();
  final TextEditingController search = TextEditingController();

  late Future<WeatherResponse> dataService;
  bool _isLoading = false;
  WeatherResponse? weatherResponse;

  @override
  void initState() {
    super.initState();
    dataService = dataServices.getWeatherResponse(widget.city ?? "cape town");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WeatherResponse>(
      future: dataService,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final weather = snapshot.data!;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.sunny,
                  size: 30,
                  color: Colors.yellow,
                ),
                Text(weather.description),
                const SizedBox(height: 10),
                TextField(
                  controller: search,
                  decoration: const InputDecoration(
                    hintText: 'Enter city',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _loadWeather(search.text);
                  },
                  child: const Text("Search"),
                ),
                _isLoading
                    ? const CircularProgressIndicator()
                    : weatherResponse != null
                    ? Text(weatherResponse!.description)
                    : Container(
                  color: Colors.amber,
                  height: 50,
                  width: 50,
                ),
              ],
            ),
          );
        }
        return const Text('No data');
      },
    );
  }

  Future<void> _loadWeather(String city) async {
    setState(() {
      _isLoading = true;
    });

    try {
      var weather = await dataServices.getWeatherResponse(city);
      setState(() {
        weatherResponse = weather;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
    }
  }
}

class DataServices {
  Future<WeatherResponse> getWeatherResponse(String city) async {
    final queryParameter = {
      'q': city,
      'appid': '683a928354e9a6a491bf5e5e8f6cdc2d'
    };
    final uri =
    Uri.https('api.openweathermap.org', 'data/2.5/weather', queryParameter);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse); // Print the JSON response
      return WeatherResponse.fromJson(jsonResponse);
    } else {
      // Print the status code and response body for debugging
      print('Request failed with status: ${response.statusCode}.');
      print('Response body: ${response.body}');
      throw "Error fetching weather data";
    }
  }
}

class WeatherResponse {
  final String description;

  WeatherResponse({required this.description});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    // Add a null check for the 'weather' key
    if (json['weather'] != null && json['weather'].isNotEmpty) {
      return WeatherResponse(
        description: json['weather'][0]['description'] ?? 'No description',
      );
    } else {
      throw "Invalid weather data";
    }
  }
}
