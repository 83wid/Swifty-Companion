import 'package:flutter/material.dart';
import 'package:swifty_companion/Widgets/SearchBar.dart';
import 'package:swifty_companion/services/user.dart';

class SearchPage extends StatefulWidget {
  final User user;
  const SearchPage(
    this.user, {
    Key? key,
  }) : super(key: key);
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // ignore: prefer_final_fields
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset('images/42.png',
              width: MediaQuery.of(context).size.width / 3, fit: BoxFit.contain),
          Container(
            padding: EdgeInsets.all(20),
            child: SearchBar(
              user: widget.user,
            ),
          ),
        ]),
      ),
    );
  }
}
