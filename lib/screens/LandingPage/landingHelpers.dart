import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/constants/Constantcolors.dart';

class LandingHelpers with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();

  Widget bodyImage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .80,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/loginsheet.png'))),
    );
  }

  Widget taglineText(BuildContext context) {
    return Positioned(
      top: 460.0,
      left: 10.0,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 280.0,
        ),
        child: RichText(
          text: TextSpan(
              text: 'Ready ',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: constantColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
              children: <TextSpan>[
                TextSpan(
                  text: 'To ',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: constantColors.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ),
                TextSpan(
                  text: 'Socialize',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: constantColors.blueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ),
                TextSpan(
                  text: '?',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: constantColors.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                )
              ]),
        ),
      ),
    );
  }

  Widget mainButton(BuildContext context) {
    return Positioned(
        top: 590.0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: Container(
                  child: Icon(FontAwesomeIcons.google,
                      color: constantColors.redColor),
                  width: 150.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                      border: Border.all(color: constantColors.redColor),
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              GestureDetector(
                child: Container(
                  child: Icon(FontAwesomeIcons.facebookF,
                      color: constantColors.blueColor),
                  width: 150.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                      border: Border.all(color: constantColors.blueColor),
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              )
            ],
          ),
        ));
  }

  Widget textt(BuildContext context) {
    return Positioned(
      top: 652.0,
      left: 20.0,
      right: 20.0,
      child: Container(
        child: Column(
          children: [
            Text("Created by Prakhar Srivastava ",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.grey.shade600,
                    fontSize: 12.0)),
          ],
        ),
      ),
    );
  }
}
