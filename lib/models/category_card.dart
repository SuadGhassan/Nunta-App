import 'package:flutter/material.dart';
import 'package:nunta_app/screens/wlcome_screens/items_page/item_page.dart';

class CategoryCard extends StatelessWidget {
  final String id;
  final String title;
  final String image;

  const CategoryCard({
    this.id,
    this.title,
    this.image,
  });
  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return ItemsPage(categoryId: id, categoryTitle: title);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
                offset: Offset(8, 8),
                blurRadius: 30,
                spreadRadius: -35,
                color: Colors.grey[600])
          ],
        ),
        child: Material(
          color: Colors.white30, //color for transparent when i click on it
          child: InkWell(
            // splashColor: kPrimaryColor,
            onTap: () => selectCategory(context),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.network(
                    image,
                    alignment: Alignment.topRight,
                    width: 45,
                    height: 45,
                    // color: kButtonColor,
                  ),
                  Spacer(),
                  Text(
                    title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFF659377),
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      fontFamily: "KiwiMaru"
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
