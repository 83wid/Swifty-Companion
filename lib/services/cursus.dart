class Cursus {
  final List? cursus;

  Cursus({
    this.cursus,
  });

  Cursus.fromJson(Map json)
        :cursus = json['cursus_users'];
}