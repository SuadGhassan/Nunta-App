import 'package:flutter/material.dart';
import 'package:nunta_app/components/button.dart';
import 'package:nunta_app/constants.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProCommentToManage extends StatelessWidget {
  final String name;
  final String image;
  final double evaluate;
  final String evaluatecomment;
  final GestureTapCallback deleteEvaluatePress;
  const ProCommentToManage({
    Key key,
    this.name,
    this.image,
    this.evaluate,
    this.evaluatecomment,
    this.deleteEvaluatePress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: 500,
        height: 140,
        decoration: BoxDecoration(
          color: kPrimaryLightColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                offset: Offset(8, 8),
                blurRadius: 30,
                spreadRadius: -35,
                color: Colors.grey[600])
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                      radius: 25.5, backgroundImage: NetworkImage(image)),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    children: [
                      Text(
                        name,
                        style: TextStyle(color: kWordColor, fontSize: 13.5),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SmoothStarRating(
                        size: 15,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        starCount: 5,
                        allowHalfRating: true,
                        spacing: 4,
                        color: kTitleColor,
                        borderColor: kTitleColor,
                        rating: evaluate,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(evaluatecomment)),
              SizedBox(
                height: 1,
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Button(
                    text: "Delete",
                    press: deleteEvaluatePress,
                    color: kPrimaryColor,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
