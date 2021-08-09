import 'package:flutter/foundation.dart';

class Item {
  final String id;
  final String title;
  final String image;
  final String categoryIds;
  final double rate;

  const Item(
      {@required this.categoryIds,
      @required this.id,
      @required this.title,
      @required this.rate,
      this.image});
}
