import 'package:flutter/material.dart';

import '../models/listing.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({Key? key, required this.listing, required this.onTap}) : super(key: key);
  final Listing? listing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(listing!.name),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
