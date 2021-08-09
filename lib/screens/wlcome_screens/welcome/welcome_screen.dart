import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nunta_app/screens/wlcome_screens/login/login_screen.dart';


class WelcomeScreen extends StatefulWidget {
  static const routeName='/welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animationn;
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 6000), () {
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => LoginScreen(),),
      );
    });

    controller = AnimationController(
      duration: Duration(milliseconds: 8000),
      vsync: this,
    );
    animationn = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();
    //  }});
    controller.addListener(() {
      setState(() {});
    });
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
      child: Container(
        child: Image.asset("assets/images/logoNunta.png"),
        width: size.width * 0.8,
        height: animationn.value * 450,
      ),
    ),
    );
  }
}

