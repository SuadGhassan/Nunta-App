import 'package:flutter/material.dart';
import 'package:nunta_app/Admin_Screens/add_new_proniver.dart';
import 'package:nunta_app/Admin_Screens/components/admin_navigation_bar.dart';
import 'package:nunta_app/Admin_Screens/components/provider_content_container.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/enums.dart';

import 'package:nunta_app/components/snackBar_message.dart';

import 'package:nunta_app/models/user_account_model.dart';
import 'package:nunta_app/APIProvider.dart';
import 'package:nunta_app/service_locator.dart';

class ProviderManage extends StatefulWidget {
  const ProviderManage({Key key}) : super(key: key);

  @override
  _ProviderManageState createState() => _ProviderManageState();
}

class _ProviderManageState extends State<ProviderManage> {
  //this list has the same reason to be empty like lists in the home screen
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
  List data = [];
  final userToken = getIt<UserAccountModel>().userToken;
  Future<dynamic> fetchProvider() async {
    data = [];
    var response = await APIProvider().get(url: "admin/provider/show", params: {
      "api_token": userToken,
    });
    if (response != null && response['status'] == "success") {
      print(response);
      for (var i = 0; i < response['result'].length; i++) {
        var idToString = response['result'][i]['id'].toString();
        var oneThing = ProviderContentContainer(
          id: idToString,
          name: response['result'][i]['name'],
          image: response['result'][i]['image'],
          email: response['result'][i]['email'],
          phone: response['result'][i]['number'],
          deletePress: () => deleteProvier(idToString),
        );
        data.add(oneThing);
      }
      print('providers data has come successfully');
    } else {
      print('no there is an aerror');
      String errMessage = 'Please check your data and try again';
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

  Future<dynamic> deleteProvier(String id) async {
    var response =
        await APIProvider().get(url: "admin/provider/remove", params: {
      "api_token": userToken,
      "id": id,
    });
    if (response != null && response['status'] == "success") {
      print(response);
      print('provider has been deleted');
      fetchProvider();
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red[900],
          content: SnackBarText("Provider has been deleted Successfully")));
    } else {
      print(response);
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

    // fetchCategories();
  }

  @override
  void initState() {
    fetchProvider();
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
            margin: EdgeInsets.symmetric(
              horizontal: 40,
            ),
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
                return AddNewProvider();
              })),
              child: Text(
                "Add New Provider",
                style: TextStyle(color: Colors.white, fontSize: 18.5,fontFamily: 'KiwiMaru',),
              ),
            ),
          ),
          SizedBox(height: 5,),
          AdminNavBar(
            selectedMenu: MenuState.provider,
          ),
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
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
              child: Column(
                children: data
                    .map(
                      (itemData) => ProviderContentContainer(
                        id: itemData.id,
                        image: itemData.image,
                        name: itemData.name,
                        email: itemData.email,
                        phone: itemData.phone,
                        deletePress: itemData.deletePress,
                      ),
                    )
                    .toList(),
              ),
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
        "Providers Manage",
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontFamily: 'KiwiMaru',
        ),
      ),
    ),
  );
}
