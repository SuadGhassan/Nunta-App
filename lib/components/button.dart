import 'package:flutter/material.dart';
import 'package:nunta_app/constants.dart';
class Button extends StatelessWidget {
  final String text;
  final Function press;
  final Color color;
  const Button({
    Key key, this.text, this.press, this.color,
  }) ;

  @override
  Widget build(BuildContext context) {
    
    return Container(
      alignment: Alignment.center,
      width: 92,
      height: 40,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0)),
      child: TextButton(
        onPressed:press,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13.5,color: kPrimaryLightColor ,fontWeight: FontWeight.bold,fontFamily:"KiwiMaru"),
        ),
      ),
    );
  }
}