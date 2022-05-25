import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muraita_apps/constants.dart';
import 'package:muraita_apps/signup_pages/name_registration.dart';
import 'package:muraita_apps/signup_pages/signup_widgets/signup_button.dart';
import 'package:muraita_apps/widget/error_warning.dart';
import 'package:muraita_apps/widget/inactive_button.dart';
import 'package:muraita_apps/widget/outlined_input_field.dart';

import '../screens/home_screen.dart';

class VerifyNumber extends StatefulWidget {
   VerifyNumber(
       {Key? key,
         required this.verificationCode,
         required this.verifyNumber,
       }) : super(key: key);

  late String verificationCode;
   final VoidCallback verifyNumber;

  @override
  State<VerifyNumber> createState() => _VerifyNumberState();
}
class _VerifyNumberState extends State<VerifyNumber> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late double height, width;
  late FocusNode _focus;
  final _codeController = TextEditingController();
  final String _verificationIdReceived = '';

  String _confirmationCode = '123456';
  String _inputValue = '';
  final String _errorText = 'Invalid code. Retry!';
  bool _codeIsValid = true;

  late int _seconds = 60;
  late int _minutes = 1;
  Timer? _timer;
  bool _timerIsDone = false;


  @override
  void initState(){
    super.initState();
    if(mounted){
      _startTimer();
    }
    _focus = FocusNode();
    _focus.requestFocus();
  }

  @override
  void dispose(){
    _timer?.cancel();
    super.dispose();
    _stopTimer();
  }

  void _startTimer(){
    _timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      if(!mounted) return;

      setState((){
        if(_minutes == 0 && _seconds < 1) {
          _timerIsDone = true;
          _stopTimer();
        } else {
          if(_seconds > 0){
            _seconds--;
          } else {
            _seconds = 59;
            _minutes--;
          }
        }
      });

    });
  }

  void _stopTimer(){
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width*.10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Visibility(
                visible: _codeIsValid == false,
                child: ErrorWarning(
                    height: height*.06,
                    errorText: _errorText,
                    colour: Theme.of(context).errorColor),
              ),
              SizedBox(height: height*.02,),
              OutlinedInputField(
                textAlign: TextAlign.center,
                  height: height*.06,
                focusNode: _focus,
                keyboardType: TextInputType.number,
                controller: _codeController,
                inputAction: TextInputAction.send,
                maxLength: 6,
                onChanged: (value){
                  ///TODO
                  setState((){
                    _inputValue = value;
                  });
                },
              ),
              SizedBox(height: height*.02,),

              _timerIsDone == true ?
                  SignupButton(
                      height: height*.06,
                      width: double.infinity,
                      buttonText: 'Re-send code',
                      onTap: (){

                        widget.verifyNumber();
                        setState((){
                          _seconds = 60;
                          _minutes = 1;
                          _timerIsDone = false;
                          _startTimer();
                        });

                      } ,) :
              InactiveButton(
                  height: height*.06,
                  width: double.infinity,
                  buttonText: 'Re-send code after $_minutes : $_seconds'
              ),
              SizedBox(height: height*.06,),
              _inputValue.length == 6?
              SignupButton(
                  height: height*.06,
                  width: double.infinity,
                  buttonText: 'Confirm Number',
                  onTap: (){
                   ///TODO
                    _verifyCode(smsCode: _inputValue);
                  }
              ) :
              InactiveButton(
                  height: height*.06,
                  width: double.infinity,
                  buttonText: 'Confirm Number'
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _verifyCode({required String smsCode}) async {
    if(widget.verificationCode != null){
      var credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationCode,
          smsCode: smsCode
      );
      await _auth
          .signInWithCredential(credential)
          .then((value){
              print('you are logged in successfully');
              Navigator.push(
                  context, MaterialPageRoute(
                builder: (context) => NameRegistration(),
              ));
              _codeIsValid = true;
              })
          .whenComplete((){})
          .onError((error, stackTrace){
            print(error);
            print(stackTrace);

            setState((){
              _codeController.clear();
              _codeIsValid = false;
            });

      });
    }

  }
}
