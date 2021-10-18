import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String?> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await FirebaseAuth.instance
          .signInWithCredential(credential)
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
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
  }
}
