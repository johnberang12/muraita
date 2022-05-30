import 'package:flutter/material.dart';
import 'package:muraita_apps/app/sign_in/signin_bloc.dart';
import 'package:muraita_apps/app/sign_in/signin_widgets/signup_button.dart';
import 'package:muraita_apps/app/sign_in/string_validator.dart';


import 'package:provider/provider.dart';
import '../../common_widgets/outlined_input_field.dart';
import '../../services/auth.dart';






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
  bool _submitted = false;

  void _verifyPhoneNumber(){
    final bloc = Provider.of<SignInBloc>(context, listen: false);
    bloc.autoVerifyPhone(
        context: context,
        countryCode: widget.countryCode,
        phoneNumber: widget.phoneNumber);
  }

  @override
  void initState(){
    final bloc = Provider.of<SignInBloc>(context, listen: false);
    super.initState();
    _verifyPhoneNumber();
    if (mounted) {
      bloc.startTimer();
    }
  }

  @override
  void dispose() {
    final bloc = Provider.of<SignInBloc>(context, listen: false);
    super.dispose();
    bloc.stopTimer();
    _codeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: _buildContent(context),
          )
      );

  }

  Widget _buildContent(BuildContext context) {
    return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildChildren(),
          ),
        ),
      );
  }

  List<Widget> _buildChildren(){
    final bloc = Provider.of<SignInBloc>(context, listen: false);
    bool codeIsValid = widget.codeValidator.codeIsValid(_otpCode.length);
    return [
      _buildInputField(),
      SizedBox(height: height * .02,),
      StreamBuilder<bool>(
        stream: bloc.isTimerStream,
        initialData: true,
        builder: (context, snapshot) {
          return _buildResendButton(snapshot.data);
        }
      ),
      SizedBox(height: height * .06,),
      SignupButton(
        height: height * .06,
        width: double.infinity,
        buttonText: 'Confirm Number',
        onTap: codeIsValid? () => _sendCodeButton() : null,
      ),
    ];
  }

  Widget _buildResendButton(bool? timerOn){
    final bloc = Provider.of<SignInBloc>(context, listen: false);
    return SignupButton(
      height: height * .06,
      width: double.infinity,
      buttonText: timerOn == true
          ? 'Re-send code after ${bloc.minutes} : ${bloc.seconds}'
          : 'Re-send code',
      onTap: timerOn == true ?  null : () =>  _resendCode());
  }

  Widget _buildInputField() {
    final bloc = Provider.of<SignInBloc>(context, listen: false);
    bool codeIsValid = widget.codeValidator.codeIsValid(_otpCode.length);
    return StreamBuilder<bool>(
      stream: bloc.isLoadingStream,
      initialData: true,
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return Center(
            child: Column(
              children: [
                const CircularProgressIndicator(),
                SizedBox(height: height * .03,)
              ],
            ),
          );
        }
        return OutlinedInputField(
          textAlign: TextAlign.center,
          height: height * .06,
          keyboardType: TextInputType.number,
          controller: _codeController,
          inputAction: TextInputAction.done,
          maxLength: _codeLength,
          errorText: _submitted == true && !codeIsValid  ? widget.invalidCodeError : null,
          onChanged: (otpCode) => _updateState(),
          onEditingComplete: ()=> _otpEditingComplete(),

        );
      }
    );
  }


  void _resendCode(){
    _verifyPhoneNumber();
  }

  void _sendCodeButton(){
    final bloc = Provider.of<SignInBloc>(context, listen: false);
    bloc.sendCodeButton(context, otpCode: _otpCode);
  }

  void _otpEditingComplete(){
    setState((){
      _submitted = true;
      FocusScope.of(context).unfocus();
    });
  }

  void _updateState(){
    setState((){
      _submitted = false;
    });
  }
}


