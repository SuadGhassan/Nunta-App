import 'package:flutter/material.dart';
import 'package:nunta_app/Admin_Screens/add_new_city.dart';
import 'package:nunta_app/Admin_Screens/components/admin_navigation_bar.dart';
import 'package:nunta_app/Admin_Screens/components/city_container.dart';
import 'package:nunta_app/ApiProvider.dart';
import 'package:nunta_app/components/snackBar_message.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/models/user_account_model.dart';
import 'package:nunta_app/service_locator.dart';

class CityManage extends StatefulWidget {
  const CityManage({Key key, this.cityName}) : super(key: key);
final String cityName;
  @override
  _CityManageState createState() => _CityManageState();
}

class _CityManageState extends State<CityManage> {
List data = [];
final userToken = getIt<UserAccountModel>().userToken;
// show cities
Future<dynamic> fetchCity() async {
    data = [];
    var response = await APIProvider().get(url: "admin/city/show", params: {"api_token":userToken});
    if (response != null && response['status'] == "success") {
      print(response);
      for (var i = 0; i < response['result'].length; i++) {
        var idToString = response['result'][i]['id'].toString();
        var onThing = CityContainer(
          name: response['result'][i]['name'],
          press: ()=> deleteCity(idToString),
          id: idToString,
        );
        
           
        data.add(onThing);
      
      }
      print('data has come successfully');
    } else {
      print('no there is an aerror');
    }

    setState(() {});
  }
  
  // delete a city

  Future<dynamic> deleteCity(String id) async {
    var response = await APIProvider().get(url: "admin/city/remove", params: {
      "id": id,
      "api_token": userToken,
    });
    if (response != null && response['status'] == "success") {
      fetchCity();
      print('City deleted successfully');
    } else {
      print('No, there is an error');
      print(response);
      String errMessage = 'there is an error please, try again later!';
      if (response != null && response['status'] == "error") {
        errMessage = "${response['message']}";
      }
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(backgroundColor: Colors.red[900],content: SnackBarText(errMessage)));
    }
  }


 @override
  void initState() {
    fetchCity();
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFF3F4F6).withOpacity(0.9),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kButtonColor,
      ),
      width: 275,
      height: 50,
      child: TextButton(
        clipBehavior: Clip.none,
        onPressed:()=>  Navigator.push(context, MaterialPageRoute(builder: (context){return AddNewCity();})),
        child:   Text(
          "Add New City",
          style: TextStyle(color: Colors.white, fontSize: 18.5,fontFamily: 'KiwiMaru',),
        ),
      ),
    ),
    SizedBox(height: 5,),
          AdminNavBar(),
        ],
      ),
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Container(
            height: height * 0.2,
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
                padding: const EdgeInsets.symmetric(horizontal: 10, ),
                child: Column(children: [Expanded(
                   child: ListView(
                     scrollDirection: Axis.vertical,
                     children: data
                         .map(
                           (citData) => CityContainer(
                             name: citData.name,
                             press: citData.press,
                             id: citData.id,
                           ),
                         )
                         .toList(),
                   ),
                      ),],
                  
                ),
              )),
        ],
      ),
    );
  }
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
        "Cities Manage",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontFamily: 'KiwiMaru',
        ),
      ),
    ),
  );
}
