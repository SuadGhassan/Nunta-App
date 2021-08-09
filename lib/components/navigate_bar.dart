import 'package:flutter/material.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/enums.dart';
import 'package:nunta_app/screens/wlcome_screens/cart/cart_screen.dart';
import 'package:nunta_app/components/bottom_navigate_item.dart';
import 'package:nunta_app/screens/wlcome_screens/home_page/home_screen.dart';
import 'package:nunta_app/screens/wlcome_screens/offers/offers_screen.dart';
import 'package:nunta_app/screens/wlcome_screens/pay_and_userAccount/setting_screen.dart';


class NavigateBar extends StatelessWidget {
  const NavigateBar({
    Key key, this.selectedMenu,
  }) : super(key: key);
final MenuState selectedMenu;
  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = kWordColor;
    // double height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      // margin: EdgeInsets.only(top: 5,),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      height: 60,

      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // mainAxisSize: MainAxisSize.min,
          children: [
            BottomNavigateItem(
              press: () {Navigator.push(context, MaterialPageRoute(builder: (context){return SettingsScreen();}),);},
              color: MenuState.More==selectedMenu?     kButtonColor:inActiveIconColor,
              text: "More",
              image: "assets/icons/noun_Settings_1413907.png",
            ),
            BottomNavigateItem(
              press: () {Navigator.push(context, MaterialPageRoute(builder: (context){return OffersScreen();}),);},
              color: MenuState.offers==selectedMenu?     kButtonColor:inActiveIconColor,
              text: "Offers",
              image: "assets/icons/noun_offer_3309399.png",
            ),
            BottomNavigateItem(
              press: () {Navigator.push(context, MaterialPageRoute(builder: (context){return CartScreen();}),);},
              color: MenuState.order==selectedMenu?     kButtonColor:inActiveIconColor,
              text: "Cart",
              image: "assets/icons/noun_product_1247950.png",
            ),
            BottomNavigateItem(
              press: () {Navigator.push(context, MaterialPageRoute(builder: (context){return HomeScreen();},),);},
              color: MenuState.Home==selectedMenu?     kButtonColor:inActiveIconColor,
              text: "HomePage",
              image: "assets/icons/noun_homepage_1994323.png",
            ),
          ],
        ),
      ),
    );
  }
}
