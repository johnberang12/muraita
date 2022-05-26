import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_test.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key,
  required this.verificationID,
  }) : super(key: key);

  final String verificationID;
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  var numberController = TextEditingController();

  Future<void> signInWithCredential()async {
    var auth = FirebaseAuth.instance;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationID,
        smsCode: numberController.text,
    );
    auth.signInWithCredential(credential)
        .then((value){
          print('signed in successfully');
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => HomeTest(),
      ));
    })
        // .whenComplete((){print('whenCompleted whenCompleted');})
        .onError((error, stackTrace){
      print(error);
      print('error error error error');
      setState((){
        numberController.clear();
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: numberController,
            ),
            ElevatedButton(
                onPressed: (){
                 signInWithCredential();

                },
                child: Text('SignIn')),
          ],
        ),
      ),
    );
  }
}
