import 'package:flutter/material.dart';
import 'package:nunta_app/Provider_Screens/add_new_item.dart';
import 'package:nunta_app/Provider_Screens/components/provider_navigator_bar.dart';
import 'package:nunta_app/Provider_Screens/components/provider_item_card.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/enums.dart';
import 'package:nunta_app/components/snackBar_message.dart';
import 'package:nunta_app/models/user_account_model.dart';
import 'package:nunta_app/APIProvider.dart';
import 'package:nunta_app/service_locator.dart';

class ItemsManage extends StatefulWidget {
  const ItemsManage({Key key}) : super(key: key);

  @override
  _ItemsManageState createState() => _ItemsManageState();
}

class _ItemsManageState extends State<ItemsManage> {
  List data = [];
  final userToken = getIt<UserAccountModel>().userToken;
  Future<dynamic> fetchItems() async {
    data = [];
    var response = await APIProvider().get(url: "provider/items/show", params: {
      "api_token": userToken,
    });
    if (response != null && response['status'] == "success") {
      print(response);
      for (var i = 0; i < response['result'].length; i++) {
        var idToString = response['result'][i]['id'].toString();
        print(response['result'][i]['total_rate']);
        var rateToDouble = double.parse(response['result'][i]['total_rate']);
        var oneThing = ProviderItemCard(
          id: idToString,
          name: response['result'][i]['name'],
          image: response['result'][i]['img'],
          deleteePress: () => deleteProviderItem(idToString),
        );
        data.add(oneThing);
      }
      print('provider items data has come successfully');
    } else {
      print('no there is an error');
      String errMessage = 'Please check your data and try again';
      if (response != null && response['status'] == "error") {
        errMessage = "${response['message']}";
      }
      print(errMessage);

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

  Future<dynamic> deleteProviderItem(String id) async {
    var response =
        await APIProvider().get(url: "provider/items/remove", params: {
      "api_token": userToken,
      "id": id,
    });
    if (response != null && response['status'] == "success") {
      print(response);
      print('provider has been deleted');
      fetchItems();
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red[900],
          content: SnackBarText("Provider has been deleted Successfully")));
    } else {
      print(response);
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

  @override
  void initState() {
    fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFF3F4F6).withOpacity(0.9),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
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
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddNewItem();
                  }));
                },
                child: Text(
                  "Add New Item",
                  style: TextStyle(color: Colors.white, fontSize: 18.5,fontFamily: "KiwiMaru"),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            ProviderNavBar(selectedMenu: MenuState.item),
          ],
        ),
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
                      (itemData) => ProviderItemCard(
                        id: itemData.id,
                        name: itemData.name,
                        image: itemData.image,
                        deleteePress: itemData.deleteePress,
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
        "Items Manage",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,fontFamily: "KiwiMaru"
        ),
      ),
    ),
  );
}