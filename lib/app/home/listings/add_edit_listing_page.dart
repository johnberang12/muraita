import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:muraita_apps/common_widgets/exception_alert_dialog.dart';
import 'package:provider/provider.dart';

import '../../../services/database.dart';
import '../models/listing.dart';

class AddEditListingPage extends StatefulWidget {
  const AddEditListingPage({Key? key, required this.database, this.listing}) : super(key: key);
  final Database database;
  final Listing? listing;

  static Future<void> show(BuildContext context, {Listing? listing}) async {
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddEditListingPage(database: database, listing: listing,),
        fullscreenDialog: true,
      )
    );
  }

  @override
  State<AddEditListingPage> createState() => _AddEditListingPageState();
}

class _AddEditListingPageState extends State<AddEditListingPage> {
  final _formKey = GlobalKey<FormState>();

  late String _name = '';
   late int? _price = null;


   @override
   void initState(){
     super.initState();
     if(widget.listing != null) {
     _name = widget.listing!.name;
     _price = widget.listing!.price;
     }
  }

  bool _validateAndSaveForm(){
    final form = _formKey.currentState;
    if(form!.validate()){
      form.save();
      print('validate true');
      ///TODO: implement snackBar to notify user if saved or not.
      ///Add focus node and loading functionalities.
      return true;

    }
    print('validate false');
    return false;
  }

  Future<void> _submit() async {
    if(_validateAndSaveForm()){
      try{
        final id = widget.listing?.id ?? documentIdFromCurrentDate();
        final listing = Listing(id: id, name: _name, price: _price);
        print(_name);
        print(_price);
        await widget.database.setListing(listing);
        Navigator.pop(context);
      } on FirebaseException catch(e){
        showExceptionAlertDialog(
            context,
            title: 'Operation failed',
            exception: e
        );
      }

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.listing == null ? 'Post Item' : 'Edit Item'),
        actions: <Widget>[
          ElevatedButton(
              onPressed: _submit,
              child: const Text('Save', style: TextStyle(fontSize: 18, color:  Colors.white),)
          ),
        ],
      ),
      body: _buildContents(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContents(){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(){
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren(){
    return [
      TextFormField(
        decoration: const InputDecoration(labelText: 'Product name'),
        initialValue: _name,
        validator: (value) => value != null ? null : 'Name can\'t be empty',
        onSaved: (value) => _name = value!,
      ),
      TextFormField(
          decoration: const InputDecoration(labelText: 'Price'),
        initialValue: widget.listing != null ? _price.toString() : null,
        keyboardType: const TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (value) => _price = int.tryParse(value!)!,
      ),
    ];
  }

}
