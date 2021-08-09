import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nunta_app/Provider_Screens/components/provider_navigator_bar.dart';
import 'package:nunta_app/components/button.dart';
import 'package:nunta_app/components/rounded_input_field.dart';
import 'package:nunta_app/components/snackBar_message.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/models/user_account_model.dart';
import 'package:nunta_app/service_locator.dart';

class ProviderAccount extends StatefulWidget {
  const ProviderAccount({Key key}) : super(key: key);

  @override
  _ProviderAccountState createState() => _ProviderAccountState();
}

class _ProviderAccountState extends State<ProviderAccount> {
   final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final userToken = getIt<UserAccountModel>().userToken;
  final type = getIt<UserAccountModel>().userType;
  String image = getIt<UserAccountModel>().userPhoto;

  final String endPoint = 'http://myscolla.com/nunta/public/api/appusers/edit';

  ///////////////
  // here will send the data to server
  Future<void> editAccountInfo() async {
    // vaildate inputs
    if (emailController.text == null ||
        emailController.text == '' ||
        phoneController.text == null ||
        phoneController.text == '' ||
        nameController.text == null ||
        nameController.text == '') {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red,
          content: SnackBarText("Name, Email and Phone fields are required")));
    }
    String fileName = _pickedImage.path.split('/').last;
    print(fileName);
    // connect to the server using Api
    Map<String, dynamic> apiParams = {
      "app_token": "ljoCh1iSESNKVJF37t6KOU1mNegyB8L3WwrKlHjAgZI",
      "api_token": userToken,
      "name": nameController.text,
      "number": phoneController.text,
      "email": emailController.text,
      "address": addressController.text,
    };

    FormData data = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        _pickedImage.path,
        filename: fileName,
      ),
    });
    print("image will go brrrrrrrr");
    Dio dio = new Dio();
    // dio.options.headers['content-Type'] = 'multipart/form-data';
    Response responses =
        await dio.post(endPoint, data: data, queryParameters: apiParams);
    print(responses.data);
    var response = responses.data;

    // update the data in local storage in user device

    if (response != null && response['status'] == "success") {
      await getIt<UserAccountModel>().fetchUserLogin(
        token: response['result']['api_token'],
        name: response['result']['name'],
        email: response['result']['email'],
        type: type,
        photo: response['result']['image'],
        phone: response['result']['number'],
        address: response['result']['address'],
      );

      // update user info in edit page
      nameController.text = getIt<UserAccountModel>().userName;
      phoneController.text = getIt<UserAccountModel>().userPhone;
      emailController.text = getIt<UserAccountModel>().userEmail;
      addressController.text = getIt<UserAccountModel>().userAddress;
      image = getIt<UserAccountModel>().userPhoto;

      // print("User Token : ${getIt<UserAccountModel>().userToken}");
      print("User Token : ${response['result']['api_token']}");
      print("Type : ${response['result']['type']}");

      // meesage wwill appeare when tha data is edited succssfully
      return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red,content: SnackBarText("Account info has been updated")));
    } else {
      //this errMessage with default message
      String errMessage = 'Please check your data and try again';
      // if for example if user enter email which is already exist in the server and ask user to enter another email
      if (response != null && response['status'] == "error") {
        errMessage = "${response['message']}";
      }

      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red,
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

  // get the user info from local storage in his device
  @override
  void initState() {
    super.initState();
    nameController.text = getIt<UserAccountModel>().userName;
    phoneController.text = getIt<UserAccountModel>().userPhone;
    emailController.text = getIt<UserAccountModel>().userEmail;
    addressController.text = getIt<UserAccountModel>().userAddress;
    print(getIt<UserAccountModel>().userAddress);
  }

  ///////////////

  File _pickedImage;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedImageFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      //here make casting for pickedImageFile because they have different data type
      _pickedImage = File(pickedImageFile.path);
    });
  }
  /////////////////

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFF3F4F6).withOpacity(0.9),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kPrimaryLightColor,
        ),
        backgroundColor: Color(0xFFEBA7AA),
        elevation: 0,
        title: Align(
          alignment: Alignment.topRight,
          child: Text(
            "My Profile!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontFamily: 'KiwiMaru',
            ),
          ),
        ),
      ),
      bottomNavigationBar: ProviderNavBar(),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  color: Color(0xFFEBA7AA)),
              height: height * 0.12,
            ),
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topCenter,
                        child: Stack(children: [CircleAvatar(
                            radius: 80,
                            backgroundImage:_pickedImage != null
                                ? FileImage(_pickedImage)
                                : NetworkImage(image), ),
                                Positioned(
                              top: 120,
                              left: 15,
                              child: TextButton.icon(
                                  onPressed: getImage,
                                  autofocus: true,
                                  icon: Icon(
                                    Icons.camera_alt_rounded,
                                    color: kWordColor,
                                  ),
                                  label: Text(
                                    "Take photo",
                                    style: TextStyle(color: kWordColor),
                                  )))],),),
                    SizedBox(
                      child: Divider(
                        thickness: 2.5,
                        color: kPrimaryColor,
                      ),
                      height: 20,
                      width: 130,
                    ),
                    RoundedInputField(
                      controllers: nameController,
                      hintText: "Full Name",
                      icon: Icon(
                        Icons.person,
                      ),
                      onChanged: (value) {},
                    ),
                    RoundedInputField(
                      controllers: phoneController,
                      hintText: "Phone Number",
                      icon: Icon(
                        Icons.phone,
                      ),
                      onChanged: (value) {},
                    ),
                    RoundedInputField(
                      controllers: emailController,
                      hintText: "Email Address",
                      icon: Icon(
                        Icons.email,
                      ),
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Button(
                      press: () =>editAccountInfo(),
                      color: kButtonColor,
                      text: "Update",
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

