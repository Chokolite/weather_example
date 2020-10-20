import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weather_example/cachingManager/LocalManager.dart';

class AuthService extends ChangeNotifier {

  Manager _manager = Manager.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult =
      await _auth.signInWithCredential(credential);

      final User user = authResult.user;

      // return _userFromFirebaseUser(user);
      return user.uid.toString();
    } catch (e) {
      print("Sing in with Google error: $e");
      return null;
    }
  }

  String get user {
    try {
      User user = _auth.currentUser;
      if (user == null) {
        return null;
      } else {
        return user.uid;
      }
    } on Error catch(e){
      print("get user error $e");
      return null;
    }
  }

  signOut() {
    _googleSignIn.disconnect();
    _auth.signOut();
  }

  bool checkUser(){
    if(_manager.getJsonDataModel(user) != null){
      return true;
    }
    return false;
  }
}