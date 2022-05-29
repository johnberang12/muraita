import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muraita_apps/sign_in/signin_bloc.dart';
import 'package:provider/provider.dart';

import '../screens/home_screen.dart';
import '../sign_in/name_registration.dart';

abstract class AuthBase{
  User? get currentUser;
  Stream<User?> authStateChanges();
  Future<void> signOut();
  Future<void> autoRegisterWithPhone(
      BuildContext context,
      String countryCode,
      String phoneNumber,
  );
  Future<void> createUserCredential(BuildContext context);
  void catchOtpFromInput(otpCode);
}



class Auth extends AuthBase {
  final _authInstance = FirebaseAuth.instance;

  late String _verificationID = '';
  late String _userInputCode = '';


  @override
  Stream<User?> authStateChanges() => _authInstance.authStateChanges();

  @override
  User? get currentUser => FirebaseAuth.instance.currentUser;


  @override
  Future<void> autoRegisterWithPhone(BuildContext context, String countryCode, String phoneNumber) async {
    final authProvider =  Provider.of<AuthBase>(context, listen: false);
    final SignInBloc bloc = SignInBloc(auth: authProvider);

    try{
      print('entered auto registerWithPhone at auth class');
      await _authInstance.verifyPhoneNumber(
        phoneNumber: '$countryCode$phoneNumber',
        verificationCompleted: (PhoneAuthCredential credential) async {
          print('entered verification complete');
        },
        verificationFailed: (FirebaseAuthException exception) async {
          print('entered failed failed failed failed');
          bloc.showSignInError(context, exception);
        },
        codeSent: (String verificationId, int? resendToken) async {
          print('entered code sent code sent code sent0');
          print('verificationID from code sent is => $verificationId');
          _verificationID = verificationId;

        },
        codeAutoRetrievalTimeout: (String verificationId) async {
          print('entered autoretrieval autoretrieval autoretrieval');
          _verificationID = verificationId;
        },
        // timeout: const Duration(seconds: 120),
      );
    } on Exception catch(exception) {
      bloc.showSignInError(context, exception);
    }

  }

  @override
  Future<void> createUserCredential(BuildContext context) async {
    final authProvider = Provider.of<AuthBase>(context, listen: false);
    SignInBloc bloc = SignInBloc(auth: authProvider);

    try{
      print('entered create user credential at auth');
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: _verificationID,
        smsCode: _userInputCode,
      );

      bloc.signInWithCredential(context, phoneAuthCredential, _authInstance);
    } on Exception catch (exception){
      bloc.showSignInError(context, exception);
    }

  }

  @override
  void catchOtpFromInput(otpCode){
    _userInputCode = otpCode;
  }

  @override
  Future<void> signOut() async {
    await _authInstance.signOut();
  }


  
}