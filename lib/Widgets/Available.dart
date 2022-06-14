// ignore_for_file: file_names,
import 'package:flutter/material.dart';
import 'package:swifty_companion/services/User.dart';

class Available extends StatelessWidget {
  const Available({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: MediaQuery.of(context).size.width / 35,
    );
    return Container(
      // width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: user.color, width: 2),
        color: const Color(0xff292a2d).withOpacity(0.4),
      ),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            user.user['location'] != null ? 'Available' : 'UnAvailable',
            style: textStyle,
          ),
          Text(user.user['location'] != null ? user.user['location'].toString() : '_',
              style: textStyle),
        ],
      )),
    );
  }
}
