// ignore_for_file: file_names,

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

dynamic validImageUrl(avatarUri) async {
  final response = await http.get(Uri.parse(avatarUri));
  return response.statusCode;
}

class Avatar extends StatefulWidget {
  const Avatar({Key? key, required this.imageUrl, required this.displayName})
      : super(key: key);
  final String imageUrl;
  final String displayName;
  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  bool validUrl = false;
  @override
  void initState() {
    validImageUrl(widget.imageUrl).then(
      (value) => setState(() {
        validUrl = value == 200;
      }),
    );
    super.initState();
  }

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
            image: validUrl == true
                ? DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.imageUrl
                        // 'https://pbs.twimg.com/profile_images/923557898218889216/g4BH7Arj.jpg',
                        ))
                : const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/default_avatar.jpg'),
                  ),
          ),
        ),
        Text(
          widget.displayName,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 20,
          ),
        ),
      ],
    );
  }
}
