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

// List<DropdownMenuItem<Object>>? cursusBuild(context) {
//   // print(Cursus.fromJson(user).cursus?.length);
//   return Cursus.fromJson(user).cursus?.map((cursus) {
//     return DropdownMenuItem(
//       child: Text(cursus['cursus']['slug'].toString()),
//       value: cursus['cursus']['id'].toString(),
//     );
//   }).toList();
// }

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: MediaQuery.of(context).size.width / 35,
    );
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: widget.user.color, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 100,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                  child: Text(
                    'Points:',
                    style: textStyle,
                  ),
                ),
                widget.user.user['correction_point'] != null
                    ? Text(
                        widget.user.user['correction_point'].toString(),
                        style: textStyle,
                      )
                    : const SizedBox(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 100,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                  child: Text(
                    'email:',
                    style: textStyle,
                  ),
                ),
                widget.user.user['email'] != null
                    ? Text(
                        widget.user.user['email'].toString(),
                        style: textStyle,
                      )
                    : const SizedBox(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 100,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                  child: Text(
                    'Wallet:',
                    style: textStyle,
                  ),
                ),
                widget.user.user['wallet'] != null
                    ? Text(
                        widget.user.user['wallet'].toString(),
                        style: textStyle,
                      )
                    : const SizedBox(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 100,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                  child: Text(
                    'Cursus:',
                    style: textStyle,
                  ),
                ),
                Text(
                  getCursus(widget.user.user['cursus_users'])['cursus']['name'],
                  style: textStyle,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 100,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                  child: Text(
                    'Grade:',
                    style: textStyle,
                  ),
                ),
                Text(
                  getCursus(widget.user.user['cursus_users'])['grade'] ?? '-',
                  style: textStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
