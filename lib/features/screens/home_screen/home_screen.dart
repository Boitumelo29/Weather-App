import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/networks/data_model/data_model.dart';
import 'package:weatherapp/networks/data_service/data_service.dart';
import 'package:weatherapp/networks/funtions/fetch_weather.dart';
import 'package:weatherapp/utils/times/times.dart';

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
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                dailyMeeting(),
                style: TextStyle(color: Colors.blueGrey[300], fontSize: 30),
              ),
              Text(
                city.text.toUpperCase(),
                style: TextStyle(
                  color: Colors.blueGrey[400],
                  fontSize: 10,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                textCapitalization: TextCapitalization.characters,
                controller: city,
                decoration: InputDecoration(
                  hintText: "Search",
                  suffixIcon: IconButton(
                    onPressed: () {
                      fetchWeatherData(city.text);
                    },
                    icon: const Icon(Icons.search, color: Colors.blueGrey),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.blueGrey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.blueGrey),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (dataModel != null)
                FutureBuilder<WeatherModel>(
                  future: dataModel,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Center(
                        child: Column(
                          children: [
                            Container(
                              width: 320,
                              height: 440,
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(18)),
                              child: Column(
                                children: [
                                  Text(
                                    city.text.toUpperCase(),
                                    style: const TextStyle(fontSize: 30),
                                  ),
                                  Text(CurrentTimes.date),
                                  Text(CurrentTimes.time),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  FetchWeatherIcon.tempIcon(
                                      snapshot.data!.humidity),
                                  Text("${snapshot.data!.temp}"),
                                  Text(snapshot.data!.main.toUpperCase()),
                                  Text(
                                      snapshot.data!.description.toUpperCase()),
                                  Text("Humidity: ${snapshot.data!.humidity}"),
                                  Text("Wind: ${snapshot.data!.wind}"),
                                  Text(
                                      "Feels Like: ${snapshot.data!.feelsLike}"),
                                  Text("TimeZone: ${snapshot.data!.timezone}"),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              color: Colors.blue,
                            )
                          ],
                        ),
                      );
                    }
                    return const CircularProgressIndicator(
                      color: Colors.blueGrey,
                    );
                  },
                )
            ],
          ),
        ),
      ),
    );
  }

  String dailyMeeting() {
    final currentTime = DateTime.now();
    final hour = currentTime.hour;

    if (hour >= 0 && hour < 12) {
      return "Good Morning";
    } else if (hour >= 12 && hour < 18) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  void fetchWeatherData(String city) {
    if (city.isNotEmpty) {
      setState(() {
        dataModel = dataService.fetchData(city);
      });
    }
  }
}
