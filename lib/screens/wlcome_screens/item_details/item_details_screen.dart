import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nunta_app/ApiProvider.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/screens/wlcome_screens/item_details/components/add_to_cart_botton.dart';
import 'package:nunta_app/screens/wlcome_screens/item_details/components/description_details.dart';
import 'package:nunta_app/screens/wlcome_screens/item_details/components/review_details.dart';
import 'package:nunta_app/screens/wlcome_screens/cart/cart_screen.dart';

import 'package:nunta_app/components/snackBar_message.dart';
import 'package:nunta_app/models/user_account_model.dart';
import 'package:nunta_app/service_locator.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ItemDetailsScreen extends StatefulWidget {
  static const routeName = '/Item_Details_screen';
  final String itemId;
  final String itemTitle;

  const ItemDetailsScreen({
    this.itemTitle,
    this.itemId,
  });

  @override
  _ItemDetailsScreenState createState() =>
      _ItemDetailsScreenState(itemId, itemTitle);
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  String id;
  String title = "";
  String category = "";
  String cityName = "";
  String areaName = "";
  String address = "";
  String desc = "";
  String price = "";
  String phone = "";
  String image = "https://via.placeholder.com/500x500.png";
  double rate;
  List reviews = [];
  var smoothRating;
  final userToken = getIt<UserAccountModel>().userToken;

  _ItemDetailsScreenState(this.id, this.title);

  Future<void> fetchItemDetails() async {
    final response =
        await APIProvider().get(url: 'item/show', params: {'id': id});
    if (response != null && response['status'] == "success") {
      print(response);
      var rateToDouble = double.parse(response['result']['total_rate']);
      title = response['result']['name'];
      category = response['result']['category'];
      cityName = response['result']['city'];
      areaName = response['result']['area'];
      desc = response['result']['desc'];
      price = response['result']['price'];
      phone = response['result']['phone'];
      image = response['result']['img'];
      address = response['result']['address'];
      rate = rateToDouble / 2;

      print(rate);
      print('data has come successfully');

      smoothRating = SmoothStarRating(
        size: 25,
        color: kTitleColor,
        borderColor: kTitleColor,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_half,
        defaultIconData: Icons.star_border,
        starCount: 5,
        allowHalfRating: true,
        spacing: 4,
        rating: rate,
        isReadOnly: true,
      );
    } else {
      print('no there is an aerror');
    }
    setState(() {});
  }

  Future<dynamic> addToCart() async {
    final response = await APIProvider().get(url: 'cart/add', params: {
      'id': id,
      'api_token': userToken,
    });
    if (response != null && response['status'] == "success") {
      print('item has been added to cart successfully');
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) {
          return CartScreen();
        }),
      );
    } else {
      print('no there is an aerror');
      print(response);
      String errMessage = 'there is an aerror please try again later';
      if (response != null && response['status'] == "error") {
        errMessage = "${response['message']}";
      }
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(backgroundColor: Colors.red[900],content: SnackBarText(errMessage)));
    }
  }

  @override
  void initState() {
    fetchItemDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
            backgroundColor: kPrimaryLightColor,
            bottomNavigationBar:
                AddToCartBotton(id: id, pressme: () => addToCart()),
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              backgroundColor: Color(0xFFEBA7AA),
              elevation: 0,
              title: Align(
                alignment: Alignment.topRight,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'KiwiMaru',
                  ),
                ),
              ),
            ),
            body: Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(
                      image,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: kTitleColor,
                        fontFamily: 'KiwiMaru',
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "$price SAR",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: kTitleColor,
                        fontFamily: 'KiwiMaru',
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(child: smoothRating),
                    DefaultTabController(
                      length: 2, // length of tabs
                      initialIndex: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            child: TabBar(
                              indicatorColor: kPrimaryColor,
                              labelColor: kPrimaryColor,
                              unselectedLabelColor: Colors.grey,
                              labelStyle: TextStyle(fontFamily: 'KiwiMaru',fontWeight: FontWeight.bold),
                              tabs: [
                                Tab(text: "Reviews"),
                                Tab(text: "Description"),
                              ],
                            ),
                          ),
                          Container(
                            height: 400, //height of TabBarView
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.grey, width: 0.5))),
                            child: TabBarView(
                              children: <Widget>[
                                Container(
                                  child: ReviewDetails(itemId: id),
                                ),
                                Container(
                                  child: DescriptionDetails(
                                    desc: desc,
                                    cityName: cityName,
                                    areaName: areaName,
                                    address: address,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
