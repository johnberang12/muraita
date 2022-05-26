import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeTest extends StatefulWidget {
  const HomeTest({Key? key}) : super(key: key);

  @override
  State<HomeTest> createState() => _HomeTestState();
}

class _HomeTestState extends State<HomeTest> {

  FirebaseAuth  auth = FirebaseAuth.instance;

  var nameController = TextEditingController();
  Future<void> signout()async{
    await auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    print(auth.currentUser?.uid);
    print(auth.currentUser);
    return  Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          TextButton(
              onPressed: (){
                setState((){
                  signout();
                });

              },
              child: const Text('Logout',
                style: TextStyle(
                  color: Colors.white,
                ),))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text('home page'),
            TextFormField(
              controller: nameController,
            ),
            ElevatedButton(
                onPressed: (){
                  auth.currentUser?.updateDisplayName(nameController.text);
                },
                child: const Text('update name')),
          ],
        ),
      ),
    );
  }
}
