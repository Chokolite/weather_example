import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_example/api/WeatherApi.dart';
import 'package:weather_example/app_localizations.dart';

import 'package:weather_example/models/weather_forecast_daily.dart';
import 'package:weather_example/screens/AuthScreen.dart';
import 'package:weather_example/widgets/CityView.dart';
import 'package:weather_example/widgets/HourListView.dart';
import 'package:weather_example/widgets/WeekListView.dart';

class WeatherForecastScreen extends StatefulWidget {
  final locationWeather;

  WeatherForecastScreen({this.locationWeather});

  @override
  _WeatherForecastScreenState createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  Future<WeatherForecast> forescastObject;

  @override
  void initState() {
    super.initState();

    if (widget.locationWeather != null) {
      forescastObject = Future.value(widget.locationWeather);
    }
  }

  bool _days = true;

  @override
  Widget build(BuildContext context) {
    var translate = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("openweathermap.org"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AuthScreen()));
            },
          ),
          actions: [
            DropdownButtonHideUnderline(
              child: DropdownButton(
                icon: Icon(
                  Icons.arrow_downward,
                  color: Colors.white,
                ),
                dropdownColor: Colors.black87,
                value: _days,
                items: [
                  DropdownMenuItem(
                    child: Text(
                      translate.translate("Days"),
                      style: TextStyle(color: Colors.white),
                    ),
                    value: true,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      translate.translate("Hours"),
                      style: TextStyle(color: Colors.white),
                    ),
                    value: false,
                  ),
                ],
                onChanged: (value) => setState(() {
                  _days = value;
                }),
              ),
            ),
          ]),
      body: ListView(
        children: [
          Container(
            child: FutureBuilder<WeatherForecast>(
              future: forescastObject,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      CityView(
                        snapshot: snapshot,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      (_days == true)
                          ? WeekListView(snapshot: snapshot)
                          : HourListView(
                              snapshot: snapshot,
                            ),
                    ],
                  );
                } else {
                  return Center(
                    child: SpinKitDoubleBounce(
                      color: Colors.black87,
                      size: 100,
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
