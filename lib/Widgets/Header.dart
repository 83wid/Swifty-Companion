// ignore_for_file: file_names,
import 'package:flutter/material.dart';
import 'package:swifty_companion/profilePage.dart';
import 'package:swifty_companion/searchPage.dart';
import 'package:swifty_companion/services/auth_service.dart';
import 'package:swifty_companion/services/user.dart';

class Header extends StatefulWidget {
  const Header({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.user.color.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 2.0, right: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () async {
                setState(() {
                  _isLoading = true;
                });
                // widget.callback(true);
                final User userData = await searchUserData(null, widget.user);
                if (userData.user['id'] != widget.user.user['id']) {
                  setState(() {
                    _isLoading = false;
                  });
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(
                        userData,
                      ),
                    ),
                  );
                }
                setState(() {
                  _isLoading = false;
                });
                // widget.callback(false);
              },
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : Image.asset('images/42_dark.png',
                      width: MediaQuery.of(context).size.width / 8,
                      fit: BoxFit.contain),
            ),
            TextButton(
              child: Icon(
                Icons.search,
                color: widget.user.color,
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(
                    widget.user,
                  ),
                ),
              ),
            )
            // SearchBar(
            //   user: widget.user,
            // ),
          ],
        ),
      ),
    );
  }
}
