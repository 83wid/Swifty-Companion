import 'package:http/http.dart' as http;
import 'dart:convert';

dynamic getCoalition(user, token) async {
  final res = await http.get(
      Uri.parse("https://api.intra.42.fr/v2/users/${user['id']}/coalitions"),
      headers: {"Authorization": "Bearer ${token['access_token']}"});
  return jsonDecode(res.body);
}

dynamic getUserData(userId, token) async {
  if (userId != null) {
    final res = await http.get(
        Uri.parse("https://api.intra.42.fr/v2/users/$userId"),
        headers: {"Authorization": "Bearer ${token['access_token']}"});
        // print(token['access_token']);
    return jsonDecode(res.body);
  } else {
    final res = await http.get(Uri.parse("https://api.intra.42.fr/v2/me"),
        headers: {"Authorization": "Bearer ${token['access_token']}"});
    return jsonDecode(res.body);
  }
}
