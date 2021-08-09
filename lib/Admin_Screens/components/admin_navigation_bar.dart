import 'package:flutter/material.dart';
import 'package:nunta_app/Admin_Screens/admin_home_page.dart';
import 'package:nunta_app/Admin_Screens/admin_setting.dart';
import 'package:nunta_app/Admin_Screens/categories_manage.dart';
import 'package:nunta_app/Admin_Screens/customer_manage.dart';
import 'package:nunta_app/Admin_Screens/provider_manage.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/enums.dart';
import 'package:nunta_app/components/bottom_navigate_item.dart';


class AdminNavBar extends StatelessWidget {
  const AdminNavBar({Key key, this.selectedMenu}) : super(key: key);
final MenuState selectedMenu;
  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = kWordColor;
    return Container(
      width:double.infinity,
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
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[ BottomNavigateItem(
            press:(){Navigator.push(context, MaterialPageRoute(builder: (context){return AdminSetting();}));},
            color:MenuState.adminMore==selectedMenu?     kButtonColor:inActiveIconColor,
            text: "More",
            image: "assets/icons/noun_Settings_1413907.png",
           
          ),
          BottomNavigateItem(
            press: (){Navigator.push(context, MaterialPageRoute(builder: (context){return CustomerManage();}));},
            color:MenuState.customer==selectedMenu?     kButtonColor:inActiveIconColor,
            text: "Customer",
            image: "assets/icons/noun_Customers_2837107.png",
          ),
          BottomNavigateItem(
            press:  (){Navigator.push(context, MaterialPageRoute(builder: (context){return AdminHomeScreen();}));},
            color: MenuState.adminHome==selectedMenu?     kButtonColor:inActiveIconColor,
            text: "Home",
            
            image: "assets/icons/noun_homepage_1994323.png",
          ),
          BottomNavigateItem(
            press: (){Navigator.push(context, MaterialPageRoute(builder: (context){return CategoriesManage();}));},
            color: MenuState.category==selectedMenu?     kButtonColor:inActiveIconColor,
            text: "Category",
            image:"assets/icons/noun_Category_2706231.png" ,
            
          ),
           BottomNavigateItem(
            press:  (){Navigator.push(context, MaterialPageRoute(builder: (context){return ProviderManage();}));},
            color: MenuState.provider==selectedMenu?     kButtonColor:inActiveIconColor,
            text: "Provider",
            
            image: "assets/icons/provider.png",
          ),
          ]
        ),
      ),
    );
  }
}