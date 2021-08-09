import 'package:flutter/material.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/screens/wlcome_screens/signUp/components/body.dart';


class SignUpScreen extends StatelessWidget {
  static const routeName = '/signUp_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(backgroundColor: kPrimaryLightColor,elevation: 0,iconTheme: IconTheme.of(context),),
      body: Body(),
    );
  }
}

