
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../common_widgets/exception_alert_dialog.dart';
import '../../services/auth.dart';
import '../../src/landing_page.dart';


class SignInBloc {
  SignInBloc({required this.auth, this.bloc});
  final AuthBase auth;
  final SignInBloc? bloc;
  final StreamController<bool> _isLoadingController = StreamController<bool>();
  final StreamController<bool> _isTimerController = StreamController<bool>();
  Stream<bool> get isLoadingStream => _isLoadingController.stream;
  Stream<bool> get isTimerStream => _isTimerController.stream;

  late int seconds = 60;
  late int minutes = 1;
  Timer? timer;


  void dispose(){
    _isLoadingController.close();
  }

  void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);
  void _setTimer(bool timerOn) => _isTimerController.add(timerOn);


  Future<void> autoVerifyPhone({
    required BuildContext context,
    required String countryCode,
    required String phoneNumber,
  }) async {
    try{
      print('entered auto sign in bloc function');

      print('loading stream in auto sign in bloc upon click is => $isLoadingStream');
       await auth.autoRegisterWithPhone(context, countryCode, phoneNumber);
    } on Exception catch(exception) {
      _setIsLoading(false);
      bloc?.showSignInError(context, exception);
    rethrow;
    } finally {
      _setIsLoading(false);
      print('loading stream in auto sign in bloc at finally is => $isLoadingStream');
    }
  }



  Future<void> verifyOtp({
    required BuildContext context,
  }) async {
    print('entered manually compate bloc');
    try{
      _setIsLoading(true);
      print('loading stream in auto sign in bloc upon click is => $isLoadingStream');
      await auth.createUserCredential(context);
    } on Exception catch(exception) {
      _setIsLoading(false);
      bloc?.showSignInError(context, exception);
        rethrow;
    } finally {
      _setIsLoading(false);
      print('loading stream in auto sign in bloc upon click is => $isLoadingStream');
    }
  }


  void showSignInError(BuildContext context, Exception exception){
    if(exception is FirebaseAuthException && exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }
    showExceptionAlertDialog(
        context,
        title: 'Sign in failed',
        exception: exception
    );
  }


  Future<void> signInWithCredential(
      BuildContext context,
      PhoneAuthCredential credential,
      FirebaseAuth auth,
      ) async {
    try{
      print('entered sign in with credential function');
      print('verification id is ${credential.verificationId}');
      print('smsCode is ${credential.smsCode}');
      await auth.signInWithCredential(credential)
          .then((value) {
            print(value);
              print('verification id is ${credential.verificationId}');
              print('smsCode is ${credential.smsCode}');
              _verificationSucceeded(context);
                 })
          .whenComplete((){
            print('entered when complete...this is whether or not there is an error.');
                })
          .onError((Exception error, stackTrace){
            print('entered on error');
            print(error);
            showSignInError(context, error);
                })
          .catchError((onError){
            print('entered cathcError');
            showSignInError(context, onError);
            print(onError);
      });

    } on Exception catch(exception) {
      showSignInError(context, exception);
    }
  }

  Future<void> sendCodeButton(context, {required otpCode}) async {
    try{
      auth.catchOtpFromInput(otpCode);
      await verifyOtp(context:context);
    } on Exception catch(exception){
      showSignInError(context, exception);
    } finally {
      _setIsLoading(false);
    }
  }


  Future<void > resendCodeButton(context, {required countryCode, required phoneNumber}) async {
    await autoVerifyPhone(context: context, countryCode: countryCode, phoneNumber: phoneNumber);
      seconds = 60;
      minutes = 1;
      _setTimer(true);
  }

   _verificationSucceeded(BuildContext context){
     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
         builder: (context) => LandingPage()),
             (Route<dynamic> route) => false);
  }


  void startTimer() {
    timer = Timer.periodic(
        const Duration(seconds: 1), (_) {
      // if (!mounted) return;
        if (minutes == 0 && seconds < 1) {
          stopTimer();
          _setTimer(false);
        } else {
          if (seconds > 0) {
            seconds--;
          } else {
            seconds = 59;
            minutes--;
          }
        }

    });
  }

  void stopTimer() {
    timer?.cancel();
  }


}