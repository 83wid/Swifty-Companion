// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:swiftyCompanion/services/userScheme.dart';

class Header extends StatefulWidget {
  // const Header({Key? key,}) : super(key: key);
  @override
  State<Header> createState() => _HeaderState();
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
      width: 3 * MediaQuery.of(context).size.width / 6,
      height: MediaQuery.of(context).size.height / 10,
      child: Row(
        children: <Widget>[
          Container(
            width: 2 * MediaQuery.of(context).size.width / 6,
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

class UserInfo extends StatefulWidget {
  // const UserInfo({Key? key,}) : super(key: key);
  @override
  State<UserInfo> createState() => _UserInfoState();
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
            height: MediaQuery.of(context).size.height / 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.green.shade300, width: 2),
              color: Colors.white,
            ),
            child: Center(child: Text(user['location'].toString())),
          ),
          Container(
            // width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.green.shade300, width: 2),
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
              ],
            ),
          ),
        ],
      ),
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
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Avatar(
                  imageUrl: user['image_url'].toString(),
                  displayName: user['displayname'].toString()),
              UserInfo(),
            ]),
          )
        ],
      ),
    );
  }
}
