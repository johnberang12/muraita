import 'package:flutter/material.dart';
import  'package:firebase_auth/firebase_auth.dart';
import 'verify_code.dart';


class SignInTest extends StatefulWidget {
  const SignInTest({Key? key}) : super(key: key);

  @override
  State<SignInTest> createState() => _SignInTestState();
}

class _SignInTestState extends State<SignInTest> {
  var controller = TextEditingController();
  var userNumber = '';
  var verificationID = '';

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
                keyboardType: TextInputType.text,
              ),
              ElevatedButton(
                  onPressed: (){
                    userNumber = controller.text;
                    verifyPhoneNumber();
                  },
                  child: const Text('Confirm Number'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> verifyPhoneNumber()async{
    var _auth = FirebaseAuth.instance;
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: controller.text,
        verificationCompleted: (PhoneAuthCredential credential)async{
          await _auth.signInWithCredential(credential).then((value) {
            print('You are logged in successfully');
            print(_auth.currentUser?.uid);

          });

        },
        verificationFailed: (FirebaseAuthException exception)async{
          print('failed failed failed');
        },
        codeSent: (String verificationID, int? resendToken)async{
          verificationID == verificationID;
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => VerifyCodePage(userNumber: userNumber, verificationId: verificationID ),
          ));
        },
        codeAutoRetrievalTimeout: (String verificationID)async{}
    );
  }

}
