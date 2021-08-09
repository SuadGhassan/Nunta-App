import 'package:flutter/material.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/enums.dart';
import 'package:nunta_app/screens/wlcome_screens/cart/components/button_container.dart';
import 'package:nunta_app/screens/wlcome_screens/cart/components/item_container_in_cart.dart';
import 'package:nunta_app/components/navigate_bar.dart';
import 'package:nunta_app/screens/wlcome_screens/home_page/home_screen.dart';
import 'package:nunta_app/screens/wlcome_screens/pay_and_userAccount/payment_screen.dart';

import 'package:nunta_app/components/snackBar_message.dart';
import 'package:nunta_app/models/user_account_model.dart';
import 'package:nunta_app/service_locator.dart';
import 'package:nunta_app/APIProvider.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/Cart_screen';
  const CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List data = [];
  double total = 0;
  final userToken = getIt<UserAccountModel>().userToken;

  Future<dynamic> fetchItems() async {
    data = [];
    total = 0;
    var response = await APIProvider().get(url: "cart/show", params: {
      "api_token": userToken,
    });
    if (response != null && response['status'] == "success") {
      print(response);
      for (var i = 0; i < response['result'].length; i++) {
        var idToString = response['result'][i]['id'].toString();
        var oneThing = ItemContainerInCart(
          test: response['result'][i]['name'],
          image: response['result'][i]['img'],
          price: response['result'][i]['price'],
          pressme: () => deleteItem
      (idToString),
        );
        data.add(oneThing);
        total += double.parse(response['result'][i]['price']);
      }
      print('data has come successfully');
    } else {
      print('no there is an aerror');
      print(response);
      String errMessage = 'there is an aerror please try again later';
      if (response != null && response['status'] == "error") {
        errMessage = "${response['message']}";
      }
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: SnackBarText(errMessage)));
    }

    setState(() {});
  }

  Future<dynamic> deleteItem(String id) async {
    var response = await APIProvider().get(url: "cart/remove", params: {
      "id": id,
      "api_token": userToken,
    });
    if (response != null && response['status'] == "success") {
      fetchItems();
      print('item deleted successfully');
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

  void toPaymentScreen() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return PaymentScreen(total: total);
      },
    ));
  }

  @override
  void initState() {
    fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFF3F4F6).withOpacity(0.9),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: kPrimaryLightColor,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 8), blurRadius: 30, color: kWordColor)
                  ]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total:",
                          style: TextStyle(color: kTitleColor, fontSize: 20,fontFamily: "KiwiMaru"),
                        ),
                        Text(
                          "$total SAR",
                          style: TextStyle(color: kTitleColor, fontSize: 20,fontFamily: ""),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonContainer(
                          color: Color(0xFFC86161),
                          text: "Cancel",
                          press: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return HomeScreen();
                              },
                            ));
                          },
                        ),
                        ButtonContainer(
                          color: kButtonColor,
                          text: "Confirm",
                          press: () {
                            toPaymentScreen();
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          NavigateBar(selectedMenu: MenuState.order),
        ],
      ),
      appBar: buildAppBar(),
      body: Stack(
        children: [
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
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: ListView(
                          children: data
                              .map(
                                (itemData) => ItemContainerInCart(
                                  image: itemData.image,
                                  test: itemData.test,
                                  price: itemData.price,
                                  pressme: itemData.pressme,
                                ),
                              )
                              .toList(),
                        )),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
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
          "Your Items",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontFamily: "KiwiMaru"
          ),
        ),
      ),
    );
  }
}
