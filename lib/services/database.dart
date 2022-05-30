import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:muraita_apps/services/api_path.dart';

import '../app/home/models/product.dart';

abstract class Database {

  Future<void> addListings(Product product);

}

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid}) : assert(uid != null);
  final String? uid;


  @override
  Future<void> addListings(Product product) async{
    final path = APIPath.product(uid!, 'product_abc');
    final documentReference = FirebaseFirestore.instance.doc(path);
    await documentReference.set(product.toMap());
  }
}