import 'package:flutter/material.dart';
import 'package:swiftyCompanion/services/projects.dart';

Widget project(context, {projectName, projectGrade, validated}) {
  print(validated);
  return Container(
    padding: EdgeInsets.all(MediaQuery.of(context).size.width / 100),
    height: MediaQuery.of(context).size.height / 20,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(projectName),
        Text(projectGrade,
            style: TextStyle(color: validated ? Colors.green : Colors.red)),
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
    // print(data);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue, width: 2),
      ),
      height: MediaQuery.of(context).size.height / 5,
      width: MediaQuery.of(context).size.width,
      child: data.length == 0
          ? const Center(
              child: Text(
                'No Projects',
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: data.length,
              itemBuilder: ((context, i) => project(context,
                  projectName: data[i]['project']['name'],
                  projectGrade: data[i]['final_mark'].toString(),
                  validated: data[i]['validated?']
                  ))),
    );
  }
}
