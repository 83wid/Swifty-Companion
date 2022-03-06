// ignore_for_file: use_key_in_widget_constructors
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:swiftyCompanion/services/cursus.dart';
import 'package:swiftyCompanion/services/projects.dart';
import 'package:swiftyCompanion/services/userScheme.dart';
import 'package:swiftyCompanion/services/cursus.dart';
// import 'package:tableview/tableview.dart';


String slevel = Cursus.fromJson(user).cursus?[0]['level'].toString() != null
    ? '${Cursus.fromJson(user).cursus?[0]['level']}'
    : '0';
double level = double.parse(slevel);

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
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                imageUrl,
              ),
            ),
          ),
        ),
        Text(displayName),
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  final TextEditingController loginController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:  2 * MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.height / 12,
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 2.5,
            height: MediaQuery.of(context).size.height / 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.green.shade300, width: 2),
              color: Colors.white,
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
      
      decoration: const BoxDecoration(
        color: Colors.white,
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
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 2),
        color: Colors.white,
      ),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(user['location'] != null ? 'Avaliable' : 'Unavaliable'),
          Text(user['location'] != null ? user['location'].toString() : '_'),
        ],
      )),
    );
  }
}

class UserInfo extends StatefulWidget {
  // const UserInfo({Key? key,}) : super(key: key);
  @override
  State<UserInfo> createState() => _UserInfoState();
}

List<DropdownMenuItem<Object>>? cursusBuild() {
  // print(Cursus.fromJson(user).cursus?.length);
  return Cursus.fromJson(user).cursus?.map((cursus) {
    return DropdownMenuItem(
      child: Text(cursus['cursus']['slug'].toString()),
      value: cursus['cursus']['id'].toString(),
    );
  }).toList();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 2),
              color: Colors.white,
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
                    Container(
                      width: MediaQuery.of(context).size.width / 6,
                      child: Text(
                        'Displayname:',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 42,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      user['displayname'].toString(),
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 100,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 6,
                      child: Text(
                        'email:',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 42,
                        ),
                      ),
                    ),
                    Text(
                      user['email'].toString(),
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 100,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 6,
                      child: Text(
                        'Wallet:',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 42,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      user['wallet'].toString(),
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 100,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 6,
                      child: Text(
                        'Cursus:',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 42,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(Cursus.fromJson(user).cursus?[0]['cursus']['slug']),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.width / 20,
                    //   child: DropdownButton(
                    //     items: cursusBuild(),
                    //     onChanged: (value) {
                    //       print(value);
                    //       // setState(() {
                    //       //   slevel = value;
                    //       // });
                    //     },
                    //     // value: user['cursus'],
                    //   ),
                    // ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 100,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 6,
                      child: Text(
                        'Grade:',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 42,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      Cursus.fromJson(user).cursus?[0]['grade'],
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget project(context, {projectName, projectGrade}) {
  // print(data.length);
  return Container(
    height: MediaQuery.of(context).size.height / 20,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(projectName),
        Text(projectGrade),
      ],
    ),
  );
}

class Projects extends StatefulWidget {
  const Projects({Key? key}) : super(key: key);
  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  final data = allProjects(1).toList();
  @override
  Widget build(BuildContext context) {
    // print(user['projects_users']);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 2),
      ),
      height: MediaQuery.of(context).size.height / 5,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: data.length,
          itemBuilder: ((context, i) => project(context,
              projectName: data[i]['project']['name'],
              projectGrade: data[i]['final_mark'].toString()))
          // project(),
          ),
    );
  }
}

class Level extends StatefulWidget {
  const Level({Key? key}) : super(key: key);
  @override
  State<Level> createState() => _LevelState();
}

class _LevelState extends State<Level> {
  @override
  Widget build(BuildContext context) {
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
            border: Border.all(color: Colors.black, width: 2),
          ),
          height: MediaQuery.of(context).size.height / 20,
          child: Center(
            child: Text(slevel.toString()),
          ),
        ),
      ],
    );
  }
}

class ProfilePage extends StatefulWidget {
  // const ProfilePage({Key? key,}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
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
                  Avatar(
                      imageUrl: user['image_url'].toString(),
                      displayName: user['displayname'].toString()),
                  const SizedBox(
                    height: 10,
                  ),
                  const Level(),
                  const SizedBox(
                    height: 10,
                  ),
                  Avaliable(),
                  const SizedBox(
                    height: 10,
                  ),
                  UserInfo(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Projects(),
                ]),
          )
        ],
      ),
    );
  }
}
