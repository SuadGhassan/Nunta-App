import 'package:flutter/material.dart';


class ProviderNavBarButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color;
  final String image;
  const ProviderNavBarButton({Key key, this.text, this.press, this.color, this.image, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
        onTap: press,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [ 
          Image.asset(image,width: 20,height: 20,color: color,),
          Text(
          text,
          style: TextStyle(color: color,fontWeight: FontWeight.bold,fontFamily: "KiwiMaru"),),]),);
        
  }
}