import 'package:flutter/material.dart';
import 'package:nunta_app/Admin_Screens/categories_manage.dart';
import 'package:nunta_app/Admin_Screens/components/admin_navigation_bar.dart';
import 'package:nunta_app/components/button.dart';
import 'package:nunta_app/components/rounded_input_field.dart';
import 'package:nunta_app/components/snackBar_message.dart';
import 'package:nunta_app/constants.dart';

import 'package:nunta_app/models/user_account_model.dart';
import 'package:nunta_app/service_locator.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class AddNewCategory extends StatefulWidget {
  const AddNewCategory({Key key}) : super(key: key);

  @override
  _AddNewCategoryState createState() => _AddNewCategoryState();
}

class _AddNewCategoryState extends State<AddNewCategory> {
  final categoriesName = TextEditingController();
  String image;
  final userToken = getIt<UserAccountModel>().userToken;

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

  final String endPoint =
      'http://myscolla.com/nunta/public/api/admin/category/add';

  ///////////////
  // here will send the data to server
  Future<void> addCategory() async {
    // vaildate inputs
    if (categoriesName.text == null || categoriesName.text == '') {
      return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red[900],content: SnackBarText("All fields are required")));
    }
    String fileName = _pickedImage.path.split('/').last;
    print(fileName);
    // connect to the server using Api
    Map<String, dynamic> apiParams = {
      "app_token": "ljoCh1iSESNKVJF37t6KOU1mNegyB8L3WwrKlHjAgZI",
      "api_token": userToken,
      "name": categoriesName.text,
    };

    FormData data = FormData.fromMap({
      "img": await MultipartFile.fromFile(
        _pickedImage.path,
        filename: fileName,
      ),
    });
    print("img will go brrrrrrrr");
    Dio dio = new Dio();
    // dio.options.headers['content-Type'] = 'multipart/form-data';
    Response responses =
        await dio.post(endPoint, data: data, queryParameters: apiParams);
    print(responses.data);
    var response = responses.data;

    if (response != null && response['status'] == "success") {
      toCategoriesAgain();

      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red[900],
          content: SnackBarText("Category has been added Successfully")));
    } else {
      String errMessage =
          'Please check your internet connection and try again later';
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
  ///////////////

  void toCategoriesAgain() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CategoriesManage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        bottomNavigationBar: AdminNavBar(),
        body: Stack(
          children: [
            Container(
              height: height * 0.3,
              decoration: BoxDecoration(
                color: Color(0xFFEBA7AA),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 90),
                  child: Card(
                    color: kPrimaryLightColor,
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              "Add New Category",
                              style: TextStyle(color: kTitleColor, fontSize: 30,fontFamily: 'KiwiMaru'),
                            ),
                          ),
                          // SizedBox(
                          //   height: 40,
                          // ),
                          RoundedInputField(
                            controllers: categoriesName,
                            hintText: "Category Name",
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 70,
                                  backgroundColor: Color(0xFFF3F4F6),
                                  backgroundImage: _pickedImage != null
                                      ? FileImage(_pickedImage)
                                      : null,
                                  // child: _pickedImage !=null? Image.file(_pickedImage):null,
                                ),
                                Positioned(
                                    top: 105,
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
                                        )))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Button(
                            text: "add",
                            press: () {
                              addCategory();
                            },
                            color: kButtonColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
