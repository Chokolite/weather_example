import 'package:flutter/material.dart';
import 'package:weather_example/app_localizations.dart';

import 'package:weather_example/models/weather_forecast_daily.dart';
import 'package:weather_example/widgets/HourForecastCard.dart';

class HourListView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;
  HourListView({this.snapshot});

  @override
  Widget build(BuildContext context) {
    var translate = AppLocalizations.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(translate.translate("Hourly weather"),
          style: TextStyle(
          fontSize: 20.0,
          color: Colors.black87,
          fontWeight: FontWeight.bold,),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 1.5,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: ListView.separated(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => Container(
                  color: Colors.black87,
                  child: hourForecastCard(snapshot, index),
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: 8,
              ),
              itemCount: snapshot.data.list.length),
        ),
      ],
    );
  }
}
