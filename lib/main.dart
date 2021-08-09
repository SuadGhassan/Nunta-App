import 'package:flutter/material.dart';
import 'constants.dart';
import 'screens/wlcome_screens/welcome/welcome_screen.dart';
import 'package:nunta_app/service_locator.dart';

void main() async {
  //this for hide the buttonbar for the device itself and still show the stauts bar where show the time and signal
  // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //this for hide the buttonbar for the device itself and still show the stauts bar where show the time and signal

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor:
              kPrimaryColor, //this the color of appBar and other tab bars
          buttonColor: kButtonColor, //this the color of all buttons
          appBarTheme: AppBarTheme(color: kPrimaryLightColor),
          iconTheme: IconThemeData(color: kPrimaryColor),
          scaffoldBackgroundColor: Color(0xFFF3F4F6),
          textTheme: TextTheme(
            headline6: TextStyle(
                color: kWordColor,
                fontFamily: 'KiwiMaru',
                fontSize: 15,
                fontWeight: FontWeight.w500),
            headline1: TextStyle(
                color: kTitleColor, fontSize: 25.0, fontFamily: "KiwiMaru"),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          bottomSheetTheme:
              BottomSheetThemeData(backgroundColor: Colors.transparent)),
      home: WelcomeScreen(),
    );
  }
}
