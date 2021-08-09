import 'package:flutter/material.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/screens/wlcome_screens/item_details/item_details_screen.dart';

import 'package:smooth_star_rating/smooth_star_rating.dart';

class ItemCard extends StatelessWidget {
  final String id;
  final String image;
  final String title;
  final double rate;

  ItemCard({this.id, this.image, this.title, this.rate});

  void _selectItem(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return ItemDetailsScreen(itemId: id, itemTitle: title);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: kPrimaryLightColor,
      child: InkWell(
        onTap: () => _selectItem(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 125,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: TextStyle(fontSize: 13, color: kWordColor),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.center,
              child: SmoothStarRating(
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
            )
          ],
        ),
      ),
    );
  }
}
