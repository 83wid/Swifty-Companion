import 'package:swiftyCompanion/services/cursus.dart';

class Project {
  final List? projects;

  Project({
    this.projects,
  });

  Project.fromJson(Map json) : projects = json['projects_users'];
}

dynamic allProjects(user) {
  List data = Project.fromJson(user).projects ?? [];
  dynamic ret = data.where((element) =>
       element['cursus_ids'][0] ==
          getCursus(user['cursus_users'])['cursus']['id'] &&
      element['status'] == 'finished' &&
      element['project']['parent_id'] == null &&
      element['validated?'] == true);
  return ret;
}
