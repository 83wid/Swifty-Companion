//Import the client you need (see later for available clients)...
import 'package:flutter/material.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:swifty_companion/services/user.dart';
import 'package:swifty_companion/services/coalition.dart';

class MyClient extends OAuth2Client {
  MyClient({required String redirectUri, required String customUriScheme})
      : super(
            authorizeUrl: 'https://api.intra.42.fr'
                '/oauth/authorize', //Your service's authorization url
            tokenUrl: 'https://api.intra.42.fr'
                '/oauth/token', //Your service access token url
            redirectUri: redirectUri,
            customUriScheme: customUriScheme);
}

Future<AccessTokenResponse> getAccess(token) async {
//Instantiate the client
  if (token.accessToken != null && token.isExpired() == false) {
    return token;
  }
  // print(token);
  final client = MyClient(
      redirectUri: 'swifty.companion.app://callback',
      customUriScheme: 'swifty.companion.app');

// Request a token using the Client Credentials flow...
  AccessTokenResponse tknResp = await client.getTokenWithClientCredentialsFlow(
      clientId:
          '99d29e146f98b61033acb008b5e121c9ce157eb1e23bead0905ad39fa0f9e2de', //Your client id
      clientSecret: 'df45d3f521600600b726ef26338ace26095d96f348cd91cd0dbcdd10cae681af', //Your client secret
      scopes: ['public'] //Optional
      );
  return tknResp;
//Or, if you already have a token, check if it is expired and in case refresh it...
// if(tknResp.isExpired()) {
// 	tknResp = client.refreshToken(tknResp.refreshToken) ?? '';
// }
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
  // print();
  final token = json.decode(res.body);
  final userData = await getUserData(null, token);
  final userCoalition = await getCoalition(userData, token);
  return User(userData, token, userCoalition,
      HexColor.fromHex((userCoalition[0]['color'])));
}

dynamic searchUserData(userId, user) async {
  if (userId != null &&
      userId.contains(RegExp(r'[A-Z]', caseSensitive: false)) == false) {
    return null;
  }
  final userData = await getUserData(userId, user.token);
  if (userData.length == 0) {
    return null;
  }
  final userCoalition = await getCoalition(userData, user.token);
  if (userCoalition.length == 0) {
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
