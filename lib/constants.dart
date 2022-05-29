import 'package:flutter/material.dart';


const kPrimaryHue = Color(0xffffbf00);
const kPrimaryTint80 = Color(0xffffd147);
const kPrimaryTint60 = Color(0xffffde7c);
const kPrimaryTint40 = Color(0xfffbe4a0);
const kPrimaryTint20 = Color(0xfffff4d3);


const kBlack80 = Color(0xff474747);
const kBlack60 = Color(0xff767676);
const kBlack40 = Color(0xffb1b1b1);
const kBlack20 = Color(0xffd9d9d9);
const kBlack10 = Color(0xffefefef);


const kHeadline1Style = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
  color: kBlack80,);



//////////////----Introductory page Strings----//////////////////////////
const kLogoName = Text('muraita',
style:  TextStyle(
fontSize: 30,
fontWeight: FontWeight.bold,
color: kBlack80,));

const kLogoHook = Text('SecondHand Local Market',
  style: TextStyle(
    fontSize: 20,
    color: kBlack60,));
const kIntroductoryTitle = Text('Sell your old stuff or find stuffs you need from your neighbors',
  textAlign: TextAlign.center,
  style: TextStyle(
    fontSize: 16,
    color: kBlack60,
  ),
);

//////////////----Number Registration Strings----//////////////////////////
const kNumberRegistrationTitle = Text('Welcome', style: kHeadline1Style,);
const kNumberRegistrationSubTitle = Text(
  'Please register using your phone number.',
  textAlign: TextAlign.center,
  style: TextStyle(fontSize: 20));
const kNumberRegistrationBody = Text(
  'Your phone number is kept safe.\nIt won\'t be disclose to anyone.',
  textAlign: TextAlign.center,
  style: TextStyle(fontSize: 16,));

//////////////----Otp Verification page Strings----//////////////////////////



//////////////----Name Registration Page Strings----//////////////////////////
const kNameRegistrationTitle =  Text('Wait!', textAlign: TextAlign.start,
style: kHeadline1Style,
);
const kNameRegistrationSubTitle = Text('there\'s one more.', textAlign: TextAlign.end,
style: TextStyle(
fontSize: 18,
),);
const kNameRegistrationBody = Text('Introduce your self.');