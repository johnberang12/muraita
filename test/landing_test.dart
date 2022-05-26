import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_test.dart';
import 'signin_test.dart';

class LandingTest extends StatefulWidget {
  const LandingTest({Key? key}) : super(key: key);

  @override
  State<LandingTest> createState() => _LandingTestState();
}

class _LandingTestState extends State<LandingTest> {

  User? _user;

  @override
  void initState(){
    super.initState();
    _updateUser(FirebaseAuth.instance.currentUser);
  }

  void _updateUser(User? user){
    setState((){
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_user == null){
      return SignInTest();
    }
    return HomeTest();
  }
}
