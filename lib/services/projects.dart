import 'package:swifty_companion/services/cursus.dart';

class Project {
  final List? projects;

  Project({
    this.projects,
  });

  Project.fromJson(Map json) : projects = json['projects_users'];
}

dynamic allProjects(user) {
  List data = Project.fromJson(user).projects ?? [];
  if (data.isEmpty) {
    return [];
  }
  dynamic ret = data.where((element) =>
      element['cursus_ids'].length != 0 &&
      element['cursus_ids'][0] ==
          getCursus(user)['cursus']['id'] &&
      element['status'] == 'finished' &&
      element['project']['parent_id'] == null &&
      element['validated?'] != null);
  if (ret.isEmpty) return [];
  return ret;
}
