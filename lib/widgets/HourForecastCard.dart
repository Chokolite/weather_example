import 'package:flutter/material.dart';
import 'package:weather_example/utilites/Util.dart';
import 'package:weather_example/widgets/DetailView.dart';

Widget hourForecastCard(AsyncSnapshot snapshot, int index) {
  var hourlyList = snapshot.data.list;
  DateTime date =
  DateTime.fromMillisecondsSinceEpoch(hourlyList[index].dt * 1000);
  var fullDate = Util.getFormattedTime(date);
  var hour = "";
  hour = fullDate;
  var temp = hourlyList[index].main.temp.toInt();
  var icon = hourlyList[index].getIconUrl();
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Center(
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Text(
      //       hour,
      //       style: TextStyle(fontSize: 25, color: Colors.white),
      //     ),
      //   ),
      // ),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Column(
      //       children: [
      //         Row(
      //           children: [
      //             Padding(
      //               padding: const EdgeInsets.all(8.0),
      //               child:
    ExpansionTile(
      children: [
        DetailView(snapshot: snapshot, index: index,),
      ],
      title:                   Text(
                      "$temp °C",
                      style: TextStyle(fontSize: 30.0, color: Colors.white),
                    ),
                  subtitle: Text(hour, style: TextStyle(color: Colors.white),),
                  // ),
    leading:              Image.network(icon, scale: 1),
                // ],
              ),
            ],
          // ),
        // ],
      // ),
    // ],
  );
}
