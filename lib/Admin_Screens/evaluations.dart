import 'package:flutter/material.dart';
import 'package:nunta_app/Admin_Screens/components/admin_navigation_bar.dart';
import 'package:nunta_app/Admin_Screens/components/comment_to_manage.dart';
import 'package:nunta_app/constants.dart';

import 'package:nunta_app/components/snackBar_message.dart';

import 'package:nunta_app/models/user_account_model.dart';
import 'package:nunta_app/APIProvider.dart';
import 'package:nunta_app/service_locator.dart';

class Evaluations extends StatefulWidget {
  final id;
  const Evaluations({Key key, this.id}) : super(key: key);

  @override
  _EvaluationsState createState() => _EvaluationsState(id);
}

class _EvaluationsState extends State<Evaluations> {
  String id;
  _EvaluationsState(this.id);

  //this list has the same reason to be empty like lists in the home screen
  List data = [];
  final userToken = getIt<UserAccountModel>().userToken;
  Future<dynamic> fetchEvaluation() async {
    data = [];
    var response = await APIProvider().get(url: "admin/user/evaluate", params: {
      "api_token": userToken,
      "id": id,
    });
    if (response != null && response['status'] == "success") {
      print(response);
      for (var i = 0; i < response['result'].length; i++) {
        var idToString = response['result'][i]['id'].toString();
        var rateToDouble = double.parse(response['result'][i]['evaluate']);
        print(response['result'][i]['total_rate']);
        var oneThing = CommentToManage(
          name: response['result'][i]['item_name'],
          image: response['result'][i]['image'],
          evaluate: rateToDouble,
          evaluatecomment: response['result'][i]['comment'],
          deleteEvaluatePress: () => deleteEvaluate(idToString),
        );
        data.add(oneThing);
      }
      print('Evaluations data has come successfully');
    } else {
      print('no there is an error');
      String errMessage = 'Please check your data and try again';
      if (response != null && response['status'] == "error") {
        errMessage = "${response['message']}";
      }
      print(errMessage);

      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
          content: Text(errMessage,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Tajawal',
              ),
              textAlign: TextAlign.center)));
    }

    setState(() {});
  }

  Future<dynamic> deleteEvaluate(String id) async {
    var response = await APIProvider().get(url: "admin/user/remove", params: {
      "api_token": userToken,
      "id": id,
    });
    if (response != null && response['status'] == "success") {
      print(response);
      print('evaluate has been deleted');
      fetchEvaluation();
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red[900],
          content: SnackBarText("evaluate has been deleted Successfully")));
    } else {
      print(response);
      String errMessage =
          'Please check your internet connection and try again later';
      if (response != null && response['status'] == "error") {
        errMessage = "${response['message']}";
      }

      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red[900],
          content: Text(errMessage,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Tajawal',
              ),
              textAlign: TextAlign.center)));
    }

    // fetchCategories();
  }

  @override
  void initState() {
    fetchEvaluation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFF3F4F6).withOpacity(0.9),
      bottomNavigationBar: AdminNavBar(),
      appBar: buildAppBar(),
      body: Stack(children: [
        Container(
          height: height * 0.2,
          decoration: BoxDecoration(
            color: Color(0xFFEBA7AA),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: data
                  .map(
                    (itemData) => CommentToManage(
                      image: itemData.image,
                      name: itemData.name,
                      evaluatecomment: itemData.evaluatecomment,
                      evaluate: itemData.evaluate,
                      deleteEvaluatePress: itemData.deleteEvaluatePress,
                    ),
                  )
                  .toList(),
            ),
          ),
        )
      ]),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    iconTheme: IconThemeData(
      color: kPrimaryLightColor,
    ),
    backgroundColor: Color(0xFFEBA7AA),
    elevation: 0,
    title: Align(
      alignment: Alignment.topRight,
      child: Text(
        "See Evaluations",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontFamily: 'KiwiMaru',
        ),
      ),
    ),
  );
}
