import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:muraita_apps/src/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}



