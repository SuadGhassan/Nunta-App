import 'package:flutter/material.dart';


//this is button bar
class AdminBottomNavigateItem extends StatelessWidget {
  final Function press;
  final String text;
  final Color color;
  final String image;
  
  const AdminBottomNavigateItem({
    Key key,
    this.press,
    this.text,
    this.color, this.image,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
        onTap: press,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [ 
          Image.asset(image,width: 20,height: 20,color: color,),
          Text(
          text,
          style: TextStyle(color: color,fontWeight: FontWeight.bold),),]),);
        
  }
}