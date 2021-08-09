import 'package:flutter/material.dart';
import 'package:nunta_app/Admin_Screens/components/admin_navigation_bar.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/models/item_card.dart';
import 'package:nunta_app/models/user_account_model.dart';
import 'package:nunta_app/APIProvider.dart';
import 'package:nunta_app/service_locator.dart';

class ItemsDisplayScreen extends StatefulWidget {
  final String id;
  const ItemsDisplayScreen({Key key, this.id}) : super(key: key);

  @override
  _ItemsDisplayScreenState createState() => _ItemsDisplayScreenState(id);
}

class _ItemsDisplayScreenState extends State<ItemsDisplayScreen> {
  String id;
  _ItemsDisplayScreenState(this.id);

  List data = [];
  final userToken = getIt<UserAccountModel>().userToken;
  Future<dynamic> fetchItems() async {
    data = [];
    var response =
        await APIProvider().get(url: "admin/provider/items", params: {
      "api_token": userToken,
      "id": id,
    });
    if (response != null && response['status'] == "success") {
      print(response);
      for (var i = 0; i < response['result'].length; i++) {
        var idToString = response['result'][i]['id'].toString();
        print(response['result'][i]['total_rate']);
        var rateToDouble = double.parse(response['result'][i]['total_rate']);
        var oneThing = ItemCard(
          id: idToString,
          title: response['result'][i]['name'],
          image: response['result'][i]['img'],
          rate: rateToDouble,
        );
        data.add(oneThing);
      }
      print('data has come successfully');
    } else {
      print('no there is an error');
      String errMessage = 'Please check your data and try again';
      if (response != null && response['status'] == "error") {
        errMessage = "${response['message']}";
      }
      print(errMessage);

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
      bottomNavigationBar: AdminNavBar(),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kPrimaryLightColor,
        ),
        backgroundColor: Color(0xFFEBA7AA),
        elevation: 0,
        title: Align(
            alignment: Alignment.topRight,
            child: Text(
              "Provider Item",
              style: TextStyle(color: kPrimaryLightColor,fontFamily: 'KiwiMaru',),
            )),
      ),
      body: Stack(children: [
        Container(
          height: height * 0.15,
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
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
               SizedBox(height: 15,),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: GridView.count(
                      scrollDirection: Axis.vertical,
                      crossAxisCount: 2,
                      childAspectRatio: 0.9,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 0,
                      children: data
                          .map(
                            (itemData) => ItemCard(
                              id: itemData.id,
                              image: itemData.image,
                              title: itemData.title,
                              rate: itemData.rate,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
