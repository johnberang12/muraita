import 'package:flutter/material.dart';
import 'package:muraita_apps/constants.dart';
import 'package:muraita_apps/signup_pages/signup_widgets/signup_button.dart';
import 'package:muraita_apps/widget/inactive_button.dart';
import 'package:muraita_apps/widget/outlined_input_field.dart';

import '../screens/home_screen.dart';

class NameRegistration extends StatefulWidget {
   NameRegistration({Key? key}) : super(key: key);

  @override
  State<NameRegistration> createState() => _NameRegistrationState();
}

class _NameRegistrationState extends State<NameRegistration> {
  late double height, width;

  final _nameController = TextEditingController();

  late FocusNode _focus;
  late String _name = '';

  @override
  void initState(){
    super.initState();
    _focus = FocusNode();
    _focus.requestFocus();
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
              children: [
                Text('Head\'s up!', textAlign: TextAlign.start,
                style: kHeadline1Style,
                ),
                Text('You\'re almost there.', textAlign: TextAlign.end,
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
                  onChanged: (value){
                    setState((){
                      _name = value;
                    });
                  },
                ),
                SizedBox(height: height*.02,),


                _name.length < 3 ?
                   InactiveButton(
                  height: height*.06,
                  width: double.infinity,
                  buttonText: 'Done',
                  ) :
                SignupButton(
                    height: height*.06,
                    width: double.infinity,
                    buttonText: 'Done',
                    onTap: (){
                      ///TODO
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()),
                          ModalRoute.withName('/'));
                    }
                )
              ],
            ),
          ),
        )
    );
  }
}
