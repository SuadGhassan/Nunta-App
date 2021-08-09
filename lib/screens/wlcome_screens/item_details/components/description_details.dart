import 'package:flutter/material.dart';
import 'package:nunta_app/constants.dart';

class DescriptionDetails extends StatelessWidget {
  final String desc;
  final String cityName;
  final String areaName;
  final String address;
  const DescriptionDetails({this.desc, this.cityName, this.areaName, this.address,  });

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 5,
              bottom: 5,
            ),
            child: Container(
                height: 70,
                width: double.infinity,
                child: Card(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Wrap(
                      children:[Text(
                        desc,
                        style: TextStyle(color: kWordColor, fontSize: 15),
                      ),] 
                    ),
                  ),
                )),
          ),
          Container(
            height: 130,
            width: double.infinity,
            child: Card(
              margin: EdgeInsets.only(left: 5, right: 5),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  children: [
                    Row(
                      
                      children: [
                        Text(
                          "City: \t\t ",
                          style: TextStyle(color: kTitleColor, fontSize: 16.5),
                        ),
                        Text(cityName,
                            style: TextStyle(color: kWordColor, fontSize: 15))
                      ],
                    ),
                    SizedBox(
                      height: 2.5,
                    ),
                    Row(
                       
                      children: [
                        Text(
                          "Area: \t\t",
                          style: TextStyle(color: kTitleColor, fontSize: 16.5),
                        ),
                        Text(areaName,
                            style: TextStyle(color: kWordColor, fontSize: 15))
                      ],
                    ),
                    SizedBox(
                      height: 2.5,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                        
                        text: TextSpan(
                          
                          children: [
                        TextSpan(text:
                            "Address: \t",
                            
                            style: TextStyle(color: kTitleColor, fontSize: 16.5,),
                          ),
                          TextSpan(text:
                            address,
                            style: TextStyle(color: kWordColor, fontSize: 15),
                          ),
                      ])
                          ),
                    )
                   
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2.5,
          ),
          
        ],
      ),
    );
  }
}