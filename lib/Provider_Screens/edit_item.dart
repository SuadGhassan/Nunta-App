import 'package:flutter/material.dart';
import 'package:nunta_app/Provider_Screens/components/provider_navigator_bar.dart';
import 'package:nunta_app/Provider_Screens/items_manage.dart';
import 'package:nunta_app/Provider_Screens/offers_manage.dart';
import 'package:nunta_app/components/button.dart';
import 'package:nunta_app/components/rounded_input_field.dart';
import 'package:nunta_app/components/snackBar_message.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/models/user_account_model.dart';
import 'package:nunta_app/APIProvider.dart';
import 'package:nunta_app/service_locator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class EditItem extends StatefulWidget {
  final id;
  const EditItem({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  _EditItemState createState() => _EditItemState(id);
}

class _EditItemState extends State<EditItem> {
  String id;
  final userToken = getIt<UserAccountModel>().userToken;
  _EditItemState(this.id);
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();
  final addressController = TextEditingController();
  final mapController = TextEditingController();
  String image;
  String type = "1";

  Future<void> getItemToEdit() async {
    // connect to the server using Api
    var response =
        await APIProvider().get(url: "provider/items/find_for_edit", params: {
      "api_token": userToken,
      "id": id,
    });

    if (response != null && response['status'] == "success") {
      print(response);
      nameController.text = response['result']['name'];
      phoneController.text = response['result']['phone'];
      priceController.text = response['result']['price'];
      descController.text = response['result']['desc'];
      addressController.text = response['result']['address'];
      mapController.text = response['result']['map'];
      type = response['result']['type'];
      image = response['result']['img'];
      print("item data has come Successfully to start editing");
      setState(() {});
    } else {
      String errMessage =
          'Please check your internet connection and try again later';
      if (response != null && response['status'] == "error") {
        errMessage = "${response['message']}";
      }

      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor:Colors.red[900],
          content: Text(
            errMessage,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Tajawal',
              ),
              textAlign: TextAlign.center)));
    }
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

  final String endPoint =
      'http://myscolla.com/nunta/public/api/provider/items/edit';

  ///////////////
  // here will send the data to server
  Future<void> editItem() async {
    // vaildate inputs
    if (nameController.text == null ||
        nameController.text == '' ||
        phoneController.text == null ||
        phoneController.text == '' ||
        priceController.text == null ||
        priceController.text == '' ||
        descController.text == null ||
        descController.text == '' ||
        addressController.text == null ||
        addressController.text == '') {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              SnackBarText("item Name, price, desc and address are required")));
    }
    // connect to the server using Api
    Map<String, dynamic> apiParams = {
      "app_token": "ljoCh1iSESNKVJF37t6KOU1mNegyB8L3WwrKlHjAgZI",
      "api_token": userToken,
      "id": id,
      "name": nameController.text,
      "price": priceController.text,
      "phone": phoneController.text,
      "desc": descController.text,
      "address": addressController.text,
    };
    Response responses;
    if (_pickedImage != null && _pickedImage.path != "") {
      String fileName = _pickedImage.path.split('/').last;
      print(fileName);
      FormData data = FormData.fromMap({
        "img": await MultipartFile.fromFile(
          _pickedImage.path,
          filename: fileName,
        ),
      });
      Dio dio = new Dio();
      responses =
          await dio.post(endPoint, data: data, queryParameters: apiParams);
    } else {
      Dio dio = new Dio();
      responses = await dio.post(endPoint, queryParameters: apiParams);
    }
    // Dio dio = new Dio();
    print(responses.data);
    var response = responses.data;

    if (response != null && response['status'] == "success") {
      toItemsAgain(type);
      if (type == "1") {
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: SnackBarText("Item has been edited Successfully")));
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: SnackBarText("Offer has been edited Successfully")));
      }
    } else {
      String errMessage =
          'Please check your internet connection and try again later';
      if (response != null && response['status'] == "error") {
        errMessage = "${response['message']}";
      }

      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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

  void toItemsAgain(String type) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      if (type == "1") {
        return ItemsManage();
      } else {
        return OffersManage();
      }
    }));
  }

  @override
  void initState() {
    getItemToEdit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        bottomNavigationBar: ProviderNavBar(),
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
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 10, left: 10, top: 35, bottom: 15),
                child: SingleChildScrollView(
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
                              "Edit Item",
                              style:
                                  TextStyle(color: kTitleColor, fontSize: 30,fontFamily: 'KiwiMaru',),
                            ),
                          ),
                          SizedBox(
                            height: 20,
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
                                      : image != null
                                          ? NetworkImage(image)
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
                            height: 10,
                          ),
                          RoundedInputField(
                            controllers: nameController,
                            hintText: "Name in English",
                          ),
                          RoundedInputField(
                            controllers: phoneController,
                            hintText: "Phone",
                          ),
                          RoundedInputField(
                            controllers: priceController,
                            hintText: "Price",
                          ),
                          RoundedInputField(
                            controllers: descController,
                            hintText: "Description",
                          ),
                          RoundedInputField(
                            controllers: addressController,
                            hintText: "Address",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Button(
                            text: "edit",
                            press: () {
                              editItem();
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
