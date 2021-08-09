import 'package:flutter/material.dart';
import 'package:nunta_app/constants.dart';
import 'package:nunta_app/screens/wlcome_screens/home_page/copmonents/searchbar_page.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key key,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _filter =
      TextEditingController(); // controls the text label we use as a search bar
  String _searchText = "";
  // final searchController = TextEditingController();

  Icon _searchIcon = new Icon(Icons.search);

  void searchOnPressed(_searchText) {
    if (this._searchIcon.icon == Icons.search) {
      this._searchIcon = new Icon(Icons.close);
      _searchText = _filter.text;
      _filter.text = "";
      print("i searched for :  $_searchText");
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SearchbarPage(searchbarText: _searchText);
      }));
    } else {
      this._searchIcon = new Icon(Icons.search);
      _searchText = "";
      _filter.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(22)),
      child: TextField(
        controller: _filter,
        onSubmitted: (_) => searchOnPressed(_searchText),
        decoration: InputDecoration(
            hintText: "Search for...",
            hintStyle: TextStyle(color: kWordColor.withOpacity(0.7),fontFamily: "KiwiMaru"),
            icon: Icon(
              Icons.search,
              color: kButtonColor,
            ),
            border: InputBorder.none),
      ),
    );
  }
}
