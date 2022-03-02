import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
                // // Present the dialog to the user
                // final result = await FlutterWebAuth.authenticate(
                //   url:
                //       "https://api.intra.42.fr/oauth/authorize?client_id=99d29e146f98b61033acb008b5e121c9ce157eb1e23bead0905ad39fa0f9e2de&redirect_uri=swifty.companion.app%3A%2F%2Fcallback&response_type=code",
                //   callbackUrlScheme: "swifty.companion.app",
                // );
                // print(result);
                var client = OAuth2Client(
                  authorizeUrl: 'https://api.intra.42.fr/oauth/authorize',
                  tokenUrl: 'https://api.intra.42.fr/oauth/token',
                  redirectUri: 'swifty.companion.app://callback',
                  customUriScheme: 'swifty.companion.app',
                );
                var tknResp = await client.getTokenWithAuthCodeFlow(
                  clientId: clientId,
                  scopes: ['public'],
                );
                print(tknResp.httpStatusCode);
                print(tknResp.error);
                print(tknResp.expirationDate);
                print(tknResp.scope);
                // await http.get(Uri.parse("https://api.intra.42.fr/oauth/authorize?client_id=99d29e146f98b61033acb008b5e121c9ce157eb1e23bea
                //d0905ad39fa0f9e2de&redirect_uri=http%3A%2F%2Flocalhost%3A80&response_type=code")).then((value) => print(value.body));
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
    );
  }
}
