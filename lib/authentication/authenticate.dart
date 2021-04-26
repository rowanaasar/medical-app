import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  Auth({Key key}) : super(key: key);
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  UserCredential userCredential;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Auth'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: ElevatedButton(
                  onPressed: () async {
                    userCredential = await FirebaseAuth.instance.signInAnonymously();
                    print(userCredential.user.uid);
                  },
                  child: Text("Sign in Anonymously"),
                ))
          ],
        ));
  }
}