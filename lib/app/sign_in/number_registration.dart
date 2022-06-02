import 'package:flutter/material.dart';
import 'package:muraita_apps/constants.dart';
import 'package:muraita_apps/app/sign_in/number_registration_bloc.dart';
import 'package:muraita_apps/app/sign_in/signin_widgets/signup_button.dart';
import 'package:muraita_apps/app/sign_in/otp_verification_page.dart';
import 'package:muraita_apps/app/sign_in/string_validator.dart';
import 'package:provider/provider.dart';
import '../../common_widgets/outlined_input_field.dart';
import 'number_registration_bloc.dart';


class NumberRegistration extends StatefulWidget with PhoneNumberValidator {
  NumberRegistration({Key? key}) : super(key: key);


  static Widget create(BuildContext context) {
    return Provider<NumberRegistrationBloc>(
      create: (_) => NumberRegistrationBloc(),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<NumberRegistrationBloc>(
          builder: (_, bloc, __) => NumberRegistration(),)
    );
  }

  @override
  State<NumberRegistration> createState() => _NumberRegistrationState();
}

class _NumberRegistrationState extends State<NumberRegistration> {
  final _numberController = TextEditingController();
  String get _phoneNumber => _numberController.text;

  late double _height, _width, _inputFieldHeight;
  final int _inputLength = 10;
  late final FocusNode _focus;
  bool _submitted = false;


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
    final numBloc = Provider.of<NumberRegistrationBloc>(context, listen: false);
    super.initState();
    numBloc.callCircularProgressIndicator();
    _focus = FocusNode();
    _focus.requestFocus();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _numberController.dispose();
    _focus.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    print('entered number registration');
    final numBloc = Provider.of<NumberRegistrationBloc>(context, listen: false);
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _inputFieldHeight = _height*.065;
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<bool>(
            stream: numBloc.isLoadingStream,
            initialData: false,
            builder: (context, snapshot) {
              return _buildContent(context, snapshot.data);
            }
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool? isLoading) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: _width * .10),
        child: SingleChildScrollView(
          padding:
          EdgeInsets.only(bottom: MediaQuery
              .of(context)
              .viewInsets
              .bottom),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildChildren(context, isLoading),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildChildren(BuildContext context, isLoading) {
    bool phoneIsValid = widget.phoneValidator.phoneIsValid(
        _numberController.text.length);
    return [
      kNumberRegistrationTitle,
      SizedBox(height: _height * .05),
      kNumberRegistrationSubTitle,
      SizedBox(height: _height * .03),
      kNumberRegistrationBody,
      SizedBox(height: _height * .10),
      _phoneNumberTextField(isLoading, phoneIsValid),
      SizedBox(height: _height * .03,),
      SignupButton(
          height: _height * .06,
          width: double.infinity,
          buttonText: 'Verify Number',
          onTap: phoneIsValid ? () => _submitPhoneNumber() : null)
    ];
  }

  Widget _phoneNumberTextField(isLoading, phoneIsValid) {
    if(isLoading == true){return const Center(child: CircularProgressIndicator(),);}

    return OutlinedInputField(
      textAlign: TextAlign.start,
      height: _inputFieldHeight,
      controller: _numberController,
      keyboardType: TextInputType.number,
      inputAction: TextInputAction.done,
      labelText: selectedCountry,
      focusNode: _focus,
      prefix: _selectCountry(),
      errorText: _submitted == true && !phoneIsValid ? widget.invalidPhoneError : null,
      onChanged: (phoneNumber) => _updateState(),
      onEditingComplete: ()=> _numberEditingComplete(),
      maxLength: _inputLength,
    );
  }

  Widget _selectCountry() {
    return DropdownButton<String>(
        underline: const SizedBox(),
        value: selectedCountry,
        items: countryCodes
            .map((code) =>
            DropdownMenuItem(
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

  void _numberEditingComplete(){
    setState((){
      _submitted = true;
      FocusScope.of(context).unfocus();
    });
  }

  void _submitPhoneNumber() {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) =>
                OtpVerificationPage.create(
                    context, _phoneNumber, selectedCountry)));
  }


  void _updateState() {
    setState(() {
      _submitted = false;
    });
  }
}




