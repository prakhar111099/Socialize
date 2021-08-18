import 'package:socialapp/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FacebookSignInProvider extends ChangeNotifier {
  final authService = AuthService();
  final fb = FacebookLogin();
  bool _isSigningIn;

  FacebookSignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
  }

  Future<User> loginFacebook() async {
    print('Starting Facebook Login');
    _isSigningIn = true;
    FacebookLoginResult res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email
    ]);

    switch (res.status) {
      case FacebookLoginStatus.success:
        print('It worked');

        //Get Token
        final FacebookAccessToken fbToken = res.accessToken;

        //Convert to Auth Credential
        final AuthCredential credential =
            FacebookAuthProvider.credential(fbToken.token);

        //$path = "{$this->graphUrl}/{$this->version}/{$userID}/picture?type=large&redirect=false&access_token={$access_token}";

        //User Credential to Sign in with Firebase
        final result = await authService.signInWithCredentail(credential);

        final graphResponse = await http.get(
            'https://graph.facebook.com/v11.0/${result.user.providerData[0].uid}/picture?type=large&redirect=?type=large&redirect=false&access_token=${fbToken.token}');
        // final profile = JSON.decode(graphResponse.body);
        print(graphResponse);

        // Get profile data
        final profile = await fb.getUserProfile();
        print('Hello, ${profile.name}! You ID: ${profile.userId}');
        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');

        // Get email (since we request email permission)
        final email = await fb.getUserEmail();
        // But user can decline permission
        if (email != null) print('And your email is $email');

        //print('${result.user.displayName} is now logged in');
        return result.user;

        break;
      case FacebookLoginStatus.cancel:
        print('The user canceled the login');
        break;
      case FacebookLoginStatus.error:
        print('There was an error');
        break;
    }
  }

  Future logout() async {
    await authService.logout();

    isSigningIn = false;
  }
}
