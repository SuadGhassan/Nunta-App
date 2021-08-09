import 'package:flutter/material.dart';
import 'package:nunta_app/Admin_Screens/admin_setting.dart';
import 'package:nunta_app/Admin_Screens/categories_manage.dart';
import 'package:nunta_app/Admin_Screens/city_manage.dart';
import 'package:nunta_app/Admin_Screens/components/admin_category.dart';
import 'package:nunta_app/Admin_Screens/components/admin_navigation_bar.dart';
import 'package:nunta_app/Admin_Screens/customer_manage.dart';
import 'package:nunta_app/Admin_Screens/provider_manage.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/enums.dart';




class AdminHomeScreen extends StatelessWidget {
  
  const AdminHomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFF3F4F6).withOpacity(0.9),
      bottomNavigationBar:AdminNavBar(selectedMenu: MenuState.adminHome,),
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
                      children:[AdminCategory(test: "Providers",image: "assets/icons/provider.png",onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context){return ProviderManage();}));},),
                      AdminCategory(test:"Customers",image: "assets/icons/noun_Customers_2837107.png",onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context){return CustomerManage();}));},),
                      AdminCategory(test:"Categories",image: "assets/icons/noun_Category_2706231.png",onTap:  (){Navigator.push(context, MaterialPageRoute(builder: (context){return CategoriesManage();}));},),
                      AdminCategory(test:"Setting",image: "assets/icons/noun_Settings_1413907.png",onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context){return AdminSetting();}));},),
                      AdminCategory(test: "Cities",image: "assets/icons/City.png",onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context){return CityManage();}));},),
                      

                      
                      
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

