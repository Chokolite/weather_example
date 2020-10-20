import 'package:flutter/material.dart';
import 'package:weather_example/app_localizations.dart';

import 'package:weather_example/models/weather_forecast_daily.dart';
import 'package:weather_example/widgets/DayForecastCard.dart';

class WeekListView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;

  WeekListView({this.snapshot});

  @override
  Widget build(BuildContext context) {
    var translate = AppLocalizations.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          translate.translate("5 day"),
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 1.5,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => (index % 8 == 0)
                    ? Container(
                        width: MediaQuery.of(context).size.width / 2.7,
                        color: Colors.black87,
                        child: dayForecastCard(snapshot, index),
                      )
                    : SizedBox(
                        height: 1,
                      ),
                itemCount: snapshot.data.list.length),
          ),
        )
      ],
    );
  }
}
