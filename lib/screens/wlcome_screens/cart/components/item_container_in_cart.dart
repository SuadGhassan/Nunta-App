import 'package:flutter/material.dart';
import 'package:nunta_app/components/button.dart';
import 'package:nunta_app/constants.dart';

class ItemContainerInCart extends StatelessWidget {
  final String image, test, price;
  final GestureTapCallback pressme;
  const ItemContainerInCart({
    Key key,
    this.image,
    this.test,
    this.price,
    this.pressme,
  });

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
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      test,
                      style: TextStyle(color: kWordColor, fontSize: 13,fontFamily: "KiwiMaru"),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "$price SAR",
                      style: TextStyle(color: kTitleColor, fontSize: 14,fontFamily: "KiwiMaru"),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Button(
                press: pressme,
                text: "cancel",
                color: kButtonColor,
              )
            ],
          )
        ],
      ),
    );
  }
}
