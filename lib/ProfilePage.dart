// ignore_for_file: file_names,
import "package:flutter/material.dart"
    show
        AlertDialog,
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
        Expanded,
        Key,
        ListView,
        MainAxisAlignment,
        MediaQuery,
        Navigator,
        NetworkImage,
        Scaffold,
        SizedBox,
        Stack,
        State,
        StatefulWidget,
        Text,
        TextButton,
        TextStyle,
        Widget,
        WillPopScope,
        showDialog;
import 'package:swifty_companion/Widgets/available.dart';
import 'package:swifty_companion/Widgets/avatar.dart';
import 'package:swifty_companion/Widgets/coalition.dart';
import 'package:swifty_companion/Widgets/Header.dart';
import 'package:swifty_companion/Widgets/level.dart';
import 'package:swifty_companion/Widgets/projects.dart';
import 'package:swifty_companion/Widgets/skills.dart';
import 'package:swifty_companion/Widgets/userInfo.dart';
import 'package:swifty_companion/services/User.dart';

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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool exitCheck = false;
        await showDialog(
            context: context,
            builder: (context) => Center(
                  child: AlertDialog(
                    title: Text(
                      'Are you sure you want to leave ?',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 40,
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text(
                          'Yes',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 40,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            exitCheck = true;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text(
                          'No',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 40,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ));
        return exitCheck;
      },
      child: Scaffold(
        // backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: _isLoading
              ? const CircularProgressIndicator(
                  backgroundColor: Color.fromARGB(64, 255, 255, 255),
                )
              : SizedBox(
                  // color: widget.userData.color.withOpacity(0.3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Header(
                        user: widget.userData,
                      ),
                      Container(
                        color: widget.userData.color.withOpacity(0.3),
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                        child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
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
                                        imageUrl: widget
                                            .userData.user['image_url']
                                            .toString(),
                                        displayName: widget
                                            .userData.user['displayname']
                                            .toString()),
                                  ),
                                  Coalition(user: widget.userData),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Level(user: widget.userData),
                            ]),
                      ),
                      Expanded(
                        // height: MediaQuery.of(context).size.height * 0.5,
                        child: Container(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          // color: Colors.black,
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
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
