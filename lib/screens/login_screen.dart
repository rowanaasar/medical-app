import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:medhouse_project/screens/signup_choose_account.dart';
import 'package:medhouse_project/screens/taps_screen.dart';
import 'package:medhouse_project/widget/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({Key key}) : super(key: key);
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  UserCredential userCredential;
  TextEditingController passward = new TextEditingController();
  TextEditingController email = new TextEditingController();
  String getPassward;
  String getEmail;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0FB8B3),
      ),
      body: buildContent(context),
      backgroundColor: Color(0xFF0FB8B3),
    );
  }

  Widget buildContent(context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(60.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'LOG IN',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'WELCOME TO  ',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'MedHouse',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ]),
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                'Email',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                obscureText: false,
                controller: email,
                autofillHints: [AutofillHints.email],
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Phone or Email',
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
                height: 20.0,
              ),
              TextFormField(
                obscureText: true,
                cursorColor: Colors.white,
                controller: passward,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: '**********',
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
                height: 20.0,
              ),
              CustomRaisedButton(
                onPressed: () async {
                      try {
                        userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: email.text,
                            password: passward.text,
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
                        alert('verify your mail, please!');
                      }
                      else{
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Taps()));
                      }
                  },
                child: Text("Sign In",style: TextStyle(color: Color(0xFF0FB8B3), fontSize: 15),),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: 60,
              ),
              TextButton(
              child: const Text('Forget Passward ? Click here ',
              style: TextStyle(color: Colors.red, fontSize: 15),),
              onPressed: () {/* ... */},
              ),
              CustomRaisedButton(
                child: Text(
                  'Create New Account',
                  style: TextStyle(color: Color(0xFF0FB8B3), fontSize: 15),
                ),
                color: Colors.blue[900],
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  alert(message){
    AwesomeDialog(
        context: context,
        title: "Error",
        body: Text(message))
      ..show();
  }
}
