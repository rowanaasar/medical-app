import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final Color color;
  final double borderRadius;
  final Widget child;
  final VoidCallback onPressed;
  final double height;

  const CustomRaisedButton(
      {this.color, this.borderRadius: 2.0, this.onPressed, this.child, this.height:50.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      // ignore: deprecated_member_use
      child: RaisedButton(
          child: child,
          color: color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          )),
          onPressed: onPressed),
    );
  }
}
