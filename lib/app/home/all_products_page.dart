import 'package:flutter/material.dart';
import 'package:muraita_apps/app/home/models/product.dart';
import 'package:muraita_apps/common_widgets/alert_dialog.dart';
import 'package:provider/provider.dart';
import '../../services/auth.dart';
import '../../services/database.dart';



class AllProductsPage extends StatelessWidget {
  AllProductsPage( {Key? key}) : super(key: key);






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


  Future<void> _addListings(BuildContext context) async {
    final database = Provider.of<Database>(context, listen: false);
  await  database.addListings(Product(name: 'bag', price: 100));
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
  print('entered home screen');
  print('this user is ${auth.currentUser?.displayName}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          TextButton(
            onPressed: () => _confirmSignOut(context),
            child: const Text('Log out', style: TextStyle(
              color: Colors.white,
            ),),
          ),
        ],
      ),
      body: const Center(
        child: Text('home screen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> _addListings(context),
        child: const Icon(Icons.add),
      ),
    );
  }



}
