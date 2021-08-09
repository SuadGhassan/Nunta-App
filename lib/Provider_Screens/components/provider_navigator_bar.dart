import 'package:flutter/material.dart';
import 'package:nunta_app/Provider_Screens/components/provider_nav_bottom_button.dart';
import 'package:nunta_app/Provider_Screens/items_manage.dart';
import 'package:nunta_app/Provider_Screens/offers_manage.dart';
import 'package:nunta_app/Provider_Screens/provider_home_page.dart';
import 'package:nunta_app/Provider_Screens/setting_screen.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/enums.dart';

class ProviderNavBar extends StatelessWidget {
  const ProviderNavBar({Key key, this.selectedMenu}) : super(key: key);
  final MenuState selectedMenu;
  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = kWordColor;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      height: 60,
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: 5,
            ),
            ProviderNavBarButton(
              text: "Offers",
              color: MenuState.providerOffers == selectedMenu
                  ? kButtonColor
                  : inActiveIconColor,
              image: "assets/icons/noun_offer.png",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return OffersManage();
                }));
              },
            ),
            SizedBox(
              width: 5,
            ),
            ProviderNavBarButton(
              text: "Items",
              color: MenuState.item == selectedMenu
                  ? kButtonColor
                  : inActiveIconColor,
              image: "assets/icons/noun_product.png",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ItemsManage();
                }));
              },
            ),
             SizedBox(
              width: 5,
            ),
            ProviderNavBarButton(
              text: "More",
              color: MenuState.providerMore == selectedMenu
                  ? kButtonColor
                  : inActiveIconColor,
              image: "assets/icons/noun_Settings_1413907.png",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProviderSetting();
                }));
              },
            ),
            SizedBox(
              width: 5,
            ),
            ProviderNavBarButton(
              text: "Home",
              color: MenuState.providerHome == selectedMenu
                  ? kButtonColor
                  : inActiveIconColor,
              image: "assets/icons/noun_homepage_1994323.png",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProviderHomeScreen();
                }));
              },
            ),
             SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }
}

