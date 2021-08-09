import 'package:flutter/material.dart';
import 'package:nunta_app/constants.dart';


class AlreadyHaveAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don't have an Account?" : "Already Have an Account?",
          style: TextStyle(fontSize: 15.0,fontFamily: "KiwiMaru",color: kWordColor,
        ),),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,fontFamily: "KiwiMaru",color: kTitleColor),
          ),
        )
      ],
    );
  }
}
