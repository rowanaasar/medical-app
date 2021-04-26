import 'package:flutter/material.dart';
import 'package:medhouse_project/screens/create_business_account.dart';
import 'package:medhouse_project/widget/button.dart';

class SignUpBusniessScreen extends StatelessWidget {
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
              'I AM ..',
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),         
            SizedBox(
              height: 40.0,
            ),
            CustomRaisedButton(
              child: Text(
                'Pharmacist',
                style: TextStyle(color: Color(0xFF0FB8B3),fontSize: 15)
                ),
              onPressed: () {
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => BusinessAccount()));
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            CustomRaisedButton(
              child: Text(
                'Doctor',
                style: TextStyle(color: Color(0xFF0FB8B3),fontSize:15),
                ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => BusinessAccount()));
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            CustomRaisedButton(
              child: Text(
                'Nutrition doctor',
                style: TextStyle(color: Color(0xFF0FB8B3),fontSize:15),
                ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => BusinessAccount()));
              },
            )
          ],
        ),
      ),
    );
  }
}
