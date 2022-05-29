import 'package:flutter/material.dart';
import 'package:muraita_apps/constants.dart';
import 'package:muraita_apps/sign_in/signin_widgets/signup_button.dart';
import 'package:muraita_apps/sign_in/otp_verification_page.dart';
import 'package:muraita_apps/sign_in/string_validator.dart';
import '../common_widgets/outlined_input_field.dart';


class NumberRegistration extends StatefulWidget with PhoneNumberValidator {
  NumberRegistration({Key? key,}) : super(key: key);
  @override
  State<NumberRegistration> createState() => _NumberRegistrationState();
}

class _NumberRegistrationState extends State<NumberRegistration> {
  final _numberController = TextEditingController();
  String get _phoneNumber => _numberController.text;


  late double height, width;
  final int _inputLength = 10;
  late String? _data = '';
  late final FocusNode _focus;
  
  bool _loading = false;

  ///TODO
  ///countryCode
  String selectedCountry = '+63';
  List<String> countryCodes = [
    '+63',
    '+1',
    '+82',
    '+23',
    '+56',
  ];

  List<DropdownMenuItem<String>> dropdownItems = [];

  @override
  void initState() {
    super.initState();
    callCircularProgressIndicator();
    _focus = FocusNode();
    _focus.requestFocus();
  }

  @override
  void dispose() {
    _numberController.dispose();
    _focus.dispose();
    super.dispose();
  }


  callCircularProgressIndicator() async {
    await Future.delayed(const Duration(milliseconds: 500));
      setState(() {
        _data = 'data';
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: _data == '' ?  const Center(child: CircularProgressIndicator(),): _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .10),
        child: SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildChildren(context),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildChildren(BuildContext context) {
    bool submitEnabled = widget.phoneValidator.phoneIsValid(_numberController.text.length);
    return [
       kNumberRegistrationTitle,
      SizedBox(height: height * .05),
       kNumberRegistrationSubTitle,
      SizedBox(height: height * .03),
       kNumberRegistrationBody,
      SizedBox(height: height * .10),
      _phoneNumberTextField(),
      SizedBox(height: height * .03,),
      SignupButton(
          height: height * .06,
          width: double.infinity,
          buttonText: 'Verify Number',
          onTap: submitEnabled ?  ()=>_submitPhoneNumber() : null)
        ];
  }

  Widget _phoneNumberTextField() {
    return OutlinedInputField(
      textAlign: TextAlign.start,
      height: height * .065,
      controller: _numberController,
      keyboardType: TextInputType.number,
      inputAction: TextInputAction.done,
      labelText: selectedCountry,
      focusNode: _focus,
      prefix: _selectCountry(),
      onChanged: (phoneNumber) => _updateState(),
      maxLength: _inputLength,
      onEditingComplete: _numberEditingComplete,
    );
  }

  Widget _selectCountry(){
    return DropdownButton<String>(
        underline: const SizedBox(),
        value: selectedCountry,
        items: countryCodes
            .map((code) => DropdownMenuItem(
          value: code,
          child: Text(code),
        ))
            .toList(),
        onChanged: (value) {
          ///TODO
          ///country code
          selectedCountry = value!;
          setState(() {});
        });
  }

  void _submitPhoneNumber() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OtpVerificationPage.create(
                context, _phoneNumber, selectedCountry)));
  }
  void _numberEditingComplete(){
    _submitPhoneNumber();
  }

  void _updateState(){
    setState((){});
  }
}


