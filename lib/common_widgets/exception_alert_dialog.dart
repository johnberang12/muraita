

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muraita_apps/common_widgets/alert_dialog.dart';


Future<void>? showExceptionAlertDialog(
    BuildContext context, {
      required String title,
      required Exception exception,
}
    ) => showAlertDialog(
  context,
  title: title,
  content: _message(exception),
  defaultActionText: 'Ok',
);

String? _message(Exception exception) {
  if(exception is FirebaseException) {
    return exception.message;
  }
  return exception.toString();
}