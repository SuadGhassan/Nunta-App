import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nunta_app/enums.dart';
import 'package:nunta_app/models/category_card.dart';
import 'package:nunta_app/components/navigate_bar.dart';
import 'package:nunta_app/screens/wlcome_screens/cart/cart_screen.dart';
import 'package:nunta_app/screens/wlcome_screens/home_page/copmonents/scpecial_offer_card.dart';
import 'package:nunta_app/screens/wlcome_screens/home_page/copmonents/search_bar.dart';
import 'package:nunta_app/screens/wlcome_screens/item_details/item_details_screen.dart';
import 'package:nunta_app/models/category.dart';
import 'package:nunta_app/APIProvider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/Home_Page';
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //these lists are empty for if the inner data&banners lists are full and we want to add more items, so here the written code will automatic delete the ithem and full it again with the new items
  List data = [];
  List banners = [];
  Future<dynamic> fetchCategories() async {
    data = [];
    var response = await APIProvider().get(url: "home/categories", params: {});
    if (response != null && response['status'] == "success") {
      print(response);
      for (var i = 0; i < response['result'].length; i++) {
        var idToString = response['result'][i]['id'].toString();
        var oneThing = CategoryClass(
            id: idToString,
            title: response['result'][i]['name'],
            image: response['result'][i]['img']);
        data.add(oneThing);
      }
      print('data has come successfully');
    } else {
      print('no there is an aerror');
    }

    setState(() {});
  }

  Future<dynamic> fetchBanners() async {
    banners = [];
    var response = await APIProvider().get(url: "home/banners", params: {});
    if (response != null && response['status'] == "success") {
      print(response);
      for (var i = 0; i < response['result'].length; i++) {
        var idToString = response['result'][i]['id'].toString();
        var priceToDouble = double.parse(response['result'][i]['price']);
        var oneThing = SpecialOffersCard(
          id: idToString,
          image: response['result'][i]['img'],
          itemType: response['result'][i]['name'],
          discount: priceToDouble,
          press: () {
            openBanner(idToString, response['result'][i]['name']);
          },
        );
        banners.add(oneThing);
      }
      print('data has come successfully');
    } else {
      print('no there is an error');
    }

    setState(() {});
  }

  void openBanner(String id, String itemType) {
    print("Banner Pressed");
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return ItemDetailsScreen(itemId: id, itemTitle: itemType);
    }));
  }

  @override
  void initState() {
    fetchCategories();
    fetchBanners();
    super.initState();
  }

  @override
  void dispose() {
    fetchCategories();
    // data.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFF3F4F6).withOpacity(0.9),
      bottomNavigationBar: NavigateBar(selectedMenu: MenuState.Home),
      body: Stack(
        children: [
          Container(
            height: height * 0.35,
            decoration: BoxDecoration(
              color: Color(0xFFEBA7AA),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(13),
                bottomRight: Radius.circular(13),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: Text(
                          "Welcome to your \n World!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: "KiwiMaru"),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 52,
                          width: 52,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return CartScreen();
                              }));
                            },
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              color: Color(0xFF659377),
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SearchBar(),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: GridView.count(
                      scrollDirection: Axis.vertical,
                      crossAxisCount: 2,
                      childAspectRatio: 1.3,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 30,
                      children: data
                          .map(
                            (catData) => CategoryCard(
                              id: catData.id,
                              title: catData.title,
                              image: catData.image,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: banners
                          .map(
                            (banData) => SpecialOffersCard(
                              id: banData.id,
                              itemType: banData.itemType,
                              image: banData.image,
                              discount: banData.discount,
                              press: banData.press,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
