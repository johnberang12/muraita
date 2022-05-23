import 'package:flutter/material.dart';

class CustomPrimaryButton extends StatelessWidget {
    CustomPrimaryButton({
    Key? key,
     this.height = 45,
     this.width = double.infinity,
     this.child,
     this.onPressed,
  }) : super(key: key);

  late double? height, width;
  final Widget? child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
