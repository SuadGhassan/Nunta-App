import 'package:flutter/material.dart';
import 'package:nunta_app/constants.dart';

import 'package:nunta_app/components/navigate_bar.dart';
import 'package:nunta_app/models/item_card.dart';

import 'package:nunta_app/models/item.dart';
import 'package:nunta_app/APIProvider.dart';

class ItemsPage extends StatefulWidget {
  static const routeName = '/Item_Page_screen';
  final String categoryId;
  final String categoryTitle;

  ItemsPage({this.categoryId, this.categoryTitle});
  @override
  _ItemsPageState createState() => _ItemsPageState(categoryId);
}

class _ItemsPageState extends State<ItemsPage> {
  //this list has the same reason to be empty like lists in the home screen
  List data = [];
  String categoryId;
  _ItemsPageState(this.categoryId);
  Future<dynamic> fetchItems() async {
    data = [];
    var response = await APIProvider().get(url: "home/item", params: {
      "categories_id": categoryId,
    });
    if (response != null && response['status'] == "success") {
      print(response);
      for (var i = 0; i < response['result'].length; i++) {
        var idToString = response['result'][i]['id'].toString();
        print(response['result'][i]['total_rate']);
        var rateToDouble = double.parse(response['result'][i]['total_rate']);
        var oneThing = Item(
          id: idToString,
          categoryIds: "1",
          title: response['result'][i]['name'],
          image: response['result'][i]['img'],
          rate: rateToDouble,
        );
        data.add(oneThing);
      }
      print('data has come successfully');
    } else {
      print('no there is an aerror');
    }

    setState(() {});
  }

  @override
  void initState() {
    fetchItems();
    super.initState();
  }
  @override
  void dispose() {
    fetchItems();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFF3F4F6).withOpacity(0.9),
      bottomNavigationBar: NavigateBar(),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kPrimaryLightColor,
        ),
        backgroundColor: Color(0xFFEBA7AA),
        elevation: 0,
        title: Align(
          alignment: Alignment.topRight,
          child: Text(
            widget.categoryTitle,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontFamily: "KiwiMaru"
            ),
          ),
        ),
      ),
      body: Stack(children: [
        Container(
          height: height * 0.1,
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
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: GridView.count(
                      scrollDirection: Axis.vertical,
                      crossAxisCount: 2,
                      childAspectRatio: 0.95,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 0,
                      children: data
                          .map(
                            (itemData) => ItemCard(
                              id: itemData.id,
                              image: itemData.image,
                              title: itemData.title,
                              rate: itemData.rate / 2,
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
