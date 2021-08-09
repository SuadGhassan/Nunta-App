import 'package:flutter/material.dart';
import 'package:nunta_app/components/button.dart';
import 'package:nunta_app/components/navigate_bar.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/screens/wlcome_screens/pay_and_userAccount/successfully_pay.dart';

import 'package:nunta_app/components/snackBar_message.dart';
import 'package:nunta_app/models/user_account_model.dart';
import 'package:nunta_app/service_locator.dart';
import 'package:nunta_app/APIProvider.dart';

class PaymentScreen extends StatefulWidget {
  static const routeName = '/ Payment_Page';
  final double total;
  const PaymentScreen({Key key, this.total}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState(total);
}

class _PaymentScreenState extends State<PaymentScreen> {
  double total;
  final userToken = getIt<UserAccountModel>().userToken;

  _PaymentScreenState(this.total);

  Future<dynamic> confirmCart() async {
    var response = await APIProvider().get(url: "cart/confirm", params: {
      "api_token": userToken,
    });
    if (response != null && response['status'] == "success") {
      print('Oreder Confirmed successfully');
      toFullyConfirme();
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(backgroundColor: Colors.red[900],content: SnackBarText("Order Confirmed")));
    } else {
      print('no there is an aerror');
      print(response);
      String errMessage = 'there is an aerror please try again later';
      if (response != null && response['status'] == "error") {
        errMessage = "${response['message']}";
      }
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(backgroundColor: Colors.red[900],content: SnackBarText(errMessage)));
    }
  }

  void toFullyConfirme() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SuccessfullyPay();
    }));
  }

  @override
  Widget build(BuildContext context) {
    //  final TextEditingController _controller = TextEditingController();

    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFF3F4F6).withOpacity(0.9),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kPrimaryLightColor,
        ),
        backgroundColor: Color(0xFFEBA7AA),
        elevation: 0,
        title: Align(
          alignment: Alignment.topRight,
          child: Text(
            "Payment!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontFamily: "KiwiMaru"
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigateBar(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color: Color(0xFFEBA7AA)),
            height: height * 0.15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: kWordColor,
                    offset: Offset(0, 8),
                    blurRadius: 30,
                    spreadRadius: -23,
                  ),
                ],
              ),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: height * 0.7,
              width: 400,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      Image.asset("assets/images/payment.jpeg",),
                      Text(
                        "Checkout",
                        style: TextStyle(color: kTitleColor, fontSize: 25,fontFamily: "KiwiMaru"),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Total: $total SAR",
                        style: TextStyle(color: kButtonColor, fontSize: 20,fontFamily: "KiwiMaru"),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          icon: Image.asset(
                            "assets/icons/credit cart.png",
                            height: 30,
                            width: 30,
                            color: kWordColor,
                          ),
                          hintText: "Card Number",
                          hintStyle:
                              TextStyle(color: Colors.grey.withOpacity(0.9)),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          icon: Image.asset(
                            "assets/icons/user.png",
                            height: 30,
                            width: 30,
                            color: kWordColor,
                          ),
                          hintText: " CardHandler Name",
                          hintStyle:
                              TextStyle(color: Colors.grey.withOpacity(0.9)),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          icon: Image.asset(
                            "assets/icons/noun_date.png",
                            height: 30,
                            width: 30,
                            color: kWordColor,
                          ),
                          hintText: "MM/YY",
                          hintStyle:
                              TextStyle(color: Colors.grey.withOpacity(0.9)),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            icon: Image.asset(
                              "assets/icons/cvv.png",
                              height: 40,
                              width: 35,
                              color: kWordColor,
                            ),
                            hintText: "CVV",
                            hintStyle:
                                TextStyle(color: Colors.grey.withOpacity(0.9)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Button(
                        color: kButtonColor,
                        text: "Pay",
                        press: () {
                          confirmCart();
                        },
                      ),
                       SizedBox(height: 5,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
