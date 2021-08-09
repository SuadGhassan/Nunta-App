import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nunta_app/Admin_Screens/city_manage.dart';
import 'package:nunta_app/Admin_Screens/components/admin_navigation_bar.dart';
import 'package:nunta_app/ApiProvider.dart';
import 'package:nunta_app/components/button.dart';
import 'package:nunta_app/components/rounded_input_field.dart';
import 'package:nunta_app/components/snackBar_message.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/models/user_account_model.dart';
import 'package:nunta_app/service_locator.dart';

class AddNewCity extends StatefulWidget {
  const AddNewCity({Key key}) : super(key: key);

  @override
  _AddNewCityState createState() => _AddNewCityState();
}

class _AddNewCityState extends State<AddNewCity> {
  final myController = TextEditingController();
  String name=" ";
  final userToken = getIt<UserAccountModel>().userToken;
  
  Future<dynamic> addNewCity()async{
    final response= await APIProvider().get(url: "admin/city/add",params: {"api_token":userToken,"name":myController.text});
    if(response != null &&response['status'] == "success"){
      print("city added successfully");
      Navigator.push(context, MaterialPageRoute(builder: (context){return CityManage();}));
    }else {
      print('no there is an aerror');
      print(response);
      String errMessage = 'there is an error please try again later';
      if (response != null && response['status'] == "error") {
        errMessage = "${response['message']}";
      }
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(backgroundColor: Colors.red[900],content: SnackBarText(errMessage)));
    }
  }
  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: AdminNavBar(),
      body: Stack(children: [Container(height: height * 0.3,
          decoration: BoxDecoration(
            color: Color(0xFFEBA7AA),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),),SafeArea(
            child: SingleChildScrollView(
              child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 130),
      child: Card(
        color: kPrimaryLightColor,
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          child: Column(
              
                children: [
                  SizedBox(height: 20,),
                  RoundedInputField(hintText: "Name in English",controllers: myController,),
                  SizedBox(height: 20,),
                  Button(text: "add",press: ()=> addNewCity(),color: kButtonColor,),
                ],
          ),
        ),
      ),
    ),
            ),
          ),],)
    );
  }
}