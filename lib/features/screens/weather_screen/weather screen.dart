import 'package:flutter/material.dart';
import 'package:weatherapp/networks/data_model/data_model.dart';
import 'package:weatherapp/networks/data_service/data_service.dart';

class WeatherScreen extends StatefulWidget {
  final String city;

  const WeatherScreen({super.key, required this.city});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<DataModel> dataModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dataModel = DataService().fetchData(widget.city);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dataModel,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Container(),
              const Text("My Weather App"),
              const Text("Please Enter your Location"),
              //here would be a container that then adds default data the removes when you entered your data
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
