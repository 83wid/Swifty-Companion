class Cursus {
  final List? cursus;

  Cursus({
    this.cursus,
  });

  Cursus.fromJson(Map json) : cursus = json['cursus_users'];
}

dynamic getCursus(cursusUsers) {
  // print(cursusUsers);
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
