import 'package:flutter/material.dart';
import 'package:nunta_app/constants.dart';


class AddToCartBotton extends StatelessWidget {
  final GestureTapCallback pressme;
  final String id;
  const AddToCartBotton({
    Key key,
    @required this.pressme,
    @required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: kButtonColor,
      ),
      // width: 250,
      // height: 50,
      child: TextButton(
        clipBehavior: Clip.none,
        onPressed: pressme,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ADD TO \t",
              style: TextStyle(color: Colors.white, fontSize: 18.5),
            ),
            SizedBox(width: 5),
            Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
              size: 25,
            )
          ],
        ),
      ),
    );
  }
}
