import 'package:flutter/material.dart';

import '../constants.dart';

class AppIcon extends StatelessWidget {
   AppIcon({
    Key? key,
    required this.avatarHeight,
     required this.initialHeight,

  }) : super(key: key);

  late double avatarHeight, initialHeight;


  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: avatarHeight,
      backgroundColor: kPrimaryHue,
      child: Text('m',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: initialHeight,
        color: Colors.white,
      ),
      ),
    );
  }
}
