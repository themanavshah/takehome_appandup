import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:take_home/general_layout.dart';
import 'package:take_home/screens/auth/auth_screen.dart';
import 'package:take_home/screens/splash/splash_screen.dart';

class AuthHomeDecider extends StatelessWidget {
  const AuthHomeDecider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? const AuthScreen()
        : FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              }
              if (snapshot.hasError) {
                Fluttertoast.showToast(
                  msg: "Something went wrong",
                  toastLength: Toast.LENGTH_LONG,
                  timeInSecForIosWeb: 7,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 15,
                );
                return const SplashScreen();
              }
              SharedPreferences prefs = snapshot.data;
              bool _isLoggedin = prefs.containsKey("userAuthToken");
              return _isLoggedin ? const GeneralLayout() : const AuthScreen();
            });
  }
}
