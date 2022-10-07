import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/model/weather_data.dart';
import 'package:weather_app/repo/weather_api.dart';
import 'package:weather_app/weather_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherAPI weatherAPI = WeatherAPI();
  Weather? weather;
  double? lat, long;

  Future<void> getWeather() async {
    // var location = await Geolocator()
    //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // var lastLocation = await Geolocator().getLastKnownPosition();
    // // ignore: avoid_print
    // print(location.latitude);
    // // ignore: avoid_print
    // print(lastLocation);

    weather = await weatherAPI.fetchWeatherData(lat ?? 3.146, long ?? 101.71);
  }

  void getCurrentLocation() async {
    var location = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lastLocation = await Geolocator().getLastKnownPosition();
    // ignore: avoid_print
    print(lastLocation);
    print(weather!.weather![0]['main']);
    setState(() {
      lat = location.latitude;
      long = location.longitude;
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   weatherAPI.fetchWeatherData("Johor");
  // }

  @override
  Widget build(BuildContext context) {
    var sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
        body: FutureBuilder(
            future: getWeather(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    weatherWidget(
                      sizeScreen,
                      weather!.weather![0]["main"] == "Clouds" ||
                              weather!.weather![0]["main"] == "Rain"
                          ? Icons.wb_cloudy_outlined
                          : Icons.wb_sunny_outlined,
                      "${weather!.temp}",
                      "${weather!.cityName}",
                      "${weather!.weather![0]["main"]}",
                      "${weather!.pressure}",
                      "${weather!.humidity}",
                      "${weather!.visibility}",
                      "${weather!.feels}",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            onPrimary: Colors.white,
                            minimumSize: const Size(250, 50)),
                        onPressed: () {
                          getCurrentLocation();
                        },
                        icon: const Icon(Icons.map_outlined),
                        label: const Text('Get My Current Location')),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Please make sure you have allow the permission\n and open the location service",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    TextButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          // final provider =
                          //     Provider.of<GoogleSignup>(context, listen: false);
                          // provider.logout();
                        },
                        child: const Text(
                          'Logout',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        )),
                  ],
                );
              }
              return Container();
            }));
  }
}
