import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muraita_apps/sign_in/signin_bloc.dart';
import 'package:muraita_apps/sign_in/signin_widgets/signup_button.dart';
import 'package:muraita_apps/sign_in/string_validator.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../common_widgets/outlined_input_field.dart';
import '../common_widgets/progress_indicator_dialog.dart';
import '../services/auth.dart';


class OtpVerificationPage extends StatefulWidget with CodeValidator{
   OtpVerificationPage(BuildContext context, {Key? key, required this.phoneNumber, required this.countryCode })
: super(key: key);
   final String phoneNumber;
   final String countryCode;


   static Widget create(BuildContext context, phoneNumber, countryCode) {
     final auth = Provider.of<AuthBase>(context, listen: false);
     return Provider<SignInBloc>(
       create: (_) => SignInBloc(auth: auth,),
       dispose: (_, bloc) => bloc.dispose(),
       child: Consumer<SignInBloc>(
           builder: (_, bloc, __) =>OtpVerificationPage(context, phoneNumber:phoneNumber, countryCode: countryCode)),
     );
   }


  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}
class _OtpVerificationPageState extends State<OtpVerificationPage> {

  late double height, width;
  final _codeController = TextEditingController();
  String get _otpCode => _codeController.text;
  final int _codeLength = 6;

  late int _seconds = 60;
  late int _minutes = 1;
  Timer? _timer;
  bool _timerIsDone = false;


  @override
  void initState(){
    super.initState();
    _authenticateUser();
    if (mounted) {
      _startTimer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _codeController.dispose();
    _stopTimer();
    // _focus.dispose();

  }

  void _startTimer() {
    _timer = Timer.periodic(
        const Duration(seconds: 1), (_) {
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
    final bloc = Provider.of<SignInBloc>(context, listen: false);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: StreamBuilder<bool>(
              stream: bloc.isLoadingStream,
              initialData: false,
              builder: (context, snapshot) {
                return _buildContent(context, snapshot.data);
              }
          )
      ),
    );
  }

  Widget _buildContent(BuildContext context, isLoading) {
    print(isLoading);
    return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildChildren(isLoading),
          ),
        ),
      );
  }

  List<Widget> _buildChildren(isLoading){
    bool codeIsValid = widget.codeValidator.codeIsValid(_otpCode.length);
    return [
      _buildHeader(isLoading),
      OutlinedInputField(
        textAlign: TextAlign.center,
        height: height * .06,
        // focusNode: _focus,
        keyboardType: TextInputType.number,
        controller: _codeController,
        inputAction: TextInputAction.done,
        maxLength: _codeLength,
        onChanged: (otpCode) => _updateState(),
        onEditingComplete: _codeEditingComplete,
      ),
      SizedBox(height: height * .02,),
      SignupButton(
        height: height * .06,
        width: double.infinity,
        buttonText: _timerIsDone == true
            ? 'Re-send code'
            : 'Re-send code after $_minutes : $_seconds',
        onTap: _timerIsDone ? () => _resendCodeButton() : null,),
      SizedBox(height: height * .06,),
      SignupButton(
        height: height * .06,
        width: double.infinity,
        buttonText: 'Confirm Number',
        onTap: codeIsValid? () => _sendCodeButton() : null,
      ),
    ];
  }

  Widget _buildHeader(bool isLoading) {
    if (isLoading) {
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

  Future<void> _authenticateUser() async {
    try{
      print('entered auto auth first function');
      final bloc = Provider.of<SignInBloc>(context, listen: false);
       await bloc.autoSignInBloc(
          context: context,
          countryCode: widget.countryCode,
          phoneNumber: widget.phoneNumber,
      );
    } on Exception catch(e){
      print(e);
    }
  }

  Future<void> _sendCodeButton() async {
    try{
      final bloc = Provider.of<SignInBloc>(context, listen: false);
      final auth = Provider.of<AuthBase>(context, listen: false);

      auth.catchOtpFromInput(_otpCode);
      await bloc.manuallyCompareBloc(context: context);
    } on Exception catch(exception){
      final bloc = Provider.of<SignInBloc>(context, listen: false);
      bloc.showSignInError(context, exception);
    }
  }

   Future<void >_resendCodeButton() async {
    await _authenticateUser();
      setState(() {
        _seconds = 60;
        _minutes = 1;
        _timerIsDone = false;
        _startTimer();
      });
  }

  void _codeEditingComplete(){
    _sendCodeButton();
  }

  void _updateState(){
    setState((){});
  }
}


