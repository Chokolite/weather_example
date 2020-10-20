import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Util{
  static String getFormattedDate(DateTime dateTime){
    return DateFormat("EEEE, MMM d, y").format(dateTime);  //Tue, May, 5, 2020
  }

  static String getFormattedTime(DateTime dateTime){
    return DateFormat("HH:mm, EEEE, MMM d").format(dateTime);
  }

  static getItem(IconData iconData, int value, String units){
    return Column(
      children: [
        Icon(iconData, color: Colors.white, size: 28,),
        SizedBox(height: 20,),
        Text("$value", style: TextStyle(fontSize: 20, color: Colors.white)),
        SizedBox(height: 10,),
        Text("$units", style: TextStyle(fontSize: 15, color: Colors.white),),
      ],
    );
  }
}