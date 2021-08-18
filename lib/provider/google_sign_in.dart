import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  bool _isSigningIn;

  GoogleSignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future<User> login() async {
    isSigningIn = true;
    var errorMessage;

    try {
      GoogleSignInAccount googleAccount = await googleSignIn.signIn();

      if (googleAccount == null) {
        isSigningIn = false;
        errorMessage = "CANCELLED_SIGN_IN";
        return Future.error(errorMessage);
      }

      GoogleSignInAuthentication googleSignInAuthentication =
          await googleAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user;
    } catch (error) {
      switch (error.code) {
        case "ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL":
          errorMessage = "Account already exists with a different credential.";
          break;
        case "ERROR_INVALID_CREDENTIAL":
          errorMessage = "Invalid credential.";
          break;
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened. ";
      }

      if (errorMessage != null) {
        return Future.error(errorMessage);
      }
      return null;
    }
  }

  Future logout() async {
    await googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
    isSigningIn = false;
  }
}
