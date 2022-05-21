import 'package:flutter/material.dart';
import 'package:muraita_apps/constants.dart';
import 'package:muraita_apps/widget/primary_button.dart';

class RegistrationPage extends StatelessWidget {
   RegistrationPage({Key? key}) : super(key: key);

  late double height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: height*.10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: kBlack80,
            ),
            ),
            SizedBox(height: height*.03,),
            const Text('Please signup using your phone number.'),
            SizedBox(height: height*.03,),
            const Text('Your phone number is kept safe. It won\'t be disclose to anyone.', textAlign: TextAlign.center,),
            SizedBox(height: height*.03,),
            TextField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kBlack80, width: 2.0)
                )
              ),
            ),
            SizedBox(height: height*.03,),
            PrimaryButton(
                height: height*.06,
                width: double.infinity,
                buttonText: 'Verify Number',
                onTap: (){}
            ),
          ],
        ),
      ),
    );
  }
}
