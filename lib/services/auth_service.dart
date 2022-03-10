//Import the client you need (see later for available clients)...
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:swiftyCompanion/services/User.dart';
import 'package:swiftyCompanion/services/coalition.dart';

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

//https://api.intra.42.fr/oauth/token/info
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
    url:
        "https://api.intra.42.fr/oauth/authorize?client_id=99d29e146f98b61033acb008b5e121c9ce157eb1e23bead0905ad39fa0f9e2de&redirect_uri=swifty.companion.app%3A%2F%2Fcallback&response_type=code",
    callbackUrlScheme: "swifty.companion.app",
  );
  // print(result);
  // print(result.substring(result.indexOf('=') + 1, result.length));
  final res =
      await http.post(Uri.parse("https://api.intra.42.fr/oauth/token"), body: {
    "grant_type": 'authorization_code',
    "client_id":
        '99d29e146f98b61033acb008b5e121c9ce157eb1e23bead0905ad39fa0f9e2de', //Your client id
    "client_secret":
        'df45d3f521600600b726ef26338ace26095d96f348cd91cd0dbcdd10cae681af', //Your client secret
    "code": result.substring(result.indexOf('=') + 1, result.length),
    "redirect_uri": 'swifty.companion.app://callback',
  });
  final token = json.decode(res.body);
  final userData = await getUserData(null, token);
  final userCoalition = await getCoalition(userData, token);
  return User(userData, token, userCoalition);
}

dynamic searchUserData(userId, user) async {
  if (userId != null && userId.contains(RegExp(r'[A-Z]', caseSensitive: false)) == false) {
    return null;
  }
  final userData = await getUserData(userId, user.token);
  if (userData.length == 0) {
    return null;
  }
  final userCoalition = await getCoalition(userData, user.token);
  if (userCoalition.length == 0) {
    return User(userData, user.token, null);
  }
  return User(userData, user.token, userCoalition);
}
