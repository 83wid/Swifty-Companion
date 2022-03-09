import 'package:flutter/material.dart';
import 'package:swiftyCompanion/services/cursus.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';

class Skills extends StatefulWidget {
  Skills({Key? key, required this.user}) : super(key: key);
  final user;
  @override
  _SkillsState createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  @override
  Widget build(BuildContext context) {
  final Skills = getCursus(widget.user['cursus_users'])['skills'] as List<dynamic>;
  final skillNames = List<String>.from(Skills.map((skill) => skill['name']));
  final List<List<num>> skillLevel = [List<num>.from(Skills.map((skill) => skill['level']))];
    return Container(
      height: MediaQuery.of(context).size.height / 10,
      child: RadarChart.dark(
                      ticks: [1, 2, 3, 4, 5],
                      features: skillNames,
                      data: skillLevel,
                      reverseAxis: true,
                      // useSides: useSides,
                    ),
    );
  }
}
