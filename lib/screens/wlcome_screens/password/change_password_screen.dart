import 'package:flutter/material.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/screens/wlcome_screens/password/components/body.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const routeName = '/ChangePasswordScreen_screen';
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(backgroundColor: Color(0xFFF3F4F6).withOpacity(0.9),
    appBar: AppBar(
      iconTheme: IconThemeData(
        color: kPrimaryLightColor,
        
      ),
      backgroundColor: Color(0xFFEBA7AA),
      elevation: 0,
      title: Align(
        alignment: Alignment.topRight,
        child: Text(
          "Reset Password",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontFamily: "KiwiMaru"
          ),
        ),
      ),
    ),
    body: Body(),
    );
  }
}

