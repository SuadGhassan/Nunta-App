import 'package:flutter/material.dart';
import 'package:nunta_app/Admin_Screens/items_display_screen.dart';
import 'package:nunta_app/components/button.dart';
import 'package:nunta_app/constants.dart';

class ProviderContentContainer extends StatelessWidget {
  final String id;
  final String image;
  final String name;
  final String email;
  final String phone;
  final GestureTapCallback deletePress;
  const ProviderContentContainer({
    Key key,
    this.id,
    this.image,
    this.name,
    this.email,
    this.phone,
    this.deletePress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 175,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kPrimaryLightColor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                //this ClipRRect important for image border.
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: 115,
                  height: 80,
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: kWordColor, fontSize: 13),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    email,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: kWordColor, fontSize: 14),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    phone,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: kWordColor, fontSize: 14),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Button(
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ItemsDisplayScreen(id: id);
                  }));
                },
                text: "Items",
                color: kWordColor.withOpacity(0.3),
              ),
              Button(
                press: deletePress,
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
