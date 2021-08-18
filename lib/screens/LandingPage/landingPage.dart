import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/blocs/auth_bloc.dart';
import 'package:socialapp/constants/Constantcolors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/provider/google_sign_in.dart';
import 'package:socialapp/screens/UserProfilePage/userProfilePage.dart';
import 'package:socialapp/screens/LandingPage/home.dart';

class Landingpage extends StatelessWidget {
  final ConstantColors constantColors = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.whiteColor,
      body: Consumer2<GoogleSignInProvider, FacebookSignInProvider>(
        builder: (context, googleProvider, facebookProvider, child) {
          if (googleProvider.isSigningIn || facebookProvider.isSigningIn) {
            return Stack(
              children: [
                _buildBackgroundGradient(),
                Center(child: CircularProgressIndicator()),
              ],
            );
          } else {
            return _buildLoginScreenUI(context);
          }
        },
      ),
    );
  }

  Widget _buildLoginScreenUI(BuildContext context) {
    return Stack(
      children: [
        _buildBackgroundGradient(),
        _buildImage(context),
        taglineText(),
        _buildSocialButton(context),
        _createdByText(context),
      ],
    );
  }

  // region Background Gradient
  Widget _buildBackgroundGradient() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
            0.5,
            0.9
          ],
              colors: [
            constantColors.blueGreyColor,
            constantColors.darkColor,
          ])),
    );
  }
  // endregion

  //region Build Image
  Widget _buildImage(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        //  color: Colors.yellow,
        height: MediaQuery.of(context).size.height * .50,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/loginsheet.png'),
          ),
        ),
      ),
    );
  }
  //endregion

  //region Build Socialize Text
  Widget taglineText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(top: 50, left: 16),
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
  //endregion

  //region Build Social Button
  Widget _buildSocialButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(top: 270),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () async {
                handleGoogleSignIn(context);
              },
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
              onTap: () async {
                var authBloc =
                    Provider.of<FacebookSignInProvider>(context, listen: false);
                final user = await authBloc.loginFacebook();
                if (user != null) {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: Home(userf: user),
                          type: PageTransitionType.bottomToTop));
                }
              },
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
      ),
    );
  }
  //endregion

  //region Build Created By
  Widget _createdByText(BuildContext context) {
    return Align(
      child: Container(
        margin: EdgeInsets.only(top: 370),
        child: Text("Created by Prakhar Srivastava ",
            style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.grey.shade600,
                fontSize: 12.0)),
      ),
    );
  }
  //endregion

  //region Handle Google Sign in
  void handleGoogleSignIn(BuildContext context) async {
    var isError = false;
    var googleProvider =
        Provider.of<GoogleSignInProvider>(context, listen: false);
    final user = await googleProvider.login().catchError((error) {
      isError = true;
    });

    if (isError == false && user != null) {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: UserProfilePage(user: user),
              type: PageTransitionType.bottomToTop));
    }
  }
  //endregion
}
