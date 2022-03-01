import 'package:flutter/material.dart';
import 'package:swiftyCompanion/LoginPage.dart';
import 'package:swiftyCompanion/ProfilePage.dart';
import './services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:oauth2_client/access_token_response.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AccessTokenResponse token = AccessTokenResponse();
  TextEditingController loginController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoginPage(),
            // ProfilePage(),
            // TextFormField(
            //   controller: loginController,
            //   decoration: const InputDecoration(
            //     labelText: 'Login',
            //   ),
            // ),
            //   TextButton(
            //     onPressed: () async {
            //       final access = await getAccess(token);
            //       setState(() {
            //         token = access;
            //       });
            //       // print(token.accessToken);
            //       http.get(Uri.parse("https://api.intra.42.fr/v2/users/" + loginController.text ), headers: {
            //         "Authorization": "Bearer ${token.accessToken}"
            //       }).then((response) {
            //         // final List data = [];
            //         // data.add(response.body);
            //         // print(token.accessToken);
            //       });
            //     },
            //     child: const Text('Sign in anonymously'),
            //   ),
          ],
        ),
      ),
    );
  }
}
