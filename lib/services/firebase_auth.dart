import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthApp {
  late String _token;

  Future<Map<String, dynamic>> userSignin(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await FirebaseAuth.instance.currentUser!.getIdToken().then((value) {
          _token = value;
          if (_token != null || _token != "") {
            SharedPreferences.getInstance().then((value) {
              value.setString("userAuthToken", _token);
              _token = "";
            });
          }
        });
      });
      return {
        "success": true,
        "msg": "Cool!",
      };
    } catch (e) {
      return {
        "success": false,
        "msg": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> userSignup(String email, String password) async {
    try {
      var response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await FirebaseAuth.instance.currentUser!.getIdToken().then((value) {
          _token = value;
          if (_token != null || _token != "") {
            SharedPreferences.getInstance().then((value) {
              value.setString("userAuthToken", _token);
              _token = "";
            });
          }
        });
      });
      return {
        "success": true,
        "msg": response.toString(),
      };
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {}
      return {
        "success": false,
        "msg": e.code,
      };
    } catch (e) {
      return {
        "success": false,
        "msg": "Something went wrong!",
      };
    }
  }
}
