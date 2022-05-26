import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muraita_apps/screens/home_screen.dart';
import 'package:muraita_apps/signup_pages/introductory_page.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import '../services/auth_provider.dart';

class LandingPage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
     return StreamBuilder<User?>(
       stream: auth.authStateChanges(),
       builder: (context, snapshot) {
         if(snapshot.connectionState == ConnectionState.active){
           final User? user = snapshot.data;
           if(user == null){
             return IntroductoryPage();
           }
           return HomeScreen();
         }
         return const Scaffold(
           body: Center(
             child: CircularProgressIndicator(),
           )
         );
       },
     );


  }
}
