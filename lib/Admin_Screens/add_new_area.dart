import 'package:flutter/material.dart';
import 'package:nunta_app/Admin_Screens/areas_manage.dart';
import 'package:nunta_app/Admin_Screens/components/admin_navigation_bar.dart';
import 'package:nunta_app/ApiProvider.dart';
import 'package:nunta_app/components/button.dart';
import 'package:nunta_app/components/rounded_input_field.dart';
import 'package:nunta_app/components/snackBar_message.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/models/user_account_model.dart';
import 'package:nunta_app/service_locator.dart';

class AddNewArea extends StatefulWidget {
  final String cityId;
  const AddNewArea({Key key, this.cityId}) : super(key: key);

  @override
  _AddNewAreaState createState() => _AddNewAreaState(cityId);
}

class _AddNewAreaState extends State<AddNewArea> {
  final String cityId;
  _AddNewAreaState(this.cityId);
  final myController = TextEditingController();
  String name = " ";
  final userToken = getIt<UserAccountModel>().userToken;
  String selectedCity = "Riyadh";
  List<String> newCities = [];

  // this method to add area to a specific city.
  Future<dynamic> addNewArea() async {
    final response = await APIProvider().get(url: "admin/area/add", params: {
      "api_token": userToken,
      "name": myController.text,
      "city_name": selectedCity
    });
    if (response != null && response['status'] == "success") {
      print("city added successfully");
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return AreasManage(
          cityId: cityId,
        );
      }));
    } else {
      print('No there is an error');
      print(response);
      String errMessage = 'There is an error please try again later';
      if (response != null && response['status'] == "error") {
        errMessage = "${response['message']}";
      }
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(backgroundColor: Colors.red[900],content: SnackBarText(errMessage)));
    }
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
      print('data has come successfully');
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

  // This method for show the city which selected in the dropDownButton.
  void showCity(String name) {
    print(name);
    setState(() {
      selectedCity = name;
    });
  }

  @override
  void initState() {
    fetchCity();
    super.initState();
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
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 100),
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
                              "Add New Area",
                              style:
                                  TextStyle(color: kTitleColor, fontSize: 30,fontFamily: 'KiwiMaru'),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 15, right: 15),
                              child: DropdownButton<String>(
                                value: selectedCity,
                                items: getCities(),
                                onChanged: (value) {
                                  showCity(value);
                                },
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          RoundedInputField(
                            hintText: "Name in English",
                            controllers: myController,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Button(
                            text: "add",
                            press: () => addNewArea(),
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
