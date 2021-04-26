import 'package:flutter/material.dart';

class ConsultationScreen extends StatefulWidget {
  @override
  _InsuranceScreenState createState() => _InsuranceScreenState();
}

class _InsuranceScreenState extends State<ConsultationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Center(
      child: Text('Welcome in Consultation screen'),
      ),
    );
  }
}