import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muraita_apps/screens/home_screen.dart';
import 'package:muraita_apps/signup_pages/introductory_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  late User _user;
  @override
  Widget build(BuildContext context) {
    if(_user == null){
      return IntroductoryPage();
    }
      return HomeScreen();
  }
}
