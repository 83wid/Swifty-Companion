import 'package:flutter/material.dart';
import 'package:swiftyCompanion/services/projects.dart';

Widget project(context, {projectName, projectGrade}) {
  // print(data.length);
  return Container(
    padding: EdgeInsets.all(MediaQuery.of(context).size.width / 100),
    height: MediaQuery.of(context).size.height / 20,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(projectName),
        Text(projectGrade, style: const TextStyle(color: Colors.green)),
      ],
    ),
  );
}

class Projects extends StatefulWidget {
  const Projects({Key? key, required this.user}) : super(key: key);
  final user;
  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  @override
  Widget build(BuildContext context) {
    final data = allProjects(widget.user).toList();
    // print(user['projects_users']);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue, width: 2),
      ),
      height: MediaQuery.of(context).size.height / 5,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: data.length,
          itemBuilder: ((context, i) => project(context,
              projectName: data[i]['project']['name'],
              projectGrade: data[i]['final_mark'].toString()))),
    );
  }
}
