import 'package:flutter/material.dart';
import 'package:nunta_app/Admin_Screens/components/admin_category.dart';
import 'package:nunta_app/Provider_Screens/components/provider_navigator_bar.dart';
import 'package:nunta_app/Provider_Screens/items_manage.dart';
import 'package:nunta_app/Provider_Screens/offers_manage.dart';
import 'package:nunta_app/Provider_Screens/setting_screen.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/enums.dart';

class ProviderHomeScreen extends StatelessWidget {
  
  const ProviderHomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFF3F4F6).withOpacity(0.9),
      bottomNavigationBar:ProviderNavBar(selectedMenu: MenuState.providerHome,),
      appBar: buildAppBar(),
      body: Stack(children: [Container(
          height: height * 0.2,
          decoration: BoxDecoration(
            color: Color(0xFFEBA7AA),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        SafeArea(child: Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,top: 80),
            child: Column(
              children: [
                
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: GridView.count(scrollDirection: Axis.vertical,
                        crossAxisCount: 2,
                        childAspectRatio: 1.3,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 30,
                      children:[AdminCategory(test: "Offers",image: "assets/icons/noun_offer.png",onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context){return OffersManage();}));},),
                      AdminCategory(test:"Items",image: "assets/icons/noun_product.png",onTap:  (){Navigator.push(context, MaterialPageRoute(builder: (context){return ItemsManage();}));},),
                      AdminCategory(test:"Settings",image: "assets/icons/noun_Settings_1413907.png",onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context){return ProviderSetting();}));},),
                      ]
                    ),
                  ),
                ),
              ],
            ),
          ),)
        ],),
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
        "Home Page",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontFamily: 'KiwiMaru',
        ),
      ),
    ),
  );
  }
}

