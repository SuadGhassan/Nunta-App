import 'package:flutter/material.dart';
import 'package:nunta_app/Admin_Screens/components/admin_navigation_bar.dart';
import 'package:nunta_app/components/button.dart';
import 'package:nunta_app/components/rounded_input_field.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/Admin_Screens/provider_manage.dart';

import 'package:nunta_app/components/snackBar_message.dart';

import 'package:nunta_app/models/user_account_model.dart';
import 'package:nunta_app/APIProvider.dart';
import 'package:nunta_app/service_locator.dart';

class AddNewProvider extends StatefulWidget {
  const AddNewProvider({Key key}) : super(key: key);

  @override
  _AddNewProviderState createState() => _AddNewProviderState();
}

class _AddNewProviderState extends State<AddNewProvider> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
  final userToken = getIt<UserAccountModel>().userToken;

  ///////////////
  // here will send the data to server
  Future<void> registerProvider() async {
    // vaildate inputs
    if (emailController.text == null ||
        emailController.text == '' ||
        passwordController.text == null ||
        passwordController.text == '' ||
        nameController.text == null ||
        nameController.text == '' ||
        phoneController.text == null ||
        phoneController.text == '') {
      return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red[900],content: SnackBarText("All fields are required")));
    }
    if (passwordController.text != confirmController.text) {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red[900],
          content:
              SnackBarText("Password and Confirm Password are not matched")));
    }
    final response =
        await APIProvider().get(url: "admin/provider/add", params: {
      "api_token": userToken,
      "name": nameController.text,
      "number": phoneController.text,
      "email": emailController.text,
      "password": passwordController.text
    });
    if (response != null && response['status'] == "success") {
      sendToShowProvidersScreen();
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red[900],
          content: SnackBarText("Provider has been added successfully")));
    } else {
      String errMessage = 'Please check your data and try again';
      if (response != null && response['status'] == "error") {
        errMessage = "${response['message']}";
      }

      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red[900],
          content: Text(errMessage,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Tajawal',
              ),
              textAlign: TextAlign.center)));
    }
  }

  void sendToShowProvidersScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ProviderManage();
    }));
  }
  ///////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AdminNavBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
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
                text: "Add",
                color: kButtonColor,
                press: () {
                  registerProvider();
                },
              ),
              SizedBox(height: 35.0),
            ],
          ),
        ),
      ),
    );
  }
}
