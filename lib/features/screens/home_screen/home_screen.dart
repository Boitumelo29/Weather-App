import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String title;

  const HomeScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    TextEditingController city = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              Container(),
              const Text("My Weather App"),
              const Text("Please Enter your Location"),
              //here would be a container that then adds default data the removes when you entered your data
              TextField(
                controller: city,
              ),
            // WeatherScreen(city: city.text)
            ],
          ),
        ),
      ),
    );
  }
}
