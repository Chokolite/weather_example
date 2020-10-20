import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_example/screens/LocationScreen.dart';
import 'package:weather_example/service/AuthService.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthService _auth = AuthService();
  String user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                RaisedButton(
                  child: Text("refresh"),
                  onPressed: () {
                    setState(() {
                      user = _auth.user;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                    child: Text("Log in"),
                    onPressed: () {
                      setState(() async {
                        await _auth.signInWithGoogle();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LocationScreen()));
                      });
                    }),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                    child: Text("Log out"),
                    onPressed: () {
                      setState(() {
                        user = _auth.signOut();
                      });
                    }),
                SizedBox(
                  height: 20,
                ),
                Text("$user"),
              ]),
        ),
      ),
    );
  }
}
