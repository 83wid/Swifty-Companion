import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:swiftyCompanion/ProfilePage.dart';
import 'package:swiftyCompanion/services/User.dart';
import 'package:swiftyCompanion/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  // const LoginPage({Key? key,}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

const clientId =
    '99d29e146f98b61033acb008b5e121c9ce157eb1e23bead0905ad39fa0f9e2de';

// var client = OAuth2Client(
//   authorizeUrl: <YOUR_AUTHORIZE_URL>,
//   tokenUrl: <YOUR_TOKEN_URL>,
//   redirectUri: <YOUR_REDIRECT_URI>,
//   customUriScheme: <YOUR_CUSTOM_SCHEME>);

// var tknResp = await client.getTokenWithAuthCodeFlow(
//   clientId: <YOUR_CLIENT_ID>,
//   scopes: [
// 	  <LIST_OF_SCOPES>
//   ]);

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/42.png'),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height / 15,
              // height: MediaQuery.of(context).size.height / 20,
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  overlayColor: MaterialStateProperty.all(Colors.grey.shade700),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () async {
                  // Present the dialog to the user
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
