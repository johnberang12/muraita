import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:muraita_apps/constants.dart';
import 'package:muraita_apps/signup_pages/signup_widgets/signup_button.dart';
import 'package:muraita_apps/signup_pages/verify_number.dart';
import 'package:muraita_apps/widget/inactive_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widget/outlined_input_field.dart';

class NumberRegistration extends StatefulWidget {
   NumberRegistration({Key? key}) : super(key: key);

  @override
  State<NumberRegistration> createState() => _NumberRegistrationState();
}

class _NumberRegistrationState extends State<NumberRegistration> {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  final _formKey = GlobalKey<FormState>();
  final _formKeyOTP = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<FormState>();

   final _numberController = TextEditingController();
  final  _otpController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _familyNameController = TextEditingController();

  var _isLoading = false;
  var _isResend = false;
  var _isLoginScreen = true;
  var _verificationCode = '';


  late double height, width;
  final int _inputLength = 11;
  String _phoneNumber = '';
  late int _phoneNumberLength = 0;

  late  final FocusNode _focus = FocusNode();

  ///TODO
  ///countryCode
  String? selectedCountry = '+63';
  List<String> countryCodes = [
    '+63',
    '+82',
    '+23',
    '+56',
  ];

  List<DropdownMenuItem<String>> dropdownItems = [];

  @override
  void initState(){
    super.initState();

  }

  @override
  void dispose(){
    super.dispose();
    _numberController;
    _otpController;
  }



  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: kBlack80,
                  ),
                  ),
                  SizedBox(height: height*.05,),
                   Text('Please signup using your phone number.',
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
                    height: height*.06,
                    controller: _firstNameController,
                    keyboardType: TextInputType.name,
                    inputAction: TextInputAction.next,
                    labelText: 'your name',
                  ),
                  SizedBox(height: height*.02,),

                  SizedBox(height: height*.02,),
                  OutlinedInputField(
                    height: height*.065,
                    controller: _numberController,
                    keyboardType: TextInputType.number,
                    inputAction: TextInputAction.send,
                    labelText: selectedCountry,
                    prefix: DropdownButton<String>(
                        underline: SizedBox(),
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
                      _phoneNumber = value;
                      setState((){
                        _phoneNumberLength = value.length;
                      });
                    },
                    maxLength: _inputLength,
                  ),

                  SizedBox(height: height*.03,),

                _inputLength == _phoneNumberLength ?
                SignupButton(
                      height: height*.06,
                      width: double.infinity,
                      buttonText: 'Verify Number',
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => VerifyNumber(),
                        ));
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
    );
  }
}


