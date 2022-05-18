import 'package:flutter/material.dart';
import 'package:muraita_apps/constants.dart';

import '../signup_pages/introductory_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Muraita App',
      theme: ThemeData(

        primarySwatch: Colors.amber,
      ),
      home:  IntroductoryPage(),
    );
  }
}