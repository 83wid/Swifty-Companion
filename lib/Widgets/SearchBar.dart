import 'package:flutter/material.dart';
import 'package:swiftyCompanion/ProfilePage.dart';
import 'package:swiftyCompanion/services/auth_service.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key? key, required this.user}) : super(key: key);
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
      width: 2 * MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.height / 12,
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 2.5,
            height: MediaQuery.of(context).size.height / 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.green.shade300, width: 2),
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
            width: MediaQuery.of(context).size.width / 100,
          ),
          SizedBox(
            // width: MediaQuery.of(context).size.width / 7,
            height: MediaQuery.of(context).size.height / 20,
            child: _isLoading
                ? const SizedBox(child: CircularProgressIndicator())
                : TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      overlayColor:
                          MaterialStateProperty.all(Colors.grey.shade700),
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
                              loginController.text, widget.user);
                          if (userData != null) {
                            Navigator.push(
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
                        }
                        else {
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
                    child: const Center(
                        child: Text(
                      'search',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
          ),
        ],
      ),
    );
  }
}
