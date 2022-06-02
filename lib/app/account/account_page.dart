import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/alert_dialog.dart';
import '../../services/auth.dart';
import '../home/listings/listings_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);


  Future<void> _signOut(BuildContext context)async{
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My account'),
        actions: [
          TextButton(
            onPressed: () => _confirmSignOut(context),
            child: const Text('Log out', style: TextStyle(
              color: Colors.white,
            ),),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: () => Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => ListingsPage(),
          ),
      ),
                child: Text('My listings')
            ),
          ],
        ),
      ),
    );
  }
}
