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
                    try {
                      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: "hegazysmart@gmail.com",
                          password: "P@\$\$w0rd!"
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }
                    print(userCredential.user);
                    if (!userCredential.user.emailVerified) {
                      print('verify your mail, please!');
                    }
                    else{
                      signIn();
                    }
                  },
                  child: Text("Sign In"),
                )),
            Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                  child: Text("Sign out"),
                ))
          ],
        ));
  }
  signIn(){
    print('signed in');
  }
}






