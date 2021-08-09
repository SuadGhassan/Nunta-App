import 'package:flutter/material.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/screens/wlcome_screens/home_page/home_screen.dart';

class SuccessfullyPay extends StatelessWidget {
  const SuccessfullyPay({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F4F6).withOpacity(0.9),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 210),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    "assets/icons/noun_Check_1763802.png",
                    width: 350,
                    height: 200,
                    color: kTitleColor.withOpacity(0.6),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Payment Process is \n done successfully",
                    style: TextStyle(
                        fontSize: 21,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,fontFamily: "KiwiMaru"),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return HomeScreen();
                        }));
                      },
                      child: Text(
                        "Continue Shopping",
                        style: TextStyle(color: kTitleColor, fontSize: 16,letterSpacing: 1,decoration: TextDecoration.underline,fontFamily: "KiwiMaru"),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
