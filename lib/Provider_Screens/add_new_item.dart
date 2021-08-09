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

class AddNewItem extends StatefulWidget {
  const AddNewItem();

  @override
  _AddNewItemState createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  final userToken = getIt<UserAccountModel>().userToken;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();
  final addressController = TextEditingController();
  final mapController = TextEditingController();
  String image;
  String type = "1";

  String typeValue = "Item";
  List<String> typeList = ["Item", "Offer"];

  String selectedCity = "Riyadh";
  List<String> newCities = [];

  String selectedArea = "royal st";
  List<String> newAreas = ["royal st"];

  String selectedCategory = "Bouquet";
  List<String> newCategories = [];

  File _pickedImage;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedImageFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      //here make casting for pickedImageFile because they have different data type
      _pickedImage = File(pickedImageFile.path);
    });
  }

  final String endPoint =
      'http://myscolla.com/nunta/public/api/provider/items/add';

  // here will send the data to server
  
  Future<void> addItem() async {
    // vaildate inputs
    if (nameController.text == null ||
        nameController.text == '' ||
        priceController.text == null ||
        priceController.text == '' ||
        phoneController.text == null ||
        phoneController.text == '' ||
        descController.text == null ||
        descController.text == '' ||
        addressController.text == null ||
        addressController.text == '') {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              SnackBarText("item Name, price, desc and address are required")));
    }

    if (typeValue == "Item") {
      type = "1";
    } else {
      type = "2";
    }
    // connect to the server using Api
    Map<String, dynamic> apiParams = {
      "app_token": "ljoCh1iSESNKVJF37t6KOU1mNegyB8L3WwrKlHjAgZI",
      "api_token": userToken,
      "name": nameController.text,
      "phone": phoneController.text,
      "price": priceController.text,
      "desc": descController.text,
      "address": addressController.text,
      "city_id": selectedCity,
      "areas_id": selectedArea,
      "categories_id": selectedCategory,
      "type": type,
    };
    
    Response responses;
    // validate the image
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
            content: SnackBarText("Item has been added Successfully")));
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: SnackBarText("Offer has been added Successfully")));
      }
    } else {
      String errMessage =
          'Please check your internet connection and try again later';
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
  //go back to items page 

  void toItemsAgain(String type) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      if (type == "1") {
        return ItemsManage();
      } else {
        return OffersManage();
      }
    }));
  }
  //This method for fetch cities from the mySql Server.
  List<String> cities = ["Jeddah", "Riyadh", "Taif", "Hail"];
  Future<dynamic> fetchCity() async {
    newCities = [];
    var response = await APIProvider().get(url: "extras/cities", params: {});
    if (response != null && response['status'] == "success") {
      print(response);
      for (int i = 0; i < response['result'].length; i++) {
        String myCity = response['result'][i]["name"];
        newCities.add(myCity);
      }
      print('cities has come successfully');
    } else {
      print('no there is an aerror');
    }
    setState(() {});
  }

  // get cities as a dropdownMenuItem from fetchCity() method.
  List<DropdownMenuItem> getCities() {
    List<DropdownMenuItem<String>> dropdownCities = [];
    print(newCities);
    for (int i = 0; i < newCities.length; i++) {
      String city = newCities[i];
      print(city);
      var newCity = DropdownMenuItem(
        child: Text(city),
        value: city,
      );
      dropdownCities.add(newCity);
    }
    return dropdownCities;
  }

  // This method for sho the city which selected in the dropDownButton.
  void showCity(String name) {
    print(name);
    setState(() {
      selectedCity = name;
      fetchArea();
    });
  }

  //This method for fetch cities from the mySql Server.
  List<String> areas = ["Jeddah", "Riyadh", "Taif", "Hail"];
  Future<dynamic> fetchArea() async {
    newAreas = [];
    var response =
        await APIProvider().get(url: "extras/areas_for_city", params: {
      "city": selectedCity,
    });
    if (response != null && response['status'] == "success") {
      print(response);
      for (int i = 0; i < response['result'].length; i++) {
        if (i == 0) {
          selectedArea = response['result'][i]["name"];
        }
        String myArea = response['result'][i]["name"];
        newAreas.add(myArea);
      }
      print('areas has come successfully');
    } else {
      print('no there is an aerror');
      String errMessage =
          'Please check your internet connection and try again later';
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
    setState(() {});
  }

  // get cities as a dropdownMenuItem from fetchCity() method.
  List<DropdownMenuItem> getAreas() {
    List<DropdownMenuItem<String>> dropdownAreas = [];
    print(newAreas);
    for (int i = 0; i < newAreas.length; i++) {
      String area = newAreas[i];
      print(area);
      var newArea = DropdownMenuItem(
        child: Text(area),
        value: area,
      );
      dropdownAreas.add(newArea);
    }
    return dropdownAreas;
  }

  // This method for sho the city which selected in the dropDownButton.
  void showArea(String name) {
    print(name);
    setState(() {
      selectedArea = name;
    });
  }
  
  //This method for fetch cities from the mySql Server.
  List<String> categories = ["Jeddah", "Riyadh", "Taif", "Hail"];
  Future<dynamic> fetchCategory() async {
    newCategories = [];
    var response =
        await APIProvider().get(url: "extras/categories", params: {});
    if (response != null && response['status'] == "success") {
      print(response);
      for (int i = 0; i < response['result'].length; i++) {
        String myCity = response['result'][i]["name"];
        newCategories.add(myCity);
      }
      print('Categories has come successfully');
    } else {
      print('no there is an aerror');
    }
    setState(() {});
  }

  // get cities as a dropdownMenuItem from fetchCity() method.
  List<DropdownMenuItem> getCategories() {
    List<DropdownMenuItem<String>> dropdownCategories = [];
    print(newCategories);
    for (int i = 0; i < newCategories.length; i++) {
      String category = newCategories[i];
      print(category);
      var newCategory = DropdownMenuItem(
        child: Text(category),
        value: category,
      );
      dropdownCategories.add(newCategory);
    }
    return dropdownCategories;
  }

  // This method for sho the city which selected in the dropDownButton.
  void showCategory(String name) {
    print(name);
    setState(() {
      selectedCategory = name;
    });
  }

  // get cities as a dropdownMenuItem from fetchCity() method.
  List<DropdownMenuItem> getType() {
    List<DropdownMenuItem<String>> dropdownType = [];
    print(typeList);
    for (int i = 0; i < typeList.length; i++) {
      String myType = typeList[i];
      print(myType);
      var newType = DropdownMenuItem(
        child: Text(myType),
        value: myType,
      );
      dropdownType.add(newType);
    }
    return dropdownType;
  }

  // This method for sho the city which selected in the dropDownButton.
  void showType(String name) {
    print(name);
    setState(() {
      typeValue = name;
    });
  }

  @override
  void initState() {
    fetchCity();
    fetchArea();
    fetchCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String _dropDownValue;
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
                              "Add New Item",
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
                                          "Choose photo",
                                          style: TextStyle(color: kWordColor),
                                        )))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                DropdownButton<String>(
                                  value: selectedCity,
                                  items: getCities(),
                                  onChanged: (value) {
                                    showCity(value);
                                  },
                                ),
                                DropdownButton<String>(
                                  value: selectedArea,
                                  items: getAreas(),
                                  onChanged: (value) {
                                    showArea(value);
                                  },
                                ),
                                DropdownButton<String>(
                                  value: selectedCategory,
                                  items: getCategories(),
                                  onChanged: (value) {
                                    showCategory(value);
                                  },
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: 10,
                          // ),
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
                            hintText: "Decription",
                          ),
                          RoundedInputField(
                            controllers: addressController,
                            hintText: "Address",
                          ),
                          DropdownButton<String>(
                            value: typeValue,
                            items: getType(),
                            onChanged: (value) {
                              showType(value);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Button(
                            text: "add",
                            press: () {
                              addItem();
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
