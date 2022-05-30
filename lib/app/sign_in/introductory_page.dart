import 'package:flutter/material.dart';
import '../../common_widgets/app_icon.dart';
import '../../constants.dart';
import '../sign_in/signin_widgets/signup_button.dart';
import 'number_registration.dart';


class IntroductoryPage extends StatelessWidget {
   IntroductoryPage({Key? key}) : super(key: key);

   late  double height, width;



  @override
  Widget build(BuildContext context) {
    print('entered introductory page');
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
                children:  _buildChildren(context),
              ),
            ),
          ),
        )
    );
  }

   List<Widget> _buildChildren(BuildContext context) {
     return [
       AppIcon(
         avatarHeight: height*.07,
         initialHeight: height*.11,
       ),
       kLogoName,
       kLogoHook,
       SizedBox(height: height*.03,),
       kIntroductoryTitle,
       SizedBox(height: height*.30,),
       SignupButton(
         height: height*.06,
         width: double.infinity,
         buttonText: 'Get started',
         onTap: () => _pushToNumberRegistration(context),
       ),
     ];
   }
   
   Future<void> _pushToNumberRegistration(context) async {

    Navigator.push(
        context, MaterialPageRoute(
      builder: (context) => NumberRegistration.create(context),
    ));
   }
   
}
