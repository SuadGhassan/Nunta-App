import 'package:flutter/material.dart';
import 'package:nunta_app/ApiProvider.dart';
import 'package:nunta_app/components/button.dart';
import 'package:nunta_app/components/snackBar_message.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/models/user_account_model.dart';
import 'package:nunta_app/service_locator.dart';

class AreaContainer extends StatefulWidget {
  const AreaContainer({
    Key key,
    this.name,
    this.deletePress,
    this.id, this.cityIds,
  }) : super(key: key);
  final String id;
  final String cityIds;
  final String name;
  
  final GestureTapCallback deletePress;

  @override
  _AreaContainerState createState() => _AreaContainerState(id,name,cityIds);
}

class _AreaContainerState extends State<AreaContainer> {
  String name;
  String id;
  String cityId;
  
  _AreaContainerState(this.id,this.name,this.cityId);
    bool isEditable = false;
  final myController = TextEditingController();
final userToken = getIt<UserAccountModel>().userToken;
  // Edit Area
Future<dynamic> editAreaName()async{
final response = await APIProvider().get(
        url: "admin/area/edit",
        params: {"api_token": userToken, "name": myController.text,"id":id,"city_id":cityId});
    print(response);
    if (response != null && response["status"] == "success") {
      print("area edited successfully");
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
      margin: EdgeInsets.only(top: 5,bottom: 5),
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kPrimaryLightColor,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: isEditable?Text(
              widget.name,
              style: TextStyle(color: kWordColor, fontSize: 20),
            ):TextField(
                          controller: myController,
                         decoration: InputDecoration(hintText: widget.name,hintStyle: TextStyle(color: Colors.black,fontSize: 20),border: InputBorder.none,), 
                          onChanged: (_) {
                            setState(() => {
                                  isEditable = false,
                                  name = myController.text
                                });
                          },
                        ),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Button(
                press: (){isEditable=true;
                  editAreaName();},
                text: "Edit",
                color: kWordColor.withOpacity(0.3),
              ),
              Button(
                press:widget.deletePress,
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