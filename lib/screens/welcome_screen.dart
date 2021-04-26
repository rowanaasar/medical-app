import 'package:flutter/material.dart';
import 'package:medhouse_project/screens/login_screen.dart';
import 'package:medhouse_project/screens//signup_choose_account.dart';
import 'package:medhouse_project/widget/button.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildContent(context),
      backgroundColor: Color(0xFF0FB8B3),
    );
  }

  Widget buildContent(context) {
    return Padding(
      padding: EdgeInsets.all(60.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image(image: AssetImage('assets/images/logo.png')),
          Text(
            'MedHouse',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'Save Time And Health',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          SizedBox(
            height: 40.0,
          ),
          CustomRaisedButton(
            child: Text(
                'SIGN UP',
                style: TextStyle(color: Color(0xFF0FB8B3),fontSize: 15)
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen()));
            },
          ),
          SizedBox(
            height: 15.0,
          ),
          CustomRaisedButton(
            child: Text(
              'LOG IN',
              style: TextStyle(color: Color(0xFF0FB8B3),fontSize:15),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => LogInScreen()));
            },
          )
        ],
      ),
    );
  }
}
