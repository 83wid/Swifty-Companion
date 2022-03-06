// ignore_for_file: use_key_in_widget_constructors
// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:swiftyCompanion/helpers/styles.dart';
import 'package:swiftyCompanion/services/User.dart';
import 'package:swiftyCompanion/services/cursus.dart';
import 'package:swiftyCompanion/services/projects.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import 'package:swiftyCompanion/services/cursus.dart';
// import 'package:tableview/tableview.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class Avatar extends StatelessWidget {
  const Avatar({Key? key, required this.imageUrl, required this.displayName})
      : super(key: key);
  final String imageUrl;
  final String displayName;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                imageUrl,
              ),
            ),
          ),
        ),
        Text(
          displayName,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 20,
          ),
        ),
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  final TextEditingController loginController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 2 * MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.height / 12,
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 2.5,
            height: MediaQuery.of(context).size.height / 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.green.shade300, width: 2),
              // color: Colors.white,
            ),
            child: TextFormField(
              controller: loginController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(10),
                border: InputBorder.none,
                hintText: 'Login',
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 100,
          ),
          SizedBox(
            // width: MediaQuery.of(context).size.width / 7,
            height: MediaQuery.of(context).size.height / 20,
            child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(Colors.black),
                overlayColor: MaterialStateProperty.all(Colors.grey.shade700),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onPressed: () async {},
              child: const Center(
                  child: Text(
                'search',
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        ],
      ),
    );
  }
}

class Header extends StatefulWidget {
  // const Header({Key? key,}) : super(key: key);
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 2.0, right: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('images/42.png',
                width: MediaQuery.of(context).size.width / 8,
                fit: BoxFit.contain),
            SearchBar(),
          ],
        ),
      ),
    );
  }
}

class Avaliable extends StatelessWidget {
  const Avaliable({Key? key, required this.user}) : super(key: key);
  final user;
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: MediaQuery.of(context).size.width / 35,
    );
    return Container(
      // width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue, width: 2),
        color: const Color(0xff292a2d),
      ),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            user['location'] != null ? 'Avaliable' : 'Unavaliable',
            style: textStyle,
          ),
          Text(user['location'] != null ? user['location'].toString() : '_',
              style: textStyle),
        ],
      )),
    );
  }
}

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key, required this.user}) : super(key: key);
  final user;
  @override
  State<UserInfo> createState() => _UserInfoState();
}

// List<DropdownMenuItem<Object>>? cursusBuild(context) {
//   // print(Cursus.fromJson(user).cursus?.length);
//   return Cursus.fromJson(user).cursus?.map((cursus) {
//     return DropdownMenuItem(
//       child: Text(cursus['cursus']['slug'].toString()),
//       value: cursus['cursus']['id'].toString(),
//     );
//   }).toList();
// }

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: MediaQuery.of(context).size.width / 35,
    );
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 100,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                  child: Text(
                    'Displayname:',
                    style: textStyle,
                  ),
                ),
                Text(
                  widget.user['displayname'].toString(),
                  style: textStyle,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 100,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                  child: Text(
                    'email:',
                    style: textStyle,
                  ),
                ),
                Text(
                  widget.user['email'].toString(),
                  style: textStyle,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 100,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                  child: Text(
                    'Wallet:',
                    style: textStyle,
                  ),
                ),
                Text(
                  widget.user['wallet'].toString(),
                  style: textStyle,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 100,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                  child: Text(
                    'Cursus:',
                    style: textStyle,
                  ),
                ),
                Text(
                  Cursus.fromJson(widget.user).cursus?[0]['cursus']['name'],
                  style: textStyle,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 100,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                  child: Text(
                    'Grade:',
                    style: textStyle,
                  ),
                ),
                Text(
                  Cursus.fromJson(widget.user).cursus?[0]['grade'],
                  style: textStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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

class Level extends StatefulWidget {
  const Level({Key? key, required this.user}) : super(key: key);
  final user;
  @override
  State<Level> createState() => _LevelState();
}

class _LevelState extends State<Level> {
  @override
  Widget build(BuildContext context) {
    String slevel =
        Cursus.fromJson(widget.user).cursus?[0]['level'].toString() != null
            ? '${Cursus.fromJson(widget.user).cursus?[0]['level']}'
            : '0';
    double level = double.parse(slevel);
    final textStyle = TextStyle(
      fontSize: MediaQuery.of(context).size.width / 35,
    );
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green.shade300,
          ),
          height: MediaQuery.of(context).size.height / 20,
          width:
              MediaQuery.of(context).size.width * (level - level.floor()).abs(),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue, width: 2),
          ),
          height: MediaQuery.of(context).size.height / 20,
          child: Center(
            child: Text(
              slevel.toString(),
              style: textStyle,
            ),
          ),
        ),
      ],
    );
  }
}

class ProfilePage extends StatefulWidget {
  final userData;
  const ProfilePage(
    User this.userData, {
    Key? key,
  }) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

Widget badge(context, user) {
  final text = user.user['staff?'] == true ? 'Staff' : 'Student';
  final color = user.user['staff?'] == true ? Colors.red : Colors.green;
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color, width: 2),
      color: color,
    ),
    width: MediaQuery.of(context).size.width / 5,
    height: MediaQuery.of(context).size.height / 20,
    child: Center(
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}

class Coalition extends StatelessWidget {
  const Coalition({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height / 15,
        // width: MediaQuery.of(context).size.width / 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 10,
              height: MediaQuery.of(context).size.height / 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: const Border(
                  bottom: BorderSide.none,
                  right: BorderSide.none,
                  left: BorderSide.none,
                  top: BorderSide.none,
                ),
                color: HexColor.fromHex((user.coalition[0]['color'])),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.network(
                      user.coalition[0]['image_url'],
                      color: Colors.white,
                      theme: const SvgTheme(currentColor: Colors.white),
                      // cacheColorFilter: true,

                      width: MediaQuery.of(context).size.width / 20,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      user.coalition[0]['name'],
                      style: TextStyle(color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width / 60),
                    ),
                  ],
                ),
              ),
            ),
            badge(context, user)
          ],
        ));
  }
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    print(widget.userData.coalition);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Header(),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(widget
                                  .userData.coalition[0]['cover_url']
                                  .toString()),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Avatar(
                              imageUrl:
                                  widget.userData.user['image_url'].toString(),
                              displayName: widget.userData.user['displayname']
                                  .toString()),
                        ),
                        Coalition(user: widget.userData),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Level(user: widget.userData.user),
                    const SizedBox(
                      height: 10,
                    ),
                    Avaliable(user: widget.userData.user),
                    const SizedBox(
                      height: 10,
                    ),
                    UserInfo(user: widget.userData.user),
                    const SizedBox(
                      height: 10,
                    ),
                    Projects(user: widget.userData.user),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
