// ignore_for_file: file_names,
import 'package:flutter/material.dart';
import 'package:swifty_companion/profilePage.dart';
import 'package:swifty_companion/services/user.dart';
import 'package:swifty_companion/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key,}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _isLoading
              ? [
                  const CircularProgressIndicator(
                    strokeWidth: 2,
                  )
                ]
              : [
                  Image.asset('images/42.png'),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height / 15,
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        overlayColor:
                            MaterialStateProperty.all(Colors.grey.shade700),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        final User result = await auth();
                        if (result.user != null) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage(result)));
                        }
                      },
                      child: const Center(
                          child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                ],
        ),
      ),
    );
  }
}
