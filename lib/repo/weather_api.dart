import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_data.dart';
import 'dart:async';

class WeatherAPI {
  Future<Weather>? fetchWeatherData(double latitube, double longitube) async {
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitube&lon=$longitube&appid=a3c97762833bcd389bdc5f95510a1295&units=metric");
    var response = await http.get(url);
    var body = jsonDecode(response.body);

    return Weather.fromJson(body);
  }
}
