import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nunta_app/constants.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class CommentContainer extends StatelessWidget {
  final String networkImage, test1, test2;
  final double rate;

  const CommentContainer(
      {this.networkImage, this.test1, this.test2, this.rate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      // height: 120,
      margin: EdgeInsets.only(top: 5, bottom: 5),
      padding: EdgeInsets.only(top: 5, bottom: 5),
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
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.2,
                  backgroundImage: NetworkImage(networkImage),
                  backgroundColor: Color(0xFFF3F4F6),
                ),
                SizedBox(
                  width: 5,
                ),
                Column(
                  children: [
                    Text(
                      test1,
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
                      rating: rate,
                      isReadOnly: true,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Align(alignment: Alignment.bottomLeft, child: Text(test2)),
          ],
        ),
      ),
    );
  }
}
