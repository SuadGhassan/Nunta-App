import 'package:flutter/material.dart';
import 'package:nunta_app/Provider_Screens/provider_evaluation_manage.dart';
import 'package:nunta_app/Provider_Screens/edit_item.dart';
import 'package:nunta_app/components/button.dart';
import 'package:nunta_app/constants.dart';

class ProviderItemCard extends StatelessWidget {
  final String id;
  final String name;
  final String image;
  final GestureTapCallback deleteePress;
  const ProviderItemCard({
    Key key,
    this.id,
    this.name,
    this.image,
    this.deleteePress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 7),
      height: 175,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kPrimaryLightColor,
      ),
      child: Column(
        children: [
          Row(
            //this important to make it at the same begining
            crossAxisAlignment: CrossAxisAlignment.start,

            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                //this ClipRRect important for image border.
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: 115,
                  height: 80,
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  name,
                  style: TextStyle(color: kWordColor, fontSize: 15),
                ),
              ),
              
              
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Button(
                press: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return EditItem(id: id);
                    },
                  ));
                },
                text: "Edit",
                color: kWordColor.withOpacity(0.3),
              ),
              
              Button(
                press: deleteePress,
                text: "Delete",
                color: kPrimaryColor,
              ),
              Button(
                press: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return EvaluationManage(id: id);
                    },
                  ));
                },
                text: "Evaluation",
                color: kWordColor.withOpacity(0.3),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
