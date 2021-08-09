import 'package:flutter/material.dart';

import 'package:nunta_app/Provider_Screens/provider_home_page.dart';
import 'package:nunta_app/Admin_Screens/admin_home_page.dart';
import 'package:nunta_app/components/snackBar_message.dart';
import 'package:nunta_app/screens/wlcome_screens/home_page/home_screen.dart';

import 'package:nunta_app/components/already_have_account_check.dart';
import 'package:nunta_app/components/button.dart';
import 'package:nunta_app/components/change_password.dart';
import 'package:nunta_app/components/rounded_input_field.dart';
import 'package:nunta_app/components/rounded_password_field.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/screens/wlcome_screens/password/change_password_screen.dart';
import 'package:nunta_app/screens/wlcome_screens/signUp/sign_up_screen.dart';

import 'package:nunta_app/models/user_account_model.dart';
import 'package:nunta_app/APIProvider.dart';
import 'package:nunta_app/service_locator.dart';



class Body extends StatefulWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  
  Future<void> signInWithEmailAndPassword() async {
    // vaildate inputs
    if (emailController.text == null ||
        emailController.text == '' ||
        passwordController.text == null ||
        passwordController.text == '') {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red[900],
          content: SnackBarText("Email and password fields are required")));
          
    }
    // connect to the server using Api
    final response = await APIProvider().get(url: "appusers/login", params: {
      "email": emailController.text,
      "password": passwordController.text
    });

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
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red[900],
          content: SnackBarText("Email or Password is not correct!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset("assets/images/logoNunta.png"),
              width: size.width * 0.6,
            ),
            SizedBox(height: 5.0),
            Text(
              "Login",
              style: TextStyle(
                  fontSize: 35.0,
                  fontFamily: "KiwiMaru",
                  color: kTitleColor),
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
            RoundedPasswordField(
              controllers: passwordController,
              onChanged: (value) {},
            ),
            SizedBox(height: 5.0),
            ChangePassword(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ChangePasswordScreen();
                  }),
                );
              },
            ),
            SizedBox(height: 10.0),
            Button(
              text: "Login",
              color: kButtonColor,
              press: () {
                setState(() {
                  signInWithEmailAndPassword();
                });
              },
            ),
            SizedBox(height: 35.0),
            AlreadyHaveAccountCheck(press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return SignUpScreen();
                }),
              );
            }),
          ],
        ),
      ),
    );
  }
}


