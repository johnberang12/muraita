import 'package:flutter/material.dart';
import 'package:muraita_apps/constants.dart';
import 'package:muraita_apps/src/landing_page.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';


class MyApp extends StatelessWidget {
   MyApp({Key? key, }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'Muraita App',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          textTheme:  TextTheme(
            headline1: TextStyle(color: kBlack80),
            headline2: TextStyle(color: kBlack80),
            bodyText2: TextStyle(color: kBlack60),

          ),

        ),
        home:  LandingPage(),
      ),
    );
  }
}