
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muraita_apps/common_widgets/alert_dialog.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen( {Key? key,

  }) : super(key: key);






  _signOut(BuildContext context)async{
    try{
      final auth = Provider.of<AuthBase>(context, listen: false);
     await auth.signOut();

    } catch(e) {
      print(e);
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
        context,
        title: 'Logout',
        content: 'Are you sure you want to logout?',
        cancelActionText: 'Cancel',
        defaultActionText: 'Logout',
    );
    if(didRequestSignOut == true){
      _signOut(context);
    }
  }

  User? user;

  @override
  Widget build(BuildContext context) {
  print('entered home screen');
  print('this user is ${user?.displayName}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          TextButton(
            onPressed: () => _confirmSignOut(context),
            child: Text('Log out', style: TextStyle(
              color: Colors.white,
            ),),
          ),
        ],
      ),
      body: Center(
        child: Text('home screen'),
      ),
    );
  }
}
