import 'package:flutter/material.dart';
import 'package:muraita_apps/widget/custom_primary_button.dart';

class SignupButton extends CustomPrimaryButton {
  SignupButton({
     required double? height,
     required double? width,
    required String? buttonText,
    required VoidCallback? onTap,
}) :  assert(buttonText != null),
      // assert(onTap != null),

        super (
    child: Text(
      '$buttonText',
    ),
    height: height,
    width: width,
    onPressed: onTap,
  );
}