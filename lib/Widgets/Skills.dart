// ignore_for_file: file_names,
import 'package:flutter/material.dart';
import 'package:swifty_companion/services/cursus.dart';
import 'package:radar_chart/radar_chart.dart';
import 'dart:math';

List skillsNames = [
  'Web',
  'Adaptation & creativity',
  'Algorithms & AI',
  'Basics',
  'Company experience',
  'DB & Data',
  'Functional programming',
  'Graphics',
  'Group & interpersonal',
  'Imperative programming',
  'Network & system administration',
  'Object-oriented programming',
  'Organization',
  'Parallel programming',
  'Rigor',
  'Ruby',
  'Security',
  'Shell',
  'Technology integration',
  'Unix'
];

class Skills extends StatefulWidget {
  const Skills({Key? key, required this.user}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final user;
  @override
  _SkillsState createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  @override
  Widget build(BuildContext context) {
    List<double> skillsLevel = [
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
    ];
    final skills =
        getCursus(widget.user.user['cursus_users'])['skills'] as List<dynamic>;
        // print(getCursus(widget.user.user['cursus_users']));
    for (var element in skills) {
      if (skillsNames.contains(element['name'])) {
        // if (element['name'] == 'Adaptation & creativity') print(element['level']);
      // print(skillsNames[skillsNames.indexOf(element['name'])]);
        setState(() {
          skillsLevel[skillsNames.indexOf(element['name'])] = element['level'] / 15;
        });
      }
    }
    // print(skillsLevel);
    return Container(
      color: Colors.black.withOpacity(0.2),
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 100),
          child: Text(
            'Skills',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 35,
            ),
          ),
        ),
          Center(
            child: RadarChart(
              length: skillsNames.length,
              radius: MediaQuery.of(context).size.width / 3,
              initialAngle: -pi / 2,
              backgroundColor: Colors.grey.withOpacity(0),
              borderStroke: 2,
              borderColor: Colors.grey.shade600,
              radialStroke: 1,
              radialColor: Colors.grey.shade600,
              vertices: [
                for (int i = 0; i < skillsNames.length; i++)
                  RadarVertex(
                    radius: 10,
                    // textOffset: Offset(10, 10),
                    text: Text(
                        skillsNames[i] + '\n' + (skillsLevel[i] * 15).toStringAsFixed(2),
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
              ],
              radars: [
                RadarTile(
                  radialColor: Colors.red,
                  values: skillsLevel,
                  borderStroke: 3,
                  borderColor: widget.user.color,
                  backgroundColor: widget.user.color.withOpacity(0.4),
                ),
              ],
            ),
          ),
          SizedBox(height:  MediaQuery.of(context).size.height / 100,)
        ],
      ),
    );
  }
}

class RadarVertex extends StatelessWidget with PreferredSizeWidget {
  const RadarVertex({Key? key,
    required this.radius,
    this.text,
    this.textOffset,
  }) : super(key: key);

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
      tree = SizedBox(
        width: MediaQuery.of(context).size.width / 9,
        child: Stack(
          children: [
            tree,
            Center(
              child: text,
            )
          ],
        ),
      );
    }
    return tree;
  }
}
