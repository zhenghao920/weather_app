import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/google_auth.dart';
import 'package:weather_app/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoad = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: getBody()),
    );
  }

  void loginFacebook() async {
    setState(() {
      isLoad = true;
    });
    try {
      final fbLogin = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();

      final fbAuthCredential =
          FacebookAuthProvider.credential(fbLogin.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(fbAuthCredential);
      print("login successful");
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (_) => const HomePage()), (route) => false);
    } catch (e) {
      print(e.toString());
    }
  }

  Widget getBody() {
    return Column(
      children: [
        const SizedBox(height: 70),
        const Text(
          "Welcome to",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w200),
        ),
        const Text(
          "iWeather",
          style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 180),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                primary: Colors.black,
                onPrimary: Colors.white,
                minimumSize: const Size(250, 50)),
            onPressed: () async {
              try {
                final provider =
                    Provider.of<GoogleSignup>(context, listen: false);
                await provider.googleSignup();
                provider.isGoogleLogin == true
                    ? await FirebaseAuth.instance
                        .signInWithCredential(provider.credential)
                    : const CircularProgressIndicator();
              } on FirebaseAuthException catch (e) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Warning!'),
                          content: Text(e.message.toString()),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Ok')),
                          ],
                        ));
              }
            },
            icon: const FaIcon(
              FontAwesomeIcons.google,
            ),
            label: const Text('Continue with Google')),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                primary: Colors.black,
                onPrimary: Colors.white,
                minimumSize: const Size(250, 50)),
            onPressed: () async {
              try {
                loginFacebook();
              } on FirebaseAuthException catch (e) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Warning!'),
                          content: Text(e.message.toString()),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Ok')),
                          ],
                        ));
              }
            },
            icon: const FaIcon(
              FontAwesomeIcons.facebook,
            ),
            label: const Text('Continue with Facebook')),
      ],
    );
  }
}
