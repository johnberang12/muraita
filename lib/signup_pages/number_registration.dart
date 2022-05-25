import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:muraita_apps/constants.dart';
import 'package:muraita_apps/signup_pages/signup_widgets/signup_button.dart';
import 'package:muraita_apps/signup_pages/verify_number.dart';
import 'package:muraita_apps/widget/inactive_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widget/error_warning.dart';
import '../widget/outlined_input_field.dart';

class NumberRegistration extends StatefulWidget {
   NumberRegistration({Key? key}) : super(key: key);

  @override
  State<NumberRegistration> createState() => _NumberRegistrationState();
}

class _NumberRegistrationState extends State<NumberRegistration> {
  final FirebaseAuth _auth = FirebaseAuth.instance;



   final _numberController = TextEditingController();



  var _isLoading = false;
  var _isLoginScreen = true;
  var _verificationCode = '';


  late double height, width;
  final int _inputLength = 10;
  String _phoneNumber = '';
  bool _numberIsValid = true;
  String _errorMessage = 'Invalid phone number';


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
  }



  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
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
                    const Text('Welcome',
                    style: kHeadline1Style,
                    ),
                    SizedBox(height: height*.05,),
                     Text('Please signin using your phone number.',
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
                    Visibility(
                      visible: _numberIsValid == false,
                      child: ErrorWarning(
                          height: height*.06,
                        colour: Theme.of(context).errorColor,
                        errorText: _errorMessage,
                      ),
                    ),


                    SizedBox(height: height*.02,),
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
                        setState((){
                          _phoneNumber = value;

                        });
                      },
                      onSubmitted: (value){
                        _phoneNumber = value;
                      },
                      maxLength: _inputLength,
                    ),

                    SizedBox(height: height*.03,),

                  _inputLength == _phoneNumber.length ?
                  SignupButton(
                        height: height*.06,
                        width: double.infinity,
                        buttonText: 'Verify Number',
                        onTap: (){
                          _phoneNumber = _numberController.text;
                          print('$selectedCountry$_phoneNumber');
                          _verifyNumber();
                          _numberIsValid = true;
                        }
                    ) :
                    InactiveButton(
                        height: height*.06,
                        width: double.infinity,
                        buttonText: 'Verify Number',
                    ),
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
  _auth.verifyPhoneNumber(
      phoneNumber: '$selectedCountry$_phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential).then((value) {
          print('You are logged in successfully');

        });
      },
      verificationFailed: (FirebaseAuthException exception){
        setState((){
          _numberIsValid = false;
        });

        print(exception.message);
        _errorMessage = exception.message!;
        print('error error error error error');

      },
      codeSent: (String verificationID, int? resendToken){
        print('Code sent code sent code sent code sent');
        setState((){
          _verificationCode = verificationID;
        });
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => VerifyNumber(verificationCode: _verificationCode, verifyNumber: _verifyNumber),
        ));
      },
      codeAutoRetrievalTimeout: (String verificationID){

      }
  );
  }



}


