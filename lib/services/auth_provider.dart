import 'package:flutter/material.dart';

import 'auth.dart';

class AuthProvider extends InheritedWidget {

  //unused.....changed to general provider package.
  AuthProvider({
    required this.child,
    required this.auth,
  }) : super(child: child);
  final AuthBase auth;
  final Widget child;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static AuthBase? of(BuildContext context) {
    AuthProvider? provider = context.dependOnInheritedWidgetOfExactType<AuthProvider>();
      return provider?.auth;

  }

}