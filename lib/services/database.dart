import 'dart:async';
import 'package:muraita_apps/services/api_path.dart';
import 'package:muraita_apps/services/firestore_services.dart';
import '../app/home/models/listing.dart';

abstract class Database {

  Future<void> setListing(Listing listing);
  Stream<Iterable<Listing?>> listingsStream();
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid}) : assert(uid != null);
  final String? uid;

  final _service = FirestoreService.instance;

  @override
  Future<void> setListing(Listing listing) async {
    print('add Listing');
   await _service.setData(
  path: APIPath.listing(uid!, listing.id),
  data: listing.toMap(),
  );
  }

  @override
  Stream<Iterable<Listing?>> listingsStream() => _service.collectionStream(
      path: APIPath.listings(uid!),
      builder: (data, documentId) => Listing.fromMap(data, documentId),
  );


  }




