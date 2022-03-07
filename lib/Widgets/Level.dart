import 'package:flutter/material.dart';
import 'package:swiftyCompanion/services/cursus.dart';

class Level extends StatefulWidget {
  const Level({Key? key, required this.user}) : super(key: key);
  final user;
  @override
  State<Level> createState() => _LevelState();
}

class _LevelState extends State<Level> {
  @override
  Widget build(BuildContext context) {
    String slevel = getCursus(widget.user['cursus_users'])['level'].toString();
    double level = double.parse(slevel);
    final textStyle = TextStyle(
      fontSize: MediaQuery.of(context).size.width / 35,
    );
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green.shade300,
          ),
          height: MediaQuery.of(context).size.height / 20,
          width:
              MediaQuery.of(context).size.width * (level - level.floor()).abs(),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue, width: 2),
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
    );
  }
}
