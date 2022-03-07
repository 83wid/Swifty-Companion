import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swiftyCompanion/services/User.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

Widget badge(context, user) {
  final text = user.user['staff?'] == true ? 'Staff' : 'Student';
  final color = user.user['staff?'] == true ? Colors.red : Colors.green;
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color, width: 2),
      color: color,
    ),
    width: MediaQuery.of(context).size.width / 5,
    height: MediaQuery.of(context).size.height / 20,
    child: Center(
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}

class Coalition extends StatelessWidget {
  const Coalition({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height / 15,
        // width: MediaQuery.of(context).size.width / 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 10,
              height: MediaQuery.of(context).size.height / 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: const Border(
                  bottom: BorderSide.none,
                  right: BorderSide.none,
                  left: BorderSide.none,
                  top: BorderSide.none,
                ),
                color: HexColor.fromHex((user.coalition[0]['color'])),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.network(
                      user.coalition[0]['image_url'],
                      color: Colors.white,
                      theme: const SvgTheme(currentColor: Colors.white),
                      // cacheColorFilter: true,

                      width: MediaQuery.of(context).size.width / 20,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      user.coalition[0]['name'],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 60),
                    ),
                  ],
                ),
              ),
            ),
            badge(context, user)
          ],
        ));
  }
}
