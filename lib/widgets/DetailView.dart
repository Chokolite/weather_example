import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:weather_example/models/weather_forecast_daily.dart';
import 'package:weather_example/utilites/Util.dart';

class DetailView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;
  final int index;

  const DetailView({this.snapshot, this.index});

  @override
  Widget build(BuildContext context) {
    var list = snapshot.data.list;
    var pressure = list[index].main.pressure * 0.750062;
    var humidity = list[index].main.humidity;
    var wind = list[index].wind.speed;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Util.getItem(FontAwesomeIcons.thermometerThreeQuarters, pressure.round(), "mm, Hg"),
          Util.getItem(FontAwesomeIcons.cloudRain, humidity, "%"),
          Util.getItem(FontAwesomeIcons.wind, wind.toInt(), "m/s"),
        ],
      ),
    );
  }
}
