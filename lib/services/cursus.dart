class Cursus {
  final List? cursus;

  Cursus({
    this.cursus,
  });

  Cursus.fromJson(Map json) : cursus = json['cursus_users'];
}

dynamic getCursus(cursusUsers) {
  // print(cursusUsers);
  var cursus;
  if (cursusUsers.length == 1) {
    cursus = cursusUsers[0];
  }
  else if (cursusUsers[0] != null && (cursusUsers[0]['cursus_id'] == 1 || cursusUsers[0]['cursus_id'] == 21)) {
    cursus = cursusUsers[0];
  } else {
    cursus = cursusUsers[1];
  }
  return cursus;
}
