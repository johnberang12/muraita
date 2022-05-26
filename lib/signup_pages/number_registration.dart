
import 'package:flutter/material.dart';
import 'package:muraita_apps/common_widgets/alert_dialog.dart';
import 'package:muraita_apps/constants.dart';
import 'package:muraita_apps/signup_pages/signup_widgets/signup_button.dart';
import 'package:muraita_apps/signup_pages/verify_number.dart';
import 'package:muraita_apps/validators/string_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../common_widgets/error_warning.dart';
import '../common_widgets/exception_alert_dialog.dart';
import '../common_widgets/outlined_input_field.dart';
import '../services/auth.dart';



class NumberRegistration extends StatefulWidget with PhoneAndNameValidators {
   NumberRegistration({Key? key}) : super(key: key);


  @override
  State<NumberRegistration> createState() => _NumberRegistrationState();
}

class _NumberRegistrationState extends State<NumberRegistration> {

  final _auth = FirebaseAuth.instance;


  final _numberController = TextEditingController();
  var _verificationCode = '';

  late double height, width;
  final int _inputLength = 10;
  String _phoneNumber = '';
  bool _isLoading = false;


  late FocusNode _focus;

  ///TODO
  ///countryCode
  String? selectedCountry = '+63';
  List<String> countryCodes = [
    '+63',
    '+1',
    '+82',
    '+23',
    '+56',
  ];

  List<DropdownMenuItem<String>> dropdownItems = [];

  @override
  void initState(){
    super.initState();
    _focus = FocusNode();
    _focus.requestFocus();
  }

  @override
  void dispose(){
    super.dispose();
    _numberController;
    _focus.dispose();
  }



  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    bool submitEnabled = widget.phoneValidator.phoneIsValid(_numberController.text.length) && !_isLoading;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width*.10),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildHeader(),

                    SizedBox(height: height*.05,),
                     Text('Please register using your phone number.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: height*.025
                    ),),
                    SizedBox(height: height*.03,),
                    Text('Your phone number is kept safe.\nIt won\'t be disclose to anyone.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: height*.018,
                      ),
                    ),
                    SizedBox(height: height*.10,),


                    OutlinedInputField(
                      textAlign: TextAlign.start,
                      height: height*.065,
                      controller: _numberController,
                      keyboardType: TextInputType.number,
                      inputAction: TextInputAction.send,
                      labelText: selectedCountry,
                      focusNode: _focus,
                      prefix: DropdownButton<String>(
                          underline: const SizedBox(),
                          value: selectedCountry,
                          items: countryCodes.map((code) =>
                              DropdownMenuItem(value: code,child: Text(code),)).toList(),
                          onChanged: (value){
                            ///TODO
                            ///country code
                            selectedCountry = value;
                            setState((){});
                          }
                      ),
                      onChanged: (value){
                        setState((){_phoneNumber = value;});
                      },
                      maxLength: _inputLength,
                    ),

                    SizedBox(height: height*.03,),

                            SignupButton(
                                  height: height*.06,
                                  width: double.infinity,
                                  buttonText: 'Verify Number',
                                  onTap: submitEnabled && !_isLoading? (){
                                    _verifyNumber();
                                    _isLoading = true;
                                  } : null
                              ) ,

                  ],
                ),

              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _verifyNumber()async {

    try{
      _auth.verifyPhoneNumber(
          phoneNumber: '$selectedCountry$_phoneNumber',
          verificationCompleted: (PhoneAuthCredential credential) async {
                await _auth.signInWithCredential(credential).then((value) {

                  setState(() => _isLoading = false);

                });
              },

          verificationFailed: (FirebaseAuthException exception){
            setState(() => _isLoading = false);
              showExceptionAlertDialog(
                context,
                title: 'Sign in failed',
                exception: exception,
              );

          },
          codeSent: (String verificationID, int? resendToken){
              _verificationCode = verificationID;
              setState(() => _isLoading = false);
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => VerifyNumber(
                    verificationCode: _verificationCode,
                    verifyNumber: _verifyNumber
                ),
              ));
          },
          codeAutoRetrievalTimeout: (String verificationID){},
          // timeout: const Duration(seconds: 120),
      );
    } on FirebaseAuthException catch(e){
      setState((){
        showExceptionAlertDialog(
          context,
          title: 'Sign in failed',
          exception: e,
        );
      });
    } finally {
      setState((){
        _isLoading = false;
      });
    }


  }


  Widget _buildHeader(){
    if(_isLoading){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return const Text('Welcome',
      style: kHeadline1Style,
    );
  }

}


