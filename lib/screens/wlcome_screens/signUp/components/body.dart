import 'package:flutter/material.dart';
import 'package:nunta_app/components/already_have_account_check.dart';
import 'package:nunta_app/components/button.dart';
import 'package:nunta_app/components/rounded_input_field.dart';
import 'package:nunta_app/components/snackBar_message.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/screens/wlcome_screens/home_page/home_screen.dart';
import 'package:nunta_app/screens/wlcome_screens/login/login_screen.dart';

import 'package:nunta_app/models/user_account_model.dart';
import 'package:nunta_app/APIProvider.dart';
import 'package:nunta_app/service_locator.dart';

class Body extends StatefulWidget {
  

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  // final _scaffoldKey = GlobalKey<ScaffoldState>();

  // here will send the data to server
  
  Future<void> register() async {
    // vaildate inputs
    if (emailController.text == null ||
        emailController.text == '' ||
        passwordController.text == null ||
        passwordController.text == '' ||
        nameController.text == null ||
        nameController.text == '' ||
        phoneController.text == null ||
        phoneController.text == '') {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red[900],
          content:SnackBarText("All fields are required")));
    }
    if (passwordController.text != confirmController.text) {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red[900],
          content: SnackBarText("Password and Confirm Password are not matched")));
    }
    // connect to the server using Api
    final response = await APIProvider().get(url: "appusers/register", params: {
      "name": nameController.text,
      "number": phoneController.text,
      "email": emailController.text,
      "password": passwordController.text,
      // "confirm":confirmController.text
    });
    // here will store in cache in user device
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

      // print("User Token : ${getIt<UserAccountModel>().userToken}");
      print("User Token : ${response['result']['api_token']}");
      print("Type : ${response['result']['type']}");
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }));
    } else {
      // Navigator.pop(context);
      //this errMessage withe default message
      String errMessage = 'Please check your data and try again';
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Create New Account!",
              style: TextStyle(
                  color: kTitleColor,
                  fontSize: 40.0,
                  fontFamily: "CormorantGaramond",
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15.0),
            RoundedInputField(
              controllers: nameController,
              hintText: "Full Name",
              icon: Icon(
                Icons.person,
              ),
              onChanged: (value) {},
            ),
            SizedBox(height: 5.0),
            RoundedInputField(
              controllers: phoneController,
              hintText: "Phone Number",
              icon: Icon(
                Icons.phone,
              ),
              onChanged: (value) {},
            ),
            SizedBox(height: 5.0),
            RoundedInputField(
              controllers: emailController,
              hintText: "Email Address",
              icon: Icon(
                Icons.email,
              ),
              onChanged: (value) {},
            ),
            SizedBox(height: 5.0),
            RoundedInputField(
              controllers: passwordController,
              hintText: "Password",
              icon: Icon(
                Icons.lock,
              ),
              onChanged: (value) {},
            ),
            SizedBox(height: 5.0),
            RoundedInputField(
              controllers: confirmController,
              hintText: "Confirm",
              icon: Icon(
                Icons.check,
              ),
              onChanged: (value) {},
            ),
            SizedBox(height: 25.0),
            Button(
              text: "Sign up",
              color: kButtonColor,
              press: () {
                register();
              },
            ),
            SizedBox(height: 35.0),
            AlreadyHaveAccountCheck(
              login: false,
              press: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
