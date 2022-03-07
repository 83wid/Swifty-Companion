import 'package:flutter/material.dart';
import 'package:swiftyCompanion/Widgets/Available.dart';
import 'package:swiftyCompanion/Widgets/Avatar.dart';
import 'package:swiftyCompanion/Widgets/Coalition.dart';
import 'package:swiftyCompanion/Widgets/Header.dart';
import 'package:swiftyCompanion/Widgets/Level.dart';
import 'package:swiftyCompanion/Widgets/Projects.dart';
import 'package:swiftyCompanion/Widgets/UserInfo.dart';
import 'package:swiftyCompanion/services/User.dart';

// import 'package:swiftyCompanion/services/cursus.dart';
// import 'package:tableview/tableview.dart';

class ProfilePage extends StatefulWidget {
  final userData;
  ProfilePage(
    User this.userData, {
    Key? key,
  }) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = false;
  User user = User(null, null, null);
  void initState() {
    super.initState();
    user = widget.userData;
  }
  // set userVal(User value) => setState(() => user = widget.userData);
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
                                        .userData.coalition[0]['cover_url']
                                        .toString()),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Avatar(
                                    imageUrl: user.user['image_url'].toString(),
                                    displayName:
                                        user.user['displayname'].toString()),
                              ),
                              Coalition(user: widget.userData),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Level(user: user.user),
                          const SizedBox(
                            height: 10,
                          ),
                          Available(user: user.user),
                          const SizedBox(
                            height: 10,
                          ),
                          UserInfo(user: user.user),
                          const SizedBox(
                            height: 10,
                          ),
                          Projects(user: user.user),
                        ]),
                  )
                ],
              ),
      ),
    );
  }
}
