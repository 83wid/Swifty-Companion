//Import the client you need (see later for available clients)...
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:swifty_companion/services/user.dart';
import 'package:swifty_companion/services/coalition.dart';

dynamic checkToken(token) async {
  final String url = dotenv.env['API_URI']! + '/oauth/token/info';
  final Map<String, String> headers = {
    'Authorization': 'Bearer ${token['access_token']}',
    'Content-Type': 'application/json',
  };
  final response = await http.get(Uri.parse(url), headers: headers);
  final Map<String, dynamic> data = json.decode(response.body);
  if (response.statusCode == 200 && data['expires_in_seconds'] != 0) {
    final res =
        await http.post(Uri.parse(dotenv.env['API_URI']! + '/oauth/token'),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: json.encode({
              "grant_type": 'authorization_code',
              "client_id": dotenv.env['CLIENT_UID'], //Your client id
              "client_secret": dotenv.env['CLIENT_SECRET'], //Your client secret
              'code': token['refresh_token'],
            }));
    // print(json.decode(res.body));
    print(res.statusCode);
    print(res.body);
  } else {
    return null;
  }
}

dynamic auth() async {
  final result = await FlutterWebAuth.authenticate(
    url: dotenv.env['API_URI']! +
        "/oauth/authorize?client_id=" +
        dotenv.env['CLIENT_UID']! +
        "&redirect_uri=" +
        dotenv.env['REDIRECT_URI']! +
        "&response_type=code",
    callbackUrlScheme: "swifty.companion.app",
  );
  final res = await http
      .post(Uri.parse(dotenv.env['API_URI']! + "/oauth/token"), body: {
    "grant_type": 'authorization_code',
    "client_id": dotenv.env['CLIENT_UID'], //Your client id
    "client_secret": dotenv.env['CLIENT_SECRET'], //Your client secret
    "code": result.substring(result.indexOf('=') + 1, result.length),
    "redirect_uri": dotenv.env['REDIRECT_URI'],
  });
  final token = json.decode(res.body);
  final userData = await getUserData(null, token);
  final userCoalition = await getCoalition(userData, token);
  return User(userData, token, userCoalition,
      HexColor.fromHex((userCoalition[0]['color'])));
}

dynamic searchUserData(userId, user) async {
  print(user.token['access_token']);
  print(user.token['refresh_token']);
  // checkToken(user.token);
  if (userId != null &&
      userId.contains(RegExp(r'[A-Z]', caseSensitive: false)) == false) {
    return null;
  }
  final userData = await getUserData(userId, user.token);
  if (userData.length == 0) {
    return null;
  }
  final userCoalition = await getCoalition(userData, user.token);
  if (userCoalition == null ||
      userCoalition.length == 0 ||
      userCoalition[0] == null) {
    return User(userData, user.token, null, Colors.blue);
  }
  return User(userData, user.token, userCoalition,
      HexColor.fromHex((userCoalition[0]['color'] ?? '#000000')));
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
