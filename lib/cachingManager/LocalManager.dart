import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_example/models/weather_forecast_daily.dart';

class Manager{
  static Manager get instance {
    if(_instance == null){
      _instance = Manager._init();
    }
    return _instance;
  }

  static Manager _instance;
  Manager._init();

  SharedPreferences _preferences;
  Future<SharedPreferences> get preferences async{
    if(_preferences == null){
      _preferences = await SharedPreferences.getInstance();
    }
     return _preferences;
  }

  Future<WeatherForecast> getJsonDataModel(String user) async{
    final _pref = await preferences;
    final jsonModel = jsonDecode(_pref.getString(user));
    final model = WeatherForecast.fromJson(jsonModel);
    return model;
  }

  Future<bool> writeUserDataJson(dynamic json, String username) async{
    final _pref = await preferences;
    return await _pref.setString(username, json);
  }

  Future<bool> removeUserDataJson(String username) async{
    final _pref = await preferences;
    return await _pref.remove(username);
  }

}