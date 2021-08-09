import 'package:flutter/material.dart';
import 'package:nunta_app/Admin_Screens/add_new_area.dart';
import 'package:nunta_app/Admin_Screens/components/admin_navigation_bar.dart';
import 'package:nunta_app/Admin_Screens/components/area_container.dart';
import 'package:nunta_app/ApiProvider.dart';

import 'package:nunta_app/components/snackBar_message.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/models/user_account_model.dart';
import 'package:nunta_app/service_locator.dart';

class AreasManage extends StatefulWidget {
  const AreasManage({Key key, this.cityId, this.name, this.id})
      : super(key: key);
  final String cityId;
  final String name;
  final String id;
  @override
  _AreasManageState createState() => _AreasManageState(cityId, name, id);
}

class _AreasManageState extends State<AreasManage> {
  List data = [];
  String cityId;
  String name;
  String id;
  final userToken = getIt<UserAccountModel>().userToken;
  _AreasManageState(this.cityId, this.name, this.id);
  Future<dynamic> fetchAreas() async {
    data = [];
    final response = await APIProvider().get(
        url: "admin/area/show",
        params: {"city_id": cityId, "api_token": userToken});
    if (response != null && response["status"] == "success") {
      print(response);
      for (var i = 0; i < response['result'].length; i++) {
        String idToString = response['result'][i]['id'].toString();
        String cityIdToString = response['result'][i]['city_id'].toString();
        var onThing = AreaContainer(
          id: idToString,
          name: response['result'][i]["name"],
          cityIds: cityIdToString,
          deletePress: () => deleteArea(idToString),
        );
        data.add(onThing);
      }
      print('data has come successfully');
    } else {
      print('no there is an aerror');
    }
    setState(() {});
  }

  // delete area

  Future<dynamic> deleteArea(String id) async {
    final response = await APIProvider().get(
        url: "admin/area/remove", params: {"api_token": userToken, "id": id});
    print(response);
    if (response != null && response["status"] == "success") {
      fetchAreas();
      print('Area deleted successfully');
    } else {
      print('No, there is an error');
      print(response);
      String errMessage = 'there is an error please, try again later!';
      if (response != null && response['status'] == "error") {
        errMessage = "${response['message']}";
      }
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red[900], content: SnackBarText(errMessage)));
    }
  }

  @override
  void initState() {
    fetchAreas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFF3F4F6).withOpacity(0.9),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40, vertical: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: kButtonColor,
            ),
            width: 275,
            height: 50,
            child: TextButton(
              clipBehavior: Clip.none,
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AddNewArea(
                  cityId: cityId,
                );
              })),
              child: Text(
                "Add New Area",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.5,
                  fontFamily: 'KiwiMaru',
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          AdminNavBar(),
        ],
      ),
      appBar: buildAppBar(),
      body: Stack(
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
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: data
                        .map((areaData) => AreaContainer(
                              cityIds: areaData.cityIds,
                              id: areaData.id,
                              name: areaData.name,
                              deletePress: areaData.deletePress,
                            ))
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    iconTheme: IconThemeData(
      color: kPrimaryLightColor,
    ),
    backgroundColor: Color(0xFFEBA7AA),
    elevation: 0,
    title: Align(
      alignment: Alignment.topRight,
      child: Text(
        "Areas Manage",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    ),
  );
}
