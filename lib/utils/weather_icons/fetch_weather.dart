import 'package:flutter/material.dart';

class FetchWeatherIcon{
  static Icon tempIcon(int weather) {
    if (weather >= 100) {
      return const Icon(
        Icons.wb_sunny,
        size: 120,
        color: Colors.yellow,
      );
    } else if (weather >= 70) {
      return const Icon(
        Icons.cloud,
        size: 120,
        color: Colors.blue,
      );
    } else if (weather >= 40) {
      return const Icon(
        Icons.water_drop_outlined,
        size: 120,
        color: Colors.blueAccent,
      );
    } else if (weather >= 30) {
      return const Icon(
        Icons.cloud,
        size: 120,
        color: Colors.blue,
      );
    } else if (weather >= 0) {
      return const Icon(
        Icons.ac_unit,
        color: Colors.blueGrey,
        size: 120,
      );
    }
    return const Icon(
      Icons.error,
      size: 120,
      color: Colors.red,
    );
  }

}