import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
   PrimaryButton({
    Key? key,
    required this.height,
    required this.width,
    required this.buttonText,
    required this.onTap,
  }) : super(key: key);

  late double height, width;
  String buttonText;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        child: Text('$buttonText'),
        onPressed: onTap,
      ),
    );
  }
}
