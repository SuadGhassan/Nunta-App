import 'package:flutter/material.dart';
import 'package:nunta_app/Admin_Screens/add_new_category.dart';
import 'package:nunta_app/Admin_Screens/edit_category.dart';
import 'package:nunta_app/Admin_Screens/components/admin_navigation_bar.dart';
import 'package:nunta_app/components/button.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/enums.dart';
import 'package:nunta_app/components/snackBar_message.dart';

import 'package:nunta_app/models/user_account_model.dart';
import 'package:nunta_app/APIProvider.dart';
import 'package:nunta_app/service_locator.dart';

class CategoriesManage extends StatefulWidget {
  const CategoriesManage({Key key}) : super(key: key);

  @override
  _CategoriesManageState createState() => _CategoriesManageState();
}

class _CategoriesManageState extends State<CategoriesManage> {
  List data = [];
  final userToken = getIt<UserAccountModel>().userToken;

  Future<dynamic> fetchCategories() async {
    data = [];
    var response = await APIProvider().get(url: "admin/category/show", params: {
      "api_token": userToken,
    });
    if (response != null && response['status'] == "success") {
      print(response);
      for (var i = 0; i < response['result'].length; i++) {
        var idToString = response['result'][i]['id'].toString();
        var name = response['result'][i]['name'];
        var image = response['result'][i]['img'];

        var oneThing = CategoryCards(id: idToString, image: image, name: name);
        data.add(oneThing);
      }
      print('categories has come successfully');
    } else {
      print('no there is an aerror');
    }

    setState(() {});
  }

  Future<dynamic> editCategories(String id, String oldName) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EditCategory(id: id, oldName: oldName);
    }));
  }

  Future<dynamic> deleteCategories(String id) async {
    var response =
        await APIProvider().get(url: "admin/category/remove", params: {
      "api_token": userToken,
      "id": id,
    });
    if (response != null && response['status'] == "success") {
      print(response);
      print('category has been deleted');
      fetchCategories();
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red[900],
          content: SnackBarText("category has been deleted Successfully")));
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
    fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFF3F4F6).withOpacity(0.9),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40, vertical: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: kButtonColor,
            ),
            width: 275,
            height: 50,
            child: TextButton(
              clipBehavior: Clip.none,
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AddNewCategory();
              })),
              child: Text(
                "Add New Category",
                style: TextStyle(color: Colors.white, fontSize: 18.5,fontFamily: 'KiwiMaru',),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          AdminNavBar(
            selectedMenu: MenuState.category,
          ),
        ],
      ),
      appBar: buildAppBar(),
      body: Stack(
        children: [
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
              child: Column(
                children: data
                    .map(
                      (catData) => CategoryCards(
                        id: catData.id,
                        name: catData.name,
                        image: catData.image,
                        pressEdit: () =>
                            editCategories(catData.id, catData.name),
                        pressDelete: () => deleteCategories(catData.id),
                      ),
                    )
                    .toList(),
              ),
            ),
          )),
        ],
      ),
    );
  }
}

class CategoryCards extends StatelessWidget {
  const CategoryCards({
    Key key,
    @required this.id,
    @required this.name,
    @required this.image,
    this.pressEdit,
    this.pressDelete,
  }) : super(key: key);

  final id;
  final name;
  final image;
  final GestureTapCallback pressEdit;
  final GestureTapCallback pressDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 5),
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kPrimaryLightColor,
      ),
      child: Column(
        children: [
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.network(
                image,
                // color: kButtonColor,
                width: 60,
                height: 80,
              ),
              SizedBox(
                width: 8,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  name,
                  style: TextStyle(color: kWordColor, fontSize: 18),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Button(
                press: pressEdit,
                text: "Edit",
                color: kWordColor.withOpacity(0.3),
              ),
              Button(
                press: pressDelete,
                text: "Delete",
                color: kPrimaryColor,
              ),
            ],
          ),
        ],
      ),
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
        "Categories Manage",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontFamily: 'KiwiMaru',
        ),
      ),
    ),
  );
}




