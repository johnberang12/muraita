import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Future? showProgressIndicator(BuildContext context) {
//   if(!Platform.isIOS) {
//     return showDialog(
//         context: context,
//         builder: (context) => const Center(child: CircularProgressIndicator(),),
//     );
//   }
//   return showCupertinoDialog(
//       context: context,
//       builder: (context) => const Center(child: CircularProgressIndicator(),),
//   );
// }



showLoaderDialog(BuildContext context){
  AlertDialog alert=AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(margin: const EdgeInsets.only(left: 7),child:const Text("Loading..." )),
      ],),
  );
  showDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
}