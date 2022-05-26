import 'package:flutter/material.dart';

class ErrorWarning extends StatelessWidget {
  ErrorWarning({
    Key? key,
    required this.height,
    required this.errorText,
    required this.colour,
  }) : super(key: key,

  );

  final double height;
  final String errorText;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.error,
          color: colour,
          size: height,
        ),
        Text(errorText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).errorColor,
          ),),
      ],
    );
  }
}
