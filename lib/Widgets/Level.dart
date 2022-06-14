// ignore_for_file: file_names,
import 'package:flutter/material.dart';
import 'package:swifty_companion/services/cursus.dart';
import 'package:swifty_companion/services/User.dart';

class Level extends StatefulWidget {
  const Level({Key? key, required this.user}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final User user;
  @override
  State<Level> createState() => _LevelState();
}

class _LevelState extends State<Level> {
  @override
  Widget build(BuildContext context) {
    String slevel =
        getCursus(widget.user.user)['level'].toString();
    double level = double.parse(slevel);
    final textStyle = TextStyle(
      fontSize: MediaQuery.of(context).size.width / 35,
    );
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black.withOpacity(0.2),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: widget.user.color.withOpacity(0.4),
            ),
            height: MediaQuery.of(context).size.height / 20,
            width: MediaQuery.of(context).size.width *
                (level - level.floor()).abs(),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: widget.user.color, width: 2),
            ),
            height: MediaQuery.of(context).size.height / 20,
            child: Center(
              child: Text(
                slevel.toString(),
                style: textStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
