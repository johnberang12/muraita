import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:muraita_apps/app/home/listings/add_edit_listing_page.dart';
import 'package:muraita_apps/app/home/listings/product_list_tile.dart';
import 'package:muraita_apps/app/home/models/listing.dart';
import 'package:muraita_apps/common_widgets/alert_dialog.dart';
import 'package:muraita_apps/common_widgets/exception_alert_dialog.dart';
import 'package:provider/provider.dart';
import '../../../common_widgets/empty_content.dart';
import '../../../services/auth.dart';
import '../../../services/database.dart';
import 'floating_action_button.dart';
import '../../../common_widgets/list_item_builder.dart';



class ListingsPage extends StatelessWidget {
  ListingsPage( {Key? key}) : super(key: key);





  Widget _buildContent(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<Iterable<Listing?>>(
      stream: database.listingsStream(),
        builder: (context,  snapshot) {
        return ListItemBuilder<Listing>(
          snapshot: snapshot,
          itemBuilder: (context, listing) => Dismissible(
            key: Key('product-${listing?.id}'),
            background: Container(color: Theme.of(context).errorColor),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _delete(context, listing!),
            child: ProductListTile(
              listing: listing,
              onTap: () => AddEditListingPage.show(context,listing: listing),
        ),
          ),
        );
        }
    );
  }

  Future<void> _delete(BuildContext context, Listing listing) async {
    try{
      final database = Provider.of<Database>(context, listen: false);
      await database.deleteItem(listing);
    } on FirebaseException catch(e){
      showExceptionAlertDialog(
          context,
          title: 'Operation failed',
          exception: e,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
  print('entered listings page');
  print('this user is ${auth.currentUser?.displayName}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('My listings'),

      ),
      body: _buildContent(context),
      floatingActionButton: FloatingAction(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,

    );

  }



}
