class Cursus {
  final List? cursus;

  Cursus({
    this.cursus,
  });

  Cursus.fromJson(Map json) : cursus = json['cursus_users'];
}

dynamic getCursus(user) {
  final cursusUsers = Cursus.fromJson(user).cursus;
  // print(cursusUsers);
  if (cursusUsers == null || cursusUsers.isEmpty) {
    return {
      'cursus': {
        'name': '-',
      },
      'grade': null,
      'level': 0.0,
      'id': 0,
      'skills': [],
    };
  }
  if (cursusUsers.length == 1) {
    return cursusUsers[0];
  }
  for (var i = 0; i < cursusUsers.length; i++) {
    if (cursusUsers[i]['cursus_id'] == 21) {
      return cursusUsers[i];
    }
  }
  if (cursusUsers[0]['cursus_id'] == 1) {
    return cursusUsers[0];
  } else {
    return cursusUsers[1];
  }
}
