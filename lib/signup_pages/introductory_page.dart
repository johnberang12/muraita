import 'package:flutter/material.dart';
import 'package:muraita_apps/signup_pages/number_registration.dart';
import 'package:muraita_apps/signup_pages/signup_widgets/signup_button.dart';
import 'package:muraita_apps/widget/custom_primary_button.dart';

import '../constants.dart';
import '../widget/app_icon.dart';

class IntroductoryPage extends StatelessWidget {
   IntroductoryPage({Key? key}) : super(key: key);

   late  double height, width;

  @override
  Widget build(BuildContext context) {
  height = MediaQuery.of(context).size.height;
  width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: width*.10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  AppIcon(
                    avatarHeight: height*.07,
                    initialHeight: height*.11,
                  ),
                  Text('muraita',
                  style: TextStyle(
                    fontSize: height*.05,
                    fontWeight: FontWeight.bold,
                    color: kBlack80,
                  ),
                  ),
                  // SizedBox(height: height*.01,),
                  Text('SecondHand Local Market',
                  style: TextStyle(
                    fontSize: height*.02,
                    color: kBlack60,
                  ),
                  ),
                  SizedBox(height: height*.03,),
                    Text('Sell your old stuff or find stuffs you need from your neighbors',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: height*.02,
                        color: kBlack60,
                      ),
                  ),
                  SizedBox(height: height*.30,),
                  SignupButton(
                      height: height*.06,
                      width: double.infinity,
                      buttonText: 'Get started',
                      onTap: (){
                        Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context) => NumberRegistration(),
                        ));
                      },
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
