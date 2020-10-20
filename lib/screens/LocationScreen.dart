import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_example/api/WeatherApi.dart';
import 'package:weather_example/app_localizations.dart';
import 'package:weather_example/screens/WeatherForecastScreen.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {


  void getLocationData() async {
    try{
      var weatherInfo = await WeatherApi().fetcWeatherForecast();
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return WeatherForecastScreen(locationWeather: weatherInfo,);
      })
      );
    } catch(e){
      print("$e");

    }


  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context).translate("Loading")),
            SizedBox(height: 20,),
            SpinKitDoubleBounce(color: Colors.black87, size: 100.0,),
          ],
        ),
      ),
    );
  }
}
