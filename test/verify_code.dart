import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_test.dart';

class VerifyCodePage extends StatefulWidget {
   VerifyCodePage( {Key? key,
  required this.verificationId,
     required this.userNumber,

  }) : super(key: key);

  final String verificationId;
  final String userNumber;

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: (){
                  signInWithCredential();
                },
                child: const Text('Confirm Number'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> signInWithCredential()async {
    var auth = FirebaseAuth.instance;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: controller.text,
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
        controller.clear();
      });

    });
  }

}
