import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future? showProgressIndicator(BuildContext context) {
  if(!Platform.isIOS) {
    return showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator(),),
    );
  }
  return showCupertinoDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator(),),
  );
}