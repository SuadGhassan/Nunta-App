import 'package:flutter/material.dart';


class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Container(
      
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        width: size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.zero,
        ),
        child: child,
      );
    
  }
}
