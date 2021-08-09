import 'package:flutter/material.dart';

class SnackBarText extends StatelessWidget {
  final String text;
  const SnackBarText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Tajawal',
        ),
        textAlign: TextAlign.center);
  }
}