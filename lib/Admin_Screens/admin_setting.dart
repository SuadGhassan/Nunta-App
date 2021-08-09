import 'package:flutter/material.dart';
import 'package:nunta_app/Admin_Screens/admin_account.dart';
import 'package:nunta_app/Admin_Screens/components/admin_navigation_bar.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/enums.dart';
import 'package:nunta_app/screens/wlcome_screens/login/login_screen.dart';


class AdminSetting extends StatelessWidget {
  const AdminSetting({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFF3F4F6).withOpacity(0.9),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kPrimaryLightColor,
        ),
        backgroundColor: Color(0xFFEBA7AA),
        elevation: 0,
        title: Align(
          alignment: Alignment.topRight,
          child: Text(
            "Settings!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontFamily: 'KiwiMaru',
            ),
          ),
        ),
      ),
      bottomNavigationBar: AdminNavBar(selectedMenu:MenuState.adminMore),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Color(0xFFEBA7AA)),
            height: height * 0.15,
          ),
           SafeArea(
             child: Container(
               margin: EdgeInsets.only(top: 80),
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   Container(
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kPrimaryLightColor),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){return AdminAccount();}));
                            
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icons/user.png",
                                width: 35,
                                height: 35,
                                color: kButtonColor,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "MyProfile",
                                style: TextStyle(fontSize: 13, color: kButtonColor,fontFamily: "KiwiMaru"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5,),
                      
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kPrimaryLightColor),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){return LoginScreen();}));
                            
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icons/logout.png",
                                width: 35,
                                height: 35,
                                color: kButtonColor,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Logout",
                                style: TextStyle(fontSize: 13, color: kButtonColor,fontFamily: "KiwiMaru"),
                              ),
                            ],
                          ),
                          
                        ),
                      ),
                 ],
               ),
             ),
           ),
              
        ]
      ),
    );
  }
}
