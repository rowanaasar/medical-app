import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medhouse_project/widget/button.dart';

import 'login_screen.dart';



class PersonAccount extends StatefulWidget {
  PersonAccount({Key key}) : super(key: key);
  @override
  _PersonAccountState createState() => _PersonAccountState();
}

class _PersonAccountState extends State<PersonAccount> {
  UserCredential emailUserCredential, googleUserCred;
  TextEditingController fullName = new TextEditingController();
  TextEditingController passward = new TextEditingController();
  TextEditingController email = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
    return Form(
      key:  _formKey,
      child: Container(
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
              TextFormField(
                obscureText: false,
                controller: fullName,
                autofillHints: [AutofillHints.name],
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'John Doe',
                  filled: true,
                  fillColor: Colors.white,
                ),
                //ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This field is required';
                }}
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
              TextFormField(
                obscureText: false,
                controller: email,
                autofillHints: [AutofillHints.email],
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'Phone or Email',
                  filled: true,
                  fillColor: Colors.white,
                ),
                  // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This field is required';
                  }
                  if (!value.contains('@')) {
                    return "Not valid email ";
                  }
                  if (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                  ).hasMatch(value)) {
                    return "Please enter a valid email";
                  }
                },
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
              TextFormField(
                obscureText: true,
                controller: passward,
                autofillHints: [AutofillHints.password],
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: '********',
                ),
                // ignore: missing_return
                validator: (value){
                    if (value.isEmpty) {
                      return 'This field is required';
                      }
                    if (value.length < 8) {
                      return 'Password should have at least 8 characters';
                      }
                    },
              ),
              SizedBox(
                height: 50.0,
              ),
              CustomRaisedButton(
                onPressed: () async {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  else{
                    try {
                      emailUserCredential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                          email: email.text,
                          password: passward.text);
                      addUser(email.text,'image',fullName.text);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use')  {
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
                      navigate();
                    } else {
                      print('hello');
                    }

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
      ),
    );
  }

  addUser(email,image,userName){
    User user = FirebaseAuth.instance.currentUser;
    CollectionReference userRef= FirebaseFirestore.instance.collection('users');
    return userRef
        .doc(user.uid).set({
      'email': email, // John Doe
      'image': image, // Stokes and Sons
      'userName': userName,
      'type': 'personal',
      'specialization':'',
      'location':'',
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));

  }
  navigate(){
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LogInScreen()));
  }
  alert(message){
    AwesomeDialog(
        context: context,
        title: "Error",
        body: Text(message))
      ..show();
  }
}
