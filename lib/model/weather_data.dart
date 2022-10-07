import 'package:flutter/cupertino.dart';

class Weather {
  String? cityName;
  num? temp;
  List? weather;
  num? pressure, humidity, visibility, feels;

  Weather({this.cityName, this.temp, this.weather});

  Weather.fromJson(Map<String, dynamic> json) {
    cityName = json["name"];
    temp = json["main"]["temp"];
    weather = json["weather"];
    pressure = json["main"]["pressure"];
    humidity = json["main"]["humidity"];
    visibility = json["visibility"]/1000;
    feels = json["main"]["feels_like"];
  }
}
