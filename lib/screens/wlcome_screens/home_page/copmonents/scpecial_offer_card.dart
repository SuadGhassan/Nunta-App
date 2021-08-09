import 'package:flutter/material.dart';
import 'package:nunta_app/constants.dart';

class SpecialOffersCard extends StatelessWidget {
  const SpecialOffersCard({
    Key key,
    @required this.id,
    @required this.itemType,
    @required this.image,
    @required this.discount,
    @required this.press,
  }) : super(key: key);

  final String id, itemType, image;
  final double discount;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: 240,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.6),
                        Color(0xFFEFB8BB).withOpacity(0.2),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: kPrimaryLightColor,fontFamily: "KiwiMaru"),
                      children: [
                        TextSpan(
                          text: "$itemType\n",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(text: "$discount SAR \n"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
