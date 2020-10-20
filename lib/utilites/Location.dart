import 'package:geolocator/geolocator.dart';

class Location {
  double lattitude;
  double longtitude;

  Future<void> getCurrentLocation() async{
    try{
      Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      lattitude = position.latitude;
      longtitude = position.longitude;
    }catch(e){
      throw "something goes wrong $e";
    }
  }
}