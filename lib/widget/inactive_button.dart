import 'package:flutter/material.dart';
import 'package:muraita_apps/constants.dart';

class InactiveButton extends StatelessWidget {
  InactiveButton({
    Key? key,
    required this.height,
    required this.width,
    required this.buttonText,
  }) : super(key: key);

  late double height, width;
  String buttonText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          primary: kPrimaryTint40
        ),
        child: Text(buttonText),
      ),
    );
  }
}
