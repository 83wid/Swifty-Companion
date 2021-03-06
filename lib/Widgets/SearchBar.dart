// ignore_for_file: file_names,
import 'package:flutter/material.dart';
import 'package:swifty_companion/profilePage.dart';
import 'package:swifty_companion/services/auth_service.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key, required this.user}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final user;
  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController loginController = TextEditingController();
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.width / 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: widget.user.color, width: 2),
              // color: Colors.white,
            ),
            child: TextFormField(
              controller: loginController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(10),
                border: InputBorder.none,
                hintText: 'Login',
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width / 20,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width / 10,
            child: _isLoading
                ? const SizedBox(
                    width: 40, height: 100, child: CircularProgressIndicator())
                : TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(
                          widget.user.color.withOpacity(0.8)),
                      backgroundColor: MaterialStateProperty.all(
                          widget.user.color.withOpacity(0.5)),
                      overlayColor:
                          MaterialStateProperty.all(widget.user.color),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (loginController.text.isNotEmpty) {
                        setState(() {
                          _isLoading = true;
                        });
                        if (loginController.text[0]
                            .contains(RegExp(r'[A-Z]', caseSensitive: false))) {
                          final userData = await searchUserData(
                              loginController.text.toLowerCase(), widget.user);
                          if (userData != null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(
                                  userData,
                                ),
                              ),
                            );
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('User not found'),
                                    content:
                                        const Text('Please check your login'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Dismiss'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                });
                          }
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Unvalid login'),
                                  content: const Text(
                                      'Please enter valid login to search'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Dismiss'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        }
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Login is empty'),
                                content: const Text(
                                    'Please enter your login to search'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Dismiss'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      }
                      setState(() {
                        _isLoading = false;
                      });
                    },
                    child: Center(
                        child: Text(
                      'search',
                      style: TextStyle(color: widget.user.color),
                    )),
                  ),
          ),
        ],
      ),
    );
  }
}
