import 'package:flutter/material.dart';
import 'package:weatherapp/networks/data_model/data_model.dart';
import 'package:weatherapp/networks/data_service/data_service.dart';
import 'package:weatherapp/utils/times/times.dart';
import 'package:weatherapp/utils/weather_icons/fetch_weather.dart';

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
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          // decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //   begin: Alignment.topRight,
          //   end: Alignment.bottomLeft,
          //   stops: [
          //     0.1,
          //     0.4,
          //     0.6,
          //     0.9,
          //   ],
          //   colors: [Colors.black45, Colors.black12],
          // )),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 45,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          CurrentTimes.dailyMeeting(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 30),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 30,
                            ))
                      ],
                    ),
                    Text(
                      city.text.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white60,
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
                          icon: const Icon(Icons.search, color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.white),
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
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        // stops: const [
                                        //   0.1,
                                        //   0.4,
                                        //boitumelo thobejane
                                        // ],
                                        colors: [
                                          Colors.blue,
                                          Colors.black,
                                        ],
                                      ),
                                    ),
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
                                        Text(snapshot.data!.description
                                            .toUpperCase()),
                                        Text(
                                            "Humidity: ${snapshot.data!.humidity}"),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                                "Wind: ${snapshot.data!.wind}"),
                                            const Text("|"),
                                            Text(
                                                "Feels Like: ${snapshot.data!.feelsLike}"),
                                            const Text("|"),
                                            Text(
                                                "TimeZone: ${snapshot.data!.timezone}"),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            );
                          }
                          return const CircularProgressIndicator(
                            color: Colors.white,
                          );
                        },
                      )
                    else
                      Container(
                        color: Colors.red,
                      )
                  ],
                ),
              ),
            ],
          ),
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
}
