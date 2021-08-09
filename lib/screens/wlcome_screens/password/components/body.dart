import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nunta_app/components/button.dart';
import 'package:nunta_app/components/rounded_input_field.dart';
import 'package:nunta_app/constants.dart';

import 'package:nunta_app/Provider_Screens/provider_home_page.dart';
import 'package:nunta_app/Admin_Screens/admin_home_page.dart';
import 'package:nunta_app/screens/wlcome_screens/home_page/home_screen.dart';

import 'package:nunta_app/models/user_account_model.dart';
import 'package:nunta_app/APIProvider.dart';
import 'package:nunta_app/service_locator.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final codeController1 = TextEditingController();
  final codeController2 = TextEditingController();
  final codeController3 = TextEditingController();
  final codeController4 = TextEditingController();
  String newApiToken;
  String codeFromServer;

  ///////////////
  // here will send the email to server to send email withg secret code
  Future<void> emailResetPassword() async {
    print('im working');
    final response = await APIProvider().get(url: "appusers/code", params: {
      "email": emailController.text,
    });
    // here if the respons is success
    if (response != null && response['status'] == "success") {
      newApiToken = response['result']['api_token'];
      codeFromServer = response['result']['secret_code'];
      _showModal();
    } else {
      //this errMessage withe default message
      String errMessage = 'Something Went wrong please Try again later';
      // if for example if user enter email which is already exist in the server and ask user to enter another email
      if (response != null && response['status'] == "error") {
        errMessage = "${response['message']}";
      }

      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red[900],
          content: Text(errMessage,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Tajawal',
              ),
              textAlign: TextAlign.center)));
    }
  }
  ///////////////

  
  // here will send the code to server to check if it's correct
  Future<void> checkCode() async {
    print('CheckCode');
    String finalServer = codeController1.text +
        codeController2.text +
        codeController3.text +
        codeController4.text;
    final response = await APIProvider().get(url: "appusers/check", params: {
      "api_token": newApiToken,
      "secret_code": finalServer,
    });
    // here if
    if (response != null && response['status'] == "success") {
      return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              // title: Text('Successfully Reset'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.center,
                        child: RoundedInputField(
                          controllers: passwordController,
                          hintText: "New Password",
                          icon: Icon(
                            Icons.lock,
                          ),
                          onChanged: (value) {},
                        )),
                  ],
                ),
              ),
              actions: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: kPrimaryColor,
                  ),
                  width: 100,
                  height: 50,
                  child: TextButton(
                    child: Text('Reset',
                        style:
                            TextStyle(fontSize: 20, color: kPrimaryLightColor)),
                    onPressed: () {
                      setState(() {
                        changepassword();
                      });
                    },
                  ),
                ),
              ],
            );
          });
    } else {
      //this errMessage withe default message
      String errMessage = 'Something went wrong please Try again later!';
      // if for example if user enter email which is already exist in the server and ask user to enter another email
      if (response != null && response['status'] == "error") {
        errMessage = "${response['message']}";
      }

      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red[900],
          content: Text(errMessage,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Tajawal',
              ),
              textAlign: TextAlign.center)));
    }
  }
  ///////////////

  ///////////////
  // here will send the new password to server
  Future<void> changepassword() async {
    print('changepassword');
    final response =
        await APIProvider().get(url: "appusers/changepassword", params: {
      "api_token": newApiToken,
      "password": passwordController.text,
    });
    // here if
    if (response != null && response['status'] == "success") {
      await getIt<UserAccountModel>().fetchUserLogin(
        token: response['result']['api_token'],
        name: response['result']['name'],
        email: response['result']['email'],
        type: response['result']['type'],
        photo: response['result']['image'],
        phone: response['result']['number'],
        address: response['result']['address'],
      );
      print(response['result']);

      // print("User Token : ${getIt<UserAccountModel>().userToken}");
      print("User Token : ${response['result']['api_token']}");
      print("Type : ${response['result']['type']}");
      if (response['result']['type'] == '1') {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      } else if (response['result']['type'] == '2') {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AdminHomeScreen();
        }));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProviderHomeScreen();
        }));
      }
    } else {
      //this errMessage withe default message
      String errMessage = 'Somthing Went wrong please Try again later';
      // if for example if user enter email which is already exist in the server and ask user to enter another email
      if (response != null && response['status'] == "error") {
        errMessage = "${response['message']}";
      }

      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red[900],
          content: Text(errMessage,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Tajawal',
              ),
              textAlign: TextAlign.center)));
    }
  }
  ///////////////

  ////////////////////////
  void _showModal() {
    Future<void> future = showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        elevation: 5,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: 20,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: kPrimaryLightColor),
              width: double.infinity,
              height: 350,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Enter the code that sent to your email",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: kWordColor,
                          fontSize: 20,
                          fontFamily: "KiwiMaru"
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RoundedInputNemberContainer(
                              controllers: codeController1),
                          RoundedInputNemberContainer(
                              controllers: codeController2),
                          RoundedInputNemberContainer(
                              controllers: codeController3),
                          RoundedInputNemberContainer(
                              controllers: codeController4),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Button(
                      color: kButtonColor,
                      text: "Continue",
                      press: () {
                        setState(() {
                          checkCode();
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
  ////////////////////////

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          height: height * 0.2,
          decoration: BoxDecoration(
            color: Color(0xFFEBA7AA),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
          child: Container(
            decoration: BoxDecoration(
              color: kPrimaryLightColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: kWordColor,
                  offset: Offset(0, 8),
                  blurRadius: 30,
                  spreadRadius: -23,
                ),
              ],
            ),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: height * 0.5,
            width: 400,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Forgot Password",
                        style: Theme.of(context).textTheme.headline1),
                    SizedBox(height: 20.0),
                    Text(
                      "Please enter your email and we will send you a link to get access to your account",
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.0),
                    RoundedInputField(
                      controllers: emailController,
                      hintText: "Email Address",
                      icon: Icon(
                        Icons.email,
                      ),
                      onChanged: (value) {},
                    ),
                    SizedBox(height: 40),
                    Button(
                      color: kButtonColor,
                      text: "Continue",
                      press: () {
                        setState(() {
                          emailResetPassword();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RoundedInputNemberContainer extends StatelessWidget {
  const RoundedInputNemberContainer({
    Key key,
    this.controllers,
  }) : super(key: key);
  final TextEditingController controllers;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      child: TextField(
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 17,
        ),
        // keyboardType: TextInputType.number,
        controller: controllers,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
