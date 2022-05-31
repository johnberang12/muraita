import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:muraita_apps/app/home/listings/add_edit_listing_page.dart';
import 'package:muraita_apps/app/home/listings/product_list_tile.dart';
import 'package:muraita_apps/app/home/models/listing.dart';
import 'package:muraita_apps/common_widgets/alert_dialog.dart';
import 'package:muraita_apps/common_widgets/exception_alert_dialog.dart';
import 'package:provider/provider.dart';
import '../../../services/auth.dart';
import '../../../services/database.dart';



class ListingsPage extends StatelessWidget {
  ListingsPage( {Key? key}) : super(key: key);


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


  // Future<void> _addListing(BuildContext context) async {
  //   try{
  //     final database = Provider.of<Database>(context, listen: false);
  //     await  database.addListing(Listing(name: 'car', price: 1500));
  //   } on FirebaseException catch(e) {
  //     showExceptionAlertDialog(
  //         context,
  //         title: 'Operation failed',
  //         exception: e
  //     );
  //   }
  // }

  Widget _buildContent(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<Iterable<Listing?>>(
      stream: database.listingsStream(),
        builder: (context,  AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData) {
          final listings = snapshot.data;
          print('snapshot data is => ${snapshot.data}');
          final children = listings.map<Widget>((listing) =>
              ProductListTile(
              listing: listing,
              onTap: () => AddEditListingPage.show(context, listing: listing)
              )).toList();
          return ListView(children: children,);
        }
        if(snapshot.hasError){
          return const Center(child: Text('Error fetching data'),);
        }
        return const Center(child: CircularProgressIndicator(),);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
  print('entered listings page');
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
      body: _buildContent(context),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> AddEditListingPage.show(context),
        child: const Icon(Icons.add),
      ),
    );
  }



}
