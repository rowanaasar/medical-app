import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medhouse_project/widget/button.dart';



class Auth extends StatefulWidget {
  Auth({Key key}) : super(key: key);
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  UserCredential emailUserCredential, googleUserCred;
  TextEditingController fullName = new TextEditingController();
  TextEditingController passward = new TextEditingController();
  TextEditingController email = new TextEditingController();
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0FB8B3),
      ),
      body: buildContent(BuildContext),
      backgroundColor: Color(0xFF0FB8B3),
    );
  }
  Widget buildContent(context) {
    return Container(
        padding: EdgeInsets.all(60.0),
        child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Create an Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Wrap(children: [
                  Text(
                    'MedHouse helps you to get your medication and contact with doctors easily.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ]),
                SizedBox(
                  height: 40.0,
                ),
                Text(
                  'Full Name',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextField(
                  obscureText: false,
                  controller: fullName,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: 'John Doe',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Email',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextField(
                  obscureText: false,
                  controller: email,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: 'Phone or Email',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Passward',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextField(
                  obscureText: true,
                  controller: passward,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: '********',
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                CustomRaisedButton(
                      onPressed: () async {
                        try {
                          emailUserCredential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                              email: "mmmmhegazysmart@gmail.com",
                              password: "mime@@##15ovbh!");
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            print('The account already exists for that email.');
                          }
                        } catch (e) {
                          print(e);
                        }
                        print(emailUserCredential.user);
                        User user = FirebaseAuth.instance.currentUser;
                        if (!user.emailVerified) {
                          await user.sendEmailVerification();
                          print('verify your mail, please!');
                        } else {
                          print('hello');
                        }
                      },
                      child: Text("Register Demo",style: TextStyle(color: Color(0xFF0FB8B3), fontSize: 15),),
                    ),
                SizedBox(
                  height: 50.0,
                ),
                CustomRaisedButton(
                    child: Text("Register with google",style: TextStyle(color: Color(0xFF0FB8B3), fontSize: 15),),
                    onPressed: () async {
                      googleUserCred = await signInWithGoogle();
                    },
                    ),
              ],
            ),
        ),
    );
  }
}
