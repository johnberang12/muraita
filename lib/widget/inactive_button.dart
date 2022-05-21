import 'package:flutter/material.dart';
import 'package:muraita_apps/constants.dart';

class InactiveButton extends StatelessWidget {
  InactiveButton({
    Key? key,
    required this.height,
    required this.width,
    required this.buttonText,
    // required this.onTap,
  }) : super(key: key);

  late double height, width;
  String buttonText;
  // VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        child: Text(buttonText),
        onPressed: null,
        style: ElevatedButton.styleFrom(
          primary: kBlack40
        ),
      ),
    );
  }
}
