//Import the client you need (see later for available clients)...
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


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
checkToken() async {}
Future<AccessTokenResponse> getAccess(token) async {
//Instantiate the client
  if (token.accessToken != null && token.isExpired() == false) {
    return token;
  }
  print(token);
  final client = MyClient(
      redirectUri: 'com.example.app', customUriScheme: 'com.example.app');

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
