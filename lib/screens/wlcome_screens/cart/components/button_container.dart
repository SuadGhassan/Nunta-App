import 'package:flutter/material.dart';

class ButtonContainer extends StatelessWidget {
  final String text;
  final Function press;
  final Color color;
  const ButtonContainer({this.text, this.press, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      height: 45,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(13), color: color),
      child: TextButton(
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 18,
              fontWeight: FontWeight.w400,fontFamily: "KiwiMaru"),
        ),
      ),
    );
  }
}
