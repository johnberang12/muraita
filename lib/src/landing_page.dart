import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muraita_apps/services/database.dart';
import 'package:provider/provider.dart';
import '../app/home/home_page.dart';
import '../app/home/listings/listings_page.dart';
import '../app/sign_in/introductory_page.dart';
import '../app/sign_in/name_registration.dart';
import '../services/auth.dart';

class LandingPage extends StatelessWidget {


  final GlobalKey _landingScaffold = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
     return StreamBuilder<User?>(
       stream: auth.authStateChanges(),
       builder: (context, snapshot) {
         if(snapshot.connectionState == ConnectionState.waiting){
           return Scaffold(
             key: _landingScaffold,
               body: const Center(child: CircularProgressIndicator(),));
         } else {
           final User? user = snapshot.data;
           final name = user?.displayName;
           print('entered landing page');
           print('this user is => ${user?.displayName}');
           if(name != null && name.length > 3){
             return Provider<Database>(
                 create: (_) => FirestoreDatabase(uid: user?.uid),
                 child: const HomePage(),
             );
           } else {
             if(user == null) {
               return IntroductoryPage.create(context);
             }
             return NameRegistration.create(context);
           }
         }
       },
     );


  }
}
