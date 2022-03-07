import 'package:flutter/material.dart';
import 'package:swiftyCompanion/ProfilePage.dart';
import 'package:swiftyCompanion/Widgets/SearchBar.dart';
import 'package:swiftyCompanion/services/auth_service.dart';

class Header extends StatefulWidget {
  const Header({Key? key, required this.user}) : super(key: key);
  final user;
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
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
                final userData = await searchUserData(null, widget.user);
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
                  : Image.asset('images/42.png',
                      width: MediaQuery.of(context).size.width / 8,
                      fit: BoxFit.contain),
            ),
            SearchBar(
              user: widget.user,
            ),
          ],
        ),
      ),
    );
  }
}
