
import 'package:flutter/material.dart';
import 'package:muraita_apps/constants.dart';

import 'add_edit_listing_page.dart';

class FloatingAction extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          child: FloatingActionButton(
            onPressed: () => AddEditListingPage.show(context),
            backgroundColor: kPrimaryHue,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}