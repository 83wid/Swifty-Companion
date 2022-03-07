import 'package:flutter/material.dart';

class Available extends StatelessWidget {
  const Available({Key? key, required this.user}) : super(key: key);
  final user;
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
        border: Border.all(color: Colors.blue, width: 2),
        color: const Color(0xff292a2d),
      ),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            user['location'] != null ? 'Available' : 'UnAvailable',
            style: textStyle,
          ),
          Text(user['location'] != null ? user['location'].toString() : '_',
              style: textStyle),
        ],
      )),
    );
  }
}
