import 'package:flutter/material.dart';
import 'package:medhouse_project/screens/create_person_account.dart';
import 'package:medhouse_project/screens/signup_choose_business.dart';
import 'package:medhouse_project/widget/button.dart';

class SignUpScreen extends StatelessWidget {
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
    return Container(
      padding: EdgeInsets.all(60.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image(image: AssetImage('assets/images/logo.png')),
            Text(
              'Welcome To MedHouse',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),         
            SizedBox(
              height: 40.0,
            ),
            Text(
              'please choose what account you want',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20 , color: Colors.white),
            ),
            SizedBox(
              height: 40.0,
            ),
            CustomRaisedButton(
              child: Text(
                'Personal Account',
                style: TextStyle(color: Color(0xFF0FB8B3),fontSize: 15)
                ),
              onPressed: () {
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => PersonAccount()));
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            CustomRaisedButton(
              child: Text(
                'Business Account',
                style: TextStyle(color: Color(0xFF0FB8B3),fontSize:15),
                ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpBusniessScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
