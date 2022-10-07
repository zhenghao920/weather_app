import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignup extends ChangeNotifier {
  final signup = GoogleSignIn();
  bool isGoogleLogin = false;
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  late var credential;

  Future googleSignup() async {
    try {
      //isGoogleLogin = false;
      final googleUser = await signup.signIn().catchError((e) => print(e));
      if (googleUser == null) {
        return null;
      }
      _user = googleUser;

      final googleAuth = await googleUser.authentication;
      credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      const Duration(seconds: 3);
      isGoogleLogin = true;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }

    notifyListeners();
  }

  Future logout() async {
    await signup.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
