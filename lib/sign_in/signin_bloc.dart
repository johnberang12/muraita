
import 'dart:async';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muraita_apps/common_widgets/progress_indicator_dialog.dart';
import '../common_widgets/exception_alert_dialog.dart';
import '../screens/home_screen.dart';
import '../services/auth.dart';
import 'name_registration.dart';

class SignInBloc {
  SignInBloc({required this.auth, this.bloc});
  final AuthBase auth;
  final SignInBloc? bloc;
  final StreamController<bool> _isLoadingController = StreamController<bool>();
  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  void dispose(){
    _isLoadingController.close();
  }

  void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);


  Future<void> autoSignInBloc({
    required BuildContext context,
    required String countryCode,
    required String phoneNumber,

  }) async {
    try{
      print('entered auto sign in bloc function');
      _setIsLoading(true);

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



  Future<void> manuallyCompareBloc({
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
              _goToRegisterName(context);
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

   _goToRegisterName(context){
    User? user;
    try{
      if(user?.displayName == null) {
        return Navigator.push(context, MaterialPageRoute(
          builder: (context) => NameRegistration(),
        ));
      } else {

        return Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen()),
                (Route<dynamic> route) => false);
      }

    }  catch(e) {
      print('error from register name function => $e');
    }

  }




}