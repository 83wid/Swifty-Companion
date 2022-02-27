import 'package:flutter/material.dart';
import './services/auth_service.dart';
import 'package:http/http.dart' as http;

void main() {
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
  final token = '0f12d9a236d2d28d8815e54240615b3ec9c6e6b87a0c35473c919367a15d28b3';
  TextEditingController loginController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: loginController,
              decoration: const InputDecoration(
                labelText: 'Login',
              ),
            ),
              TextButton(
                onPressed: () {
                  // getAccess();
                  http.get(Uri.parse("https://api.intra.42.fr/v2/users/" + loginController.text ), headers: {
                    "Authorization": "Bearer $token"
                  }).then((response) {
                    print(response.body);
                  });
                },
                child: const Text('Sign in anonymously'),
              ),
          ],
        ),
      ),
      );
  }
}
