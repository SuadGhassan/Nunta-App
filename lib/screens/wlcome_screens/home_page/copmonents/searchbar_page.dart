import 'package:flutter/material.dart';
import 'package:nunta_app/ApiProvider.dart';
import 'package:nunta_app/components/navigate_bar.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/models/item.dart';
import 'package:nunta_app/models/item_card.dart';
import 'package:nunta_app/components/snackBar_message.dart';

class SearchbarPage extends StatefulWidget {
  final String searchbarText;
  final void Function() searchbarCallBack;
  SearchbarPage({Key key, this.searchbarText, this.searchbarCallBack})
      : super(key: key);

  @override
  _SearchbarPageState createState() => _SearchbarPageState(searchbarText);
}

class _SearchbarPageState extends State<SearchbarPage> {
  String searchbarText;
  _SearchbarPageState(this.searchbarText);

  List _items = []; // list of items will take it from APIs
  List _filteredItems = []; // items filtered by search text

  Future _fetchItemData() async {
    List tempItemData = [];
    print("searchbarText is:  $searchbarText");
    final response = await APIProvider()
        .get(url: "home/search", params: {'search': searchbarText});
    if (response != null && response['status'] == "success") {
      print(response);
      if (response['result'].length < 1) {
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          
            backgroundColor: Colors.red[900],
            content: SnackBarText("No result found")));
      }
      for (int i = 0; i < response['result'].length; i++) {
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
        tempItemData.add(oneThing);
      }
      setState(() {
        _items = tempItemData;
        _filteredItems = _items;
      });
    }
  }

  @override
  void initState() {
    _fetchItemData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
            widget.searchbarText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontFamily: "KiwiMaru",
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
                      children: _filteredItems
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
