// ignore_for_file: file_names,
import 'package:flutter/material.dart';
import 'package:swifty_companion/services/user.dart';
import 'package:swifty_companion/services/cursus.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: widget.user.color, width: 2),
          color: Colors.black.withOpacity(0.2)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            item(context, 'Wallet:',
                widget.user.user['wallet'].toString() + '₳'),
            item(context, 'Correction points:',
                widget.user.user['correction_point']),
            item(context, 'Cursus:',
                getCursus(widget.user.user['cursus_users'])['cursus']['name']),
            item(context, 'Grade:',
                getCursus(widget.user.user['cursus_users'])['grade'] ?? '-'),
            item(context, 'Email:', widget.user.user['email']),
          ],
        ),
      ),
    );
  }
}

Widget item(context, String title, dynamic value) {
  final textStyle = TextStyle(
    fontSize: MediaQuery.of(context).size.width / 35,
  );
  return Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width / 50),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // SizedBox(
        //   width: MediaQuery.of(context).size.width / 100,
        // ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: Text(
            title,
            style: textStyle,
          ),
        ),
        value != null
            ? Text(
                value.toString(),
                style: textStyle,
              )
            : const SizedBox(),
      ],
    ),
  );
}
