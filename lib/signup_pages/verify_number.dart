import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muraita_apps/constants.dart';
import 'package:muraita_apps/signup_pages/signup_widgets/signup_button.dart';
import 'package:muraita_apps/widget/inactive_button.dart';

import '../screens/home_screen.dart';

class VerifyNumber extends StatefulWidget {
   VerifyNumber({Key? key}) : super(key: key);
  bool isMount = true;

  @override
  State<VerifyNumber> createState() => _VerifyNumberState();
}
class _VerifyNumberState extends State<VerifyNumber> {
  late double height, width;

  String _confirmationCode = '123456';
  String _inputValue = '';

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
              SizedBox(
                height: height*.06,
                width: double.infinity,
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:BorderSide(color: kBlack80),
                    )
                  ),
                  onChanged: (value){
                    ///TODO
                    setState((){
                      _inputValue = value;
                    });

                  },
                ),
              ),
              SizedBox(height: height*.02,),
              _timerIsDone == true ?
                  SignupButton(
                      height: height*.06,
                      width: double.infinity,
                      buttonText: 'Re-send code',
                      onTap: _confirmationCode != _inputValue ? (){
                        ///TODO
                        ///send code
                        setState((){
                          _seconds = 60;
                          _minutes = 1;
                          _timerIsDone = false;
                          _startTimer();
                        });

                      } : null,
                  ) :
              InactiveButton(
                  height: height*.06,
                  width: double.infinity,
                  buttonText: 'Re-send code after $_minutes : $_seconds'
              ),
              SizedBox(height: height*.06,),
              _confirmationCode == _inputValue ?
              SignupButton(
                  height: height*.06,
                  width: double.infinity,
                  buttonText: 'Confirm Number',
                  onTap: (){
                   ///TODO
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen()),
                        ModalRoute.withName('/'));
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
}
