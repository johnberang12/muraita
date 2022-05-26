import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muraita_apps/signup_pages/name_registration.dart';
import 'package:muraita_apps/signup_pages/signup_widgets/signup_button.dart';
import 'package:muraita_apps/validators/string_validator.dart';
import 'package:provider/provider.dart';
import '../common_widgets/alert_dialog.dart';
import '../common_widgets/exception_alert_dialog.dart';
import '../common_widgets/outlined_input_field.dart';
import '../screens/home_screen.dart';
import '../services/auth.dart';

class VerifyNumber extends StatefulWidget with CodeValidator{
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

  final int _codeLength = 6;
  bool _isLoading = false;

  late int _seconds = 60;
  late int _minutes = 1;
  Timer? _timer;
  bool _timerIsDone = false;


  @override
  void initState() {
    super.initState();
    if (mounted) {
      _startTimer();
    }
    _focus = FocusNode();
    _focus.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _stopTimer();
    _codeController.dispose();
    _focus.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;

      setState(() {
        if (_minutes == 0 && _seconds < 1) {
          _timerIsDone = true;
          _stopTimer();
        } else {
          if (_seconds > 0) {
            _seconds--;
          } else {
            _seconds = 59;
            _minutes--;
          }
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    bool codeIsValid = widget.codeValidator.codeIsValid(
        _codeController.text.length);
    height = MediaQuery
        .of(context)
        .size
        .height;
    width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHeader(),
              OutlinedInputField(
                textAlign: TextAlign.center,
                height: height * .06,
                focusNode: _focus,
                keyboardType: TextInputType.number,
                controller: _codeController,
                inputAction: TextInputAction.send,
                maxLength: _codeLength,
                onChanged: (value) {
                  ///TODO
                  setState(() {
                    // _inputValue = value;
                  });
                },
              ),
              SizedBox(height: height * .02,),

              SignupButton(
                height: height * .06,
                width: double.infinity,
                buttonText: _timerIsDone == true
                    ? 'Re-send code'
                    : 'Re-send code after $_minutes : $_seconds',
                onTap: _timerIsDone && !_isLoading ? () {
                  widget.verifyNumber();
                  setState(() {
                    _seconds = 60;
                    _minutes = 1;
                    _timerIsDone = false;
                    _startTimer();
                    _isLoading = true;
                  });
                } : null,),
              SizedBox(height: height * .06,),

              SignupButton(
                height: height * .06,
                width: double.infinity,
                buttonText: 'Confirm Number',
                onTap: codeIsValid ? () {
                  ///TODO
                  _verifyCode(smsCode: _codeController.text);
                } : null,
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> _verifyCode({required String smsCode}) async {
    try {
      setState(() => _isLoading = true);
      final auth = Provider.of<AuthBase>(context, listen: false);

      var credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationCode,
          smsCode: smsCode
      );
      await _auth
          .signInWithCredential(credential)
          .then((value) {
        print('you are logged in successfully');
        if(value.user != null){
          if (auth.currentUser?.displayName == null) {
            Navigator.push(
                context, MaterialPageRoute(
              builder: (context) => NameRegistration(),
            ));
          }
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen()),
                  (Route<dynamic> route) => false);

          setState(() => _isLoading = false);
        }
      })
          .whenComplete(() {
        //triggered whether or not there is an error
        //this is similar to finally
        setState(() => _isLoading = false);
      })
          .onError((FirebaseAuthException exception, stackTrace) {
        setState(() {
          _codeController.clear();
          _isLoading = false;
          showExceptionAlertDialog(
              context,
              title: 'Sign in failed',
              exception: exception
          );
        });
      });
    } on Exception catch (e) {
      setState(() => _isLoading = false);
      showExceptionAlertDialog(
        context,
        title: 'Sign in failed',
        exception: e,
      );
    } finally{
      setState(() => _isLoading = false);
    }
  }

  Widget _buildHeader() {
    if (_isLoading) {
      return  Center(
        child: Column(
          children: [
           const CircularProgressIndicator(),
            SizedBox(height: height*.03,)
          ],
        ),
      );
    }
    return const SizedBox();
  }
}