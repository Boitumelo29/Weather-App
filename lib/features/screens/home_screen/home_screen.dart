import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/networks/data_model/data_model.dart';
import 'package:weatherapp/networks/data_service/data_service.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController city = TextEditingController();
  DataService dataService = DataService();
  Future<WeatherModel>? dataModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.title, style: const TextStyle(color: Colors.blueGrey)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Text(
              "Please Enter Your city",
              style: TextStyle(color: Colors.blueGrey[300], fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: city,
              decoration: InputDecoration(border: ),
            ),
            ElevatedButton(
              onPressed: () {
                fetchWeatherData(city.text);
              },
              child: const Text("search"),
            ),
            if (dataModel != null)
              FutureBuilder<WeatherModel>(
                future: dataModel,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        tempIcon(snapshot.data!.humidity),
                        Text(city.text.toUpperCase()),
                        Text(snapshot.data!.main.toUpperCase()),
                        Text(snapshot.data!.description.toUpperCase()),
                        Text("${snapshot.data!.humidity}"),
                        Text("${snapshot.data!.temp}"),
                      ],
                    );
                  }
                  return const CircularProgressIndicator();
                },
              )
          ],
        ),
      ),
    );
  }

  void fetchWeatherData(String city) {
    if (city.isNotEmpty) {
      setState(() {
        dataModel = dataService.fetchData(city);
      });
    }
  }

  Icon tempIcon(int weather) {
    if (weather >= 100) {
      return const Icon(Icons.wb_sunny);
    } else if (weather >= 70) {
      return const Icon(Icons.cloud);
    } else if (weather >= 40) {
      return const Icon(Icons.water_drop_outlined);
    } else if (weather >= 30) {
      return const Icon(Icons.cloud);
    } else if (weather >= 0) {
      return const Icon(Icons.ac_unit);
    }
    return const Icon(Icons.error);
  }
}
