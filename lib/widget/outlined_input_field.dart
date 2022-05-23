import 'package:flutter/material.dart';

import '../constants.dart';

class OutlinedInputField extends StatelessWidget {
   OutlinedInputField({
    Key? key,
    required this.height,
      this.controller,
      this.keyboardType,
      this.inputAction,
     this.focusNode,
      this.labelText,
      this.onChanged,
     this.prefix,
     this.maxLength,

  }) :  assert(height != null),
        assert(controller != null),
        assert(keyboardType != null),
        assert(inputAction != null),
         super(key: key);

  final double? height;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? inputAction;
  final FocusNode? focusNode;
  final String? labelText;
  final void Function(String)? onChanged;
  final Widget? prefix;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: TextFormField(
        enableSuggestions: false,
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: inputAction,
        focusNode: focusNode,
        maxLength: maxLength,
        decoration:  InputDecoration(
          counterText: '',
          prefix: prefix,
            isDense: true,
            labelText: labelText,
            border: const OutlineInputBorder(
              borderSide:BorderSide(color: kBlack80),
            )
        ),
        onChanged: onChanged,
      ),
    );
  }
}