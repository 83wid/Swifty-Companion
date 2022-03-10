import 'package:flutter/material.dart';
import 'package:swiftyCompanion/services/cursus.dart';
import 'package:radar_chart/radar_chart.dart';
import 'dart:math';
// import 'package:flutter_radar_chart/flutter_radar_chart.dart';

List<List<num>> serializeLevel(List levels) {
  List<List<num>> serializedLevel = [];
  for (int i = 0; i < levels.length; i++) {
    List<num> l = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    l[i] = levels[i];
    serializedLevel.add(l);
  }
  return serializedLevel;
}

class Skills extends StatefulWidget {
  Skills({Key? key, required this.user}) : super(key: key);
  final user;
  @override
  _SkillsState createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  @override
  Widget build(BuildContext context) {
    final skills =
        getCursus(widget.user['cursus_users'])['skills'] as List<dynamic>;
    final skillNames = List<String>.from(skills.map((skill) => skill['name']));
    List<double> list1 =
        List<double>.from(skills.map((skill) => skill['level'] / 10));
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: 
        RadarChart(
          length: list1.length,
          radius: MediaQuery.of(context).size.width / 3.5,
          initialAngle : pi / 2,
          backgroundColor: Colors.grey.shade800,
          // borderStroke: 10,
          borderColor: Colors.blue,
          radialStroke: 1,
          radialColor: Colors.blue,
          vertices: [
            for (int i = 0; i < skillNames.length; i++)
              RadarVertex(
                radius: 10,
                // textOffset: Offset(10, 10),
                text: Text(skillNames[i] + '\n' + (list1[i] * 21).toStringAsFixed(2),
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
          ],
          radars: [
            RadarTile(
              radialColor: Colors.red,
              values: list1,
              borderStroke: 2,
              borderColor: Colors.yellow,
              backgroundColor: Colors.green.withOpacity(0.4),
            ),
          ],
        ),
      ),
    );
  }
}

class RadarVertex extends StatelessWidget with PreferredSizeWidget {
  const RadarVertex({
    required this.radius,
    this.text,
    this.textOffset,
  });

  final double radius;
  final Widget? text;
  final Offset? textOffset;

  @override
  Size get preferredSize => Size.fromRadius(radius);

  @override
  Widget build(BuildContext context) {
    Widget tree = CircleAvatar(
      radius: radius,
      backgroundColor: Colors.green.withOpacity(0),
    );
    if (text != null) {
      tree = Stack(
        children: [
          tree,
          Center(
            child: text,
          )
        ],
      );
    }
    return tree;
  }
}
