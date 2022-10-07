import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget weatherWidget(
    size,
    IconData icon,
    String temp,
    String location,
    String weather,
    String pressure,
    String humidty,
    String visibility,
    String feels) {
  return Center(
    child: Column(
      children: [
        Text(
          "$temp°",
          style: const TextStyle(fontSize: 58, ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        Icon(
          icon,
          size: 80,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          weather,
          style: const TextStyle(fontSize: 26),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: size.width * 0.45,
              decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Text(
                "PRESSURE   $pressure hPa",
                style: const TextStyle(fontSize: 15),
              )),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 50,
              width: size.width * 0.45,
              decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Text(
                "HUMIDITY     $humidty",
                style: const TextStyle(fontSize: 15),
              )),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: size.width * 0.45,
              decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Text(
                "VISIBILITY    $visibility KM",
                style: const TextStyle(fontSize: 15),
              )),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 50,
              width: size.width * 0.45,
              decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Text(
                "FEELS LIKE    $feels°",
                style: const TextStyle(fontSize: 15),
              )),
            ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        Text(
          "Current location: \n$location",
          style: const TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
