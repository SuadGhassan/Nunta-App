import 'package:flutter/material.dart';
import 'package:nunta_app/Admin_Screens/components/CustomerContentContainer.dart';
import 'package:nunta_app/Admin_Screens/components/admin_navigation_bar.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/enums.dart';
import 'package:nunta_app/models/user_account_model.dart';
import 'package:nunta_app/APIProvider.dart';
import 'package:nunta_app/service_locator.dart';

class CustomerManage extends StatefulWidget {
  const CustomerManage({Key key}) : super(key: key);

  @override
  _CustomerManageState createState() => _CustomerManageState();
}

class _CustomerManageState extends State<CustomerManage> {
  //this list has the same reason to be empty like lists in the home screen
  List data = [];
  final userToken = getIt<UserAccountModel>().userToken;
  
  Future<dynamic> fetchCustomer() async {
    data = [];
    var response = await APIProvider().get(url: "admin/user/show", params: {
      "api_token": userToken,
    });
    if (response != null && response['status'] == "success") {
      print(response);
      for (var i = 0; i < response['result'].length; i++) {
        var idToString = response['result'][i]['id'].toString();
        var oneThing = CustomerContentContainer(
          id: idToString,
          name: response['result'][i]['name'],
          image: response['result'][i]['image'],
          email: response['result'][i]['email'],
          phone: response['result'][i]['number'],
        );
        data.add(oneThing);
      }
      print('customers data has come successfully');
    } else {
      print('no there is an aerror');
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

    setState(() {});
  }

  @override
  void initState() {
    fetchCustomer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFF3F4F6).withOpacity(0.9),
      bottomNavigationBar: AdminNavBar(
        selectedMenu: MenuState.customer,
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
                      (itemData) => CustomerContentContainer(
                        id: itemData.id,
                        image: itemData.image,
                        name: itemData.name,
                        email: itemData.email,
                        phone: itemData.phone,
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
        "Customer Manage",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontFamily: 'KiwiMaru',
        ),
      ),
    ),
  );
}
