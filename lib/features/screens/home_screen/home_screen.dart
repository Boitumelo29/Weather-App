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
  Future<DataModel>? dataModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Text("My Weather App"),
          const Text("Please Enter your Location"),
          TextField(
            controller: city,
          ),
          ElevatedButton(
            onPressed: () {
              fetchWeatherData(city.text);
            },
            child: const Text("search"),
          ),
          if (dataModel != null)
            FutureBuilder<DataModel>(
              future: dataModel,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text(snapshot.data!.main),
                      Text(snapshot.data!.description)
                    ],
                  );
                }
                return const CircularProgressIndicator();
              },
            )
        ],
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
}
