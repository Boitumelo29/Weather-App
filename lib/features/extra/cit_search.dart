import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CityService {
  static const String apiUrl = "https://wft-geo-db.p.rapidapi.com/v1/geo/cities";
  static const Map<String, String> headers = {
    'X-RapidAPI-Host': 'wft-geo-db.p.rapidapi.com',
    'X-RapidAPI-Key': 'YOUR_RAPIDAPI_KEY', // Replace with your RapidAPI key
  };

  Future<List<String>> fetchCities(String query) async {
    final response = await http.get(
      Uri.parse("$apiUrl?namePrefix=$query"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> citiesJson = json.decode(response.body)['data'];
      return citiesJson.map((json) => json['city'] as String).toList();
    } else {
      print('Failed to load cities. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load cities');
    }
  }
}
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CitySearchScreen(),
    );
  }
}

class CitySearchScreen extends StatefulWidget {
  @override
  _CitySearchScreenState createState() => _CitySearchScreenState();
}

class _CitySearchScreenState extends State<CitySearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final CityService _cityService = CityService();
  List<String> _cities = [];
  bool _isLoading = false;

  void _searchCities() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final cities = await _cityService.fetchCities(_controller.text);
      setState(() {
        _cities = cities;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load cities')),
      );
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('City Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter city name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchCities,
                ),
              ),
            ),
            SizedBox(height: 20),
            if (_isLoading) CircularProgressIndicator(),
            if (!_isLoading)
              Expanded(
                child: ListView.builder(
                  itemCount: _cities.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_cities[index]),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}