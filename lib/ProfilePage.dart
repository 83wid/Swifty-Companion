// ignore_for_file: file_names,
import "package:flutter/material.dart"
    show
        BoxDecoration,
        BoxFit,
        BuildContext,
        Center,
        CircularProgressIndicator,
        Color,
        Column,
        Container,
        DecorationImage,
        EdgeInsets,
        Key,
        ListView,
        MainAxisAlignment,
        MediaQuery,
        NetworkImage,
        Padding,
        Scaffold,
        SizedBox,
        Stack,
        State,
        StatefulWidget,
        Widget;
import 'package:swifty_companion/Widgets/available.dart';
import 'package:swifty_companion/Widgets/avatar.dart';
import 'package:swifty_companion/Widgets/coalition.dart';
import 'package:swifty_companion/Widgets/Header.dart';
import 'package:swifty_companion/Widgets/level.dart';
import 'package:swifty_companion/Widgets/projects.dart';
import 'package:swifty_companion/Widgets/skills.dart';
import 'package:swifty_companion/Widgets/userInfo.dart';
import 'package:swifty_companion/services/user.dart';

class ProfilePage extends StatefulWidget {
  final User userData;
  const ProfilePage(
    this.userData, {
    Key? key,
  }) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // ignore: prefer_final_fields
  bool _isLoading = false;
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator(
                backgroundColor: Color.fromARGB(64, 255, 255, 255),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Header(
                    user: widget.userData,
                  ),
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
                                                    .userData.coalition !=
                                                null &&
                                            widget.userData.coalition[0]
                                                    ['cover_url'] !=
                                                null
                                        ? widget.userData.coalition[0]
                                            ['cover_url']
                                        : 'https://cdn.intra.42.fr/coalition/cover/69/federation_background.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Avatar(
                                    imageUrl: widget.userData.user['image_url'].toString(),
                                    displayName:
                                        widget.userData.user['displayname'].toString()),
                              ),
                              Coalition(user: widget.userData),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Level(user: widget.userData),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: ListView(
                              shrinkWrap: true,
                              // physics: NeverScrollableScrollPhysics(),
                              children: [
                                Available(user: widget.userData),
                                const SizedBox(
                                  height: 10,
                                ),
                                UserInfo(user: widget.userData),
                                const SizedBox(
                                  height: 10,
                                ),
                                Projects(user: widget.userData),
                                const SizedBox(
                                  height: 10,
                                ),
                                Skills(user: widget.userData),
                              ],
                            ),
                          ),
                        ]),
                  )
                ],
              ),
      ),
    );
  }
}
