import 'package:flutter/material.dart';
import 'package:muraita_apps/constants.dart';
import 'package:muraita_apps/widget/inactive_button.dart';
import 'package:muraita_apps/widget/primary_button.dart';

class RegistrationPage extends StatefulWidget {
   RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late double height, width;
  final int _inputLength = 11;
  String _phoneNumber = '';
  late int _phoneNumberLength = 0;


  String? selectedCountry = '+63';

  List<String> countryCodes = [
    '+63',
    '+82',
    '+23',
    '+56',
  ];

  List<DropdownMenuItem<String>> dropdownItems = [];

  // getDropdownItems<DropdownMenuItem>(){
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*.10),
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
            const Text('Please signup using your phone number.'),
            SizedBox(height: height*.03,),
            const Text('Your phone number is kept safe. It won\'t be disclose to anyone.', textAlign: TextAlign.center,),
            SizedBox(height: height*.10,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(08),
                border: Border.all(
                  color: kBlack80,
                )
              ),
              height: height*.075,
              width: double.infinity,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: width*.03),
                child: Row(
                  children: [
                    ///TODO dropdown list of country code
                    Expanded(
                      flex: 20,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: height*.006),
                            child: SizedBox(
                              height: height*.060,
                              width: double.infinity,
                              child: DropdownButton<String>(
                                underline: SizedBox(),
                                value: selectedCountry,
                                  items: countryCodes.map((code) =>
                                  DropdownMenuItem(value: code,child: Text(code),)).toList(),
                                  onChanged: (value){
                                  selectedCountry = value;
                                  }
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      flex: 80,
                      child: SizedBox(
                        width: width*.65,
                        child:  TextField(
                          onChanged: (value){
                            _phoneNumber = value;
                            setState((){
                              _phoneNumberLength = value.length;
                            });

                            print(_phoneNumber);
                            print(_phoneNumberLength);
                          },
                          maxLength: _inputLength,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            isDense: true,
                            counterText: "",
                            // border: OutlineInputBorder(
                            //     borderSide: BorderSide(color: kBlack80, width: 1.0)
                            // ),
                            border: InputBorder.none
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height*.03,),

          _inputLength == _phoneNumberLength ?
          PrimaryButton(
                height: height*.06,
                width: double.infinity,
                buttonText: 'Verify Number',
                onTap: (){

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
    );
  }
}
