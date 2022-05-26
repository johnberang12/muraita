
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muraita_apps/constants.dart';
import 'package:muraita_apps/signup_pages/signup_widgets/signup_button.dart';
import 'package:muraita_apps/validators/string_validator.dart';
import 'package:provider/provider.dart';
import '../common_widgets/exception_alert_dialog.dart';
import '../common_widgets/outlined_input_field.dart';
import '../screens/home_screen.dart';
import '../services/auth.dart';

class NameRegistration extends StatefulWidget with PhoneAndNameValidators{
   NameRegistration({Key? key}) : super(key: key);


  @override
  State<NameRegistration> createState() => _NameRegistrationState();
}

class _NameRegistrationState extends State<NameRegistration> {
  late double height, width;

  final _nameController = TextEditingController();
  bool _isLoading = false;

  late FocusNode _focus;

  @override
  void initState(){
    super.initState();
    _focus = FocusNode();
    _focus.requestFocus();
  }

  @override
  void dispose(){
    super.dispose();
    _nameController.dispose();
    _focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    bool submitEnabled = widget.nameValidator.nameIsValid(_nameController.text.length);
    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: width*.10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHeader(),
                const Text('You\'re almost there.', textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 18,
                ),),
                SizedBox(height: height*.03,),
                const Text('Introduce your self.'),
                SizedBox(height: height*.05,),
                OutlinedInputField(
                  textAlign: TextAlign.center,
                    height: height*.06,
                  focusNode: _focus,
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  inputAction: TextInputAction.send,
                  labelText: 'your name',
                  errorText: submitEnabled ? null : 'Name must have atleast minimum of 3 characters.',
                  onChanged: (value){
                    setState((){});
                  },
                ),
                SizedBox(height: height*.02,),

                    SignupButton(
                        height: height*.06,
                        width: double.infinity,
                        buttonText: 'Done',
                        onTap: submitEnabled ? _submitName() : null,
                    )
              ],
            ),
          ),
        )
    );
  }
   _submitName(){
     setState(() => _isLoading = true);
     final auth = Provider.of<AuthBase>(context, listen: false);
    ///TODO
    try{
      auth.currentUser?.updateDisplayName(_nameController.text);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen()),
              (Route<dynamic> route) => false);
    } on FirebaseAuthException catch(e){
      showExceptionAlertDialog(
        context,
        title: 'Sign in failed',
        exception: e,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildHeader(){
    if(_isLoading){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return const Text('Head\'s up!', textAlign: TextAlign.start,
      style: kHeadline1Style,
    );
  }
}
