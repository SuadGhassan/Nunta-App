import 'package:flutter/material.dart';
import 'package:nunta_app/constants.dart';


class ChangePassword extends StatelessWidget {
  final bool change;
  final Function press;
  const ChangePassword({
    Key key,
    this.change=false, this.press,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child:GestureDetector(
          onTap: press,
          child: Text(
            change ? "Didn't forget your password" : "Forgot your Password?",
            style: TextStyle(fontSize: 16.5,color: kWordColor,fontFamily: "KiwiMaru"),
          ),
        )
      
    );
  }
}