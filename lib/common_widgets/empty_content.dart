
import 'package:flutter/material.dart';
import 'package:muraita_apps/constants.dart';
///////////Generic Custom Widget/////////////////
class EmptyContent extends StatelessWidget {
  const EmptyContent({
    Key? key,
  this.title = 'Empty list',
    this.message = 'Add a new product',
  }) : super(key: key);
  final String? title;
  final String? message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title!,
            style: const TextStyle(fontSize: 32, color: kBlack60),
          ),
          Text(
            message!,
            style: const TextStyle(fontSize: 16, color: kBlack60),
          ),
        ],
      ),
    );
  }
}
