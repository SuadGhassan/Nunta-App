import 'package:flutter/material.dart';
import 'package:nunta_app/screens/wlcome_screens/item_details/components/comment_container.dart';

import 'package:nunta_app/components/button.dart';
import 'package:nunta_app/components/rounded_input_field.dart';
import 'package:nunta_app/constants.dart';

import 'package:nunta_app/components/snackBar_message.dart';
import 'package:nunta_app/models/user_account_model.dart';
import 'package:nunta_app/service_locator.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:nunta_app/ApiProvider.dart';

class ReviewDetails extends StatefulWidget {
  final String itemId;
  const ReviewDetails({
    Key key,
    this.itemId,
  }) : super(key: key);

  @override
  _ReviewDetailsState createState() => _ReviewDetailsState(itemId);
}

class _ReviewDetailsState extends State<ReviewDetails> {
  final commentController = TextEditingController();
  double newRate = 0;
  final userToken = getIt<UserAccountModel>().userToken;
  List reviews = [];
  String id;
  _ReviewDetailsState(this.id);

  Future<void> fetchReviews() async {
    print(id);
    reviews = [];
    final response =
        await APIProvider().get(url: 'item/evaluate', params: {'id': id});
    if (response != null && response['status'] == "success") {
      print(response);
      for (var i = 0; i < response['result'].length; i++) {
        print(response['result'][i]['total_rate']);
        var rateToDouble = double.parse(response['result'][i]['evaluate']);
        var oneThing = CommentContainer(
          test1: response['result'][i]['name'],
          networkImage: response['result'][i]['image'],
          test2: response['result'][i]['comment'],
          rate: rateToDouble,
        );
        reviews.add(oneThing);
      }
      print(reviews);

      print('reviews has come successfully');
    } else {
      print('no there is an aerror');
    }
    setState(() {});
  }

  Future<void> addReview() async {
    final response = await APIProvider().get(url: 'item/evaluate/add', params: {
      'id': id,
      'api_token': userToken,
      'evaluate': newRate * 2,
      'comment': commentController.text,
    });
    if (response != null && response['status'] == "success") {
      fetchReviews();
      print('reviews has come successfully');
      return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: SnackBarText("thank you for the Review")));
    } else {
      return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: SnackBarText("please try again later")));
    }
  }

  @override
  void initState() {
    fetchReviews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // key: Key('2'),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          // key: Key('2'),
          children: <Widget>[
            Column(
              children: reviews
                  .map(
                    (itemData) => CommentContainer(
                      networkImage: itemData.networkImage,
                      test1: itemData.test1,
                      test2: itemData.test2,
                      rate: itemData.rate / 2,
                    ),
                  )
                  .toList(),
            ),
            Column(
              children: [
                SizedBox(height: 5.0),
                Text(
                  "Add Review",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: "CormorantGaramond",
                      color: kTitleColor),
                ),
                SizedBox(height: 5.0),
                SmoothStarRating(
                  size: 20,
                  filledIconData: Icons.star,
                  halfFilledIconData: Icons.star_half,
                  defaultIconData: Icons.star_border,
                  starCount: 5,
                  allowHalfRating: true,
                  spacing: 4,
                  color: kTitleColor,
                  borderColor: kTitleColor,
                  onRated: (v) {
                    newRate = v;
                  },
                ),
                SizedBox(height: 5.0),
                RoundedInputField(
                  controllers: commentController,
                  hintText: "Comment",
                  icon: Icon(
                    Icons.add_comment,
                  ),
                  onChanged: (value) {},
                ),
                SizedBox(height: 5.0),
                Button(
                  text: "Add",
                  color: kButtonColor,
                  press: () {
                    setState(() {
                      addReview();
                    });
                  },
                ),
                SizedBox(height: 200),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
