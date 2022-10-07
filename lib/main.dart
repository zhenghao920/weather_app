import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/google_auth.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/home_page.dart';
import 'package:weather_app/login_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Navigate(),
      ),
      create: (context) => GoogleSignup(),
    );
  }
}

class Navigate extends StatelessWidget {
  const Navigate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return const HomePage();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          } else {
            return const LoginPage();
          }
        },
        stream: FirebaseAuth.instance.authStateChanges(),
      ),
    );
  }
}

// {
//   "coord":{"lon":101.5,"lat":3.1667},
//   "weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02d"}],
//   "base":"stations",
//   "main":{"temp":31.57,"feels_like":35.81,"temp_min":31.4,"temp_max":33.86,"pressure":1010,"humidity":59},
//   "visibility":10000,
//   "wind":{"speed":3.6,"deg":150},
//   "clouds":{"all":20},
//   "dt":1665035475,
//   "sys":{"type":2,"id":131484,"country":"MY","sunrise":1665010794,"sunset":1665054261},
//   "timezone":28800,
//   "id":1733037,
//   "name":"Selangor",
//   "cod":200
//   }
