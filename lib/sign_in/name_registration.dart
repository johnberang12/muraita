
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muraita_apps/constants.dart';
import 'package:muraita_apps/sign_in/signin_widgets/signup_button.dart';

import 'package:muraita_apps/sign_in/string_validator.dart';
import 'package:provider/provider.dart';
import '../common_widgets/exception_alert_dialog.dart';
import '../common_widgets/outlined_input_field.dart';
import '../screens/home_screen.dart';
import '../services/auth.dart';


class NameRegistration extends StatefulWidget with NameValidator{
   NameRegistration({Key? key}) : super(key: key);
  @override
  State<NameRegistration> createState() => _NameRegistrationState();
}

class _NameRegistrationState extends State<NameRegistration> {
  final _nameController = TextEditingController();
  String get _name => _nameController.text;
  bool _isLoading = false;
  final bool _isSubmitted = false;
  late FocusNode _focus;
  late double height, width;

  @override
  void initState(){
    super.initState();
    _focus = FocusNode();
    _focus.requestFocus();
  }

  @override
  void dispose(){
    _nameController.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _submitName(){
    setState(() => _isLoading = true);
    final auth = Provider.of<AuthBase>(context, listen: false);
    try{
      auth.currentUser?.updateDisplayName(_name);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) => HomeScreen()),
              (Route<dynamic> route) => false);
    } on FirebaseAuthException catch(e){
      showExceptionAlertDialog(
        context,
        title: 'Sign in failed',
        exception: e,);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _nameEditingComplete(){
    _submitName();
  }
  void _updateState(){
    setState((){});
  }


@override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: width*.10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildChildren(context),
            ),
          ),
        )
    );
  }

  List<Widget> _buildChildren(BuildContext context){
    bool showErrorText = _isSubmitted;
    bool nameValid = widget.nameValidator.nameIsValid(_name.length);
    return [
      _buildHeader(),
      kNameRegistrationSubTitle,
      SizedBox(height: height*.03,),
      kNameRegistrationBody,
      SizedBox(height: height*.05,),
      OutlinedInputField(
        textAlign: TextAlign.center,
        height: height*.06,
        focusNode: _focus,
        controller: _nameController,
        keyboardType: TextInputType.name,
        inputAction: TextInputAction.done,
        labelText: 'your name',
        errorText: showErrorText ? widget.invalidNameError : null,
        onChanged: (name) => _updateState(),
        onEditingComplete: _nameEditingComplete,
      ),
      SizedBox(height: height*.02,),
      SignupButton(
        height: height*.06,
        width: double.infinity,
        buttonText: 'Done',
        onTap: nameValid ?  _submitName : null,
      )
    ];
  }

  Widget _buildHeader(){
    if(_isLoading){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return  kNameRegistrationTitle;
  }

}