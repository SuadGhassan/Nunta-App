import 'package:flutter/material.dart';
import 'package:nunta_app/Admin_Screens/areas_manage.dart';
import 'package:nunta_app/ApiProvider.dart';
import 'package:nunta_app/components/button.dart';
import 'package:nunta_app/components/snackBar_message.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/models/user_account_model.dart';
import 'package:nunta_app/service_locator.dart';

class CityContainer extends StatefulWidget {
  final String name;
  final GestureTapCallback press;
  final String id;
  const CityContainer({
    Key key, this.name, this.press, this.id, 
     
    
  }): super(key: key);

  @override
  _CityContainerState createState() => _CityContainerState(name,id);
}

class _CityContainerState extends State<CityContainer> {
  final userToken = getIt<UserAccountModel>().userToken;
  bool isEditable = false;
  final myController = TextEditingController();
  String name;
  String id;
  _CityContainerState(this.name,this.id);
  Future<dynamic> editCityName() async {
    final response = await APIProvider().get(
        url: "admin/city/edit",
        params: {"api_token": userToken, "name": myController.text,"id":id});
    print(response);
    if (response != null && response["status"] == "success") {
      print("city edited successfully");
    } else {
      print('no there is an error');
      print(response);
      String errMessage = 'there is an error please try again later';
      if (response != null && response['status'] == "error") {
        errMessage = "${response['message']}";
      }
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: SnackBarText(errMessage)));
    }
  }
 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 5),
      height: 145,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kPrimaryLightColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: isEditable
                      ? Text(
                          name,
                          style: TextStyle(color: kWordColor, fontSize: 20),
                        )
                      : TextField(
                          controller: myController,
                         decoration: InputDecoration(hintText: name,hintStyle: TextStyle(color: Colors.black,fontSize: 20),border: InputBorder.none,), 
                          onChanged: (_) {
                            setState(() => {
                                  isEditable = false,
                                  name = myController.text
                                });
                          },
                        )),
              Button(
                press: () {
                  setState(() {
                    isEditable = true;
                    editCityName();
                  });
                },
                text: "Edit",
                color: kWordColor.withOpacity(0.3),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Button(
                press: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return AreasManage(cityId: id,);
                  }));
                },
                text: "Areas",
                color: kWordColor.withOpacity(0.3),
              ),
              Button(
                press: widget.press,
                text: "Delete",
                color: kPrimaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
