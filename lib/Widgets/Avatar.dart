import 'package:flutter/material.dart';

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