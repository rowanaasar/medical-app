import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medhouse_project/screens/login_screen.dart';
import 'package:medhouse_project/widget/button.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


class BusinessAccount extends StatefulWidget {
  BusinessAccount({Key key}) : super(key: key);
  @override
  _BusinessAccountState createState() => _BusinessAccountState();
}

class _BusinessAccountState extends State<BusinessAccount> {
  Position currentPosition;
  String currentAddress;
  getCurrentLocation() {
    Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).then((Position position) {
      setState(() {
        currentPosition = position;
        getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }
  getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      Placemark place = placemarks[0];
      setState(() {
        currentAddress =
        "${place.street}, ${place.administrativeArea}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
  UserCredential emailUserCredential, googleUserCred;
  TextEditingController fullName = new TextEditingController();
  TextEditingController passward = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController location = new TextEditingController();
  TextEditingController specialist = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0FB8B3),
        elevation: 0,
      ),
      body: buildContent(context),
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
                  'MedHouse helps you to show your pharmaceutical  products online.',
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
                height: 10.0,
              ),
              TextFormField(
                obscureText: false,
                controller: fullName,
                autofillHints: [AutofillHints.name],
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'John Doe',
                ),
                  //ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      alert('This field is required');
                      return 'This field is required';
                    }
                    if (value.length > 20){
                      alert('This field can not be more than 20');
                      return 'This field can not be more than 20';
                    }
                }
              ),
              SizedBox(
                height: 20.0,
              ),

              Text(
                'Email',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 10.0,
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
                    alert('This field is required');
                    return 'This field is required';
                  }
                  if (!value.contains('@')) {
                    alert('Not valid email ');
                    return "Not valid email ";
                  }
                  if (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                  ).hasMatch(value)) {
                    alert('Please enter a valid email');
                    return "Please enter a valid email";
                  }
                },
              ),
              SizedBox(
                height: 10.0,
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
                    alert('This field is required');
                    return 'This field is required';
                  }
                  if (value.length < 8) {
                    alert('Password should have atleast 8 characters');
                    return 'Password should have atleast 8 characters';
                  }
                },
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                'Personal Information',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              SizedBox(
                height: 40.0,
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Location',
                      style: TextStyle(color: Colors.white,fontSize: 15),
                    ),
                    Icon(
                      Icons.location_on,
                      size: 46,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (currentAddress != null) Text(currentAddress,
                        style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    FlatButton(
                      onPressed: () {
                        getCurrentLocation();
                      },
                      child: Text(
                        'Get Current Location',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),

              Text(
                'Specialist',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                obscureText: false,
                controller: specialist,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Dentist',
                ),
              ),
              SizedBox(
                height: 40.0,
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
                      addUser(email.text,'image',fullName.text,currentAddress,specialist.text);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        alert('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use')  {
                        alert('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                    print(emailUserCredential.user);
                    User user = FirebaseAuth.instance.currentUser;
                    if (!user.emailVerified) {
                      await user.sendEmailVerification();
                      alert('verify your mail, please!');
                      navigate();
                    } else {
                      print('hello');

                    }
                  }
                },

                child: Text(
                  'CONTINUE',
                  style: TextStyle(color: Color(0xFF0FB8B3), fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  addUser(email,image,userName,location,specialist){
    User user = FirebaseAuth.instance.currentUser;
    CollectionReference userRef= FirebaseFirestore.instance.collection('users');
    return userRef
        .doc(user.uid).set({
      'email': email, // John Doe
      'image': image, // Stokes and Sons
      'userName': userName,
      'type': 'business',
      'specialization':specialist,
      'location':location,
      'longitude':currentPosition.longitude,
      'latitude': currentPosition.latitude,
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
