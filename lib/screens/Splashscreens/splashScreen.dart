import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialapp/constants/Constantcolors.dart';
import 'package:socialapp/screens/LandingPage/landingPage.dart';
import 'package:socialapp/screens/UserProfilePage/userProfilePage.dart';

class Splashscreens extends StatefulWidget {
  @override
  _SplashscreensState createState() => _SplashscreensState();
}

class _SplashscreensState extends State<Splashscreens> {
  ConstantColors constantColors = ConstantColors();

  @override
  void initState() {
    Timer(Duration(seconds: 1), () {
      User user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: Landingpage(), type: PageTransitionType.leftToRight));
      } else {
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: UserProfilePage(user: user),
                type: PageTransitionType.bottomToTop));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.darkColor,
      body: Center(
        child: RichText(
          text: TextSpan(
            text: 'Socialize',
            style: TextStyle(
                fontFamily: 'Poppins',
                color: constantColors.blueColor,
                fontWeight: FontWeight.bold,
                fontSize: 40),
          ),
        ),
      ),
    );
  }
}
