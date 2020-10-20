import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:weather_example/cachingManager/LocalManager.dart';
import 'package:weather_example/models/weather_forecast_daily.dart';
import 'package:weather_example/service/AuthService.dart';
import 'package:weather_example/utilites/Location.dart';
import 'package:weather_example/utilites/constants.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  AuthService _auth = AuthService();
  Manager _manager = Manager.instance;

  Future<WeatherForecast> fetcWeatherForecast() async {
    String user = _auth.user;
    String defaultUser = "defaultUser";
    int timeout = 55;
    var response;
    bool useDefaultCity = false;
    String defaultCity = "Kiev";
    Location location;

    try {
      location = Location();
      await location.getCurrentLocation();
    } catch (e) {
      useDefaultCity = true;
      log("Location error");
    }
    Map<String, String> parameters;

    if (useDefaultCity == true) {
      var queryParameter = {
        "APPID": Constants.WEATHER_APP_ID,
        "units": "metric",
        "q": defaultCity,
      };

      parameters = queryParameter;
    } else {
      var queryParameter = {
        "APPID": Constants.WEATHER_APP_ID,
        "units": "metric",
        "lat": location.lattitude.toString(),
        "lon": location.longtitude.toString(),
      };

      parameters = queryParameter;
    }

    var uri = Uri.https(Constants.WEATHER_BASE_API_URL_DOMAIN,
        Constants.WEATHER_ONECALL_PATH, parameters);
    log("request: ${uri.toString()}");
    log("user $user");
    try {
      response = await http.get(uri).timeout(Duration(seconds: timeout));
      log("response: ${response?.body}");
    } on TimeoutException catch (e) {
      log('Timeout Error: $e');
      return _manager.getJsonDataModel(user);
    } on SocketException catch (e) {
      log('Socket Error: $e');
      if (user == null) {
        return _manager.getJsonDataModel(defaultUser);
      } else {
        return _manager.getJsonDataModel(
            user); // when out of internet - getting model with data from cache
      }
    } on Error catch (e) {
      log('General Error: $e');
    }

    if (response.statusCode == 200) {
      //caching our user json file
      if (user == null) {
        _manager.writeUserDataJson(response.body, defaultUser);
      } else {
        _manager.writeUserDataJson(response.body, user);
      }
      return WeatherForecast.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error response");
    }
  }
}
