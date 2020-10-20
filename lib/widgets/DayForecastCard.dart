import 'package:flutter/material.dart';
import 'package:weather_example/utilites/Util.dart';
import 'package:weather_example/widgets/DetailView.dart';

Widget dayForecastCard(AsyncSnapshot snapshot, int index) {
  var dailyList = snapshot.data.list;
  if(index > 4) {
    index = index - 4;
  }

  DateTime date =
      DateTime.fromMillisecondsSinceEpoch(dailyList[index].dt * 1000);
  var fullDate = Util.getFormattedDate(date);
  var dayOfWeek = fullDate.split(",")[0];
  var temp = dailyList[index].main.temp.toInt();
  var icon = dailyList[index].getIconUrl();
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      ExpansionTile(
        children: [
           DetailView(snapshot: snapshot, index: index,),
        ],
        title:                   Text(
          "$temp °C",
          style: TextStyle(fontSize: 30.0, color: Colors.white),
        ),
        subtitle: Text(dayOfWeek, style: TextStyle(color: Colors.white),),
        // ),
        leading:              Image.network(icon, scale: 1),
        // ],
      ),
    ],
  );
}
