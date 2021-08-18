import 'package:flutter/material.dart';
import 'package:socialapp/screens/LandingPage/landingPage.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:socialapp/blocs/auth_bloc.dart';

class Home extends StatefulWidget {
  final User userf;

  const Home({Key key, this.userf}) : super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _build(),
    );
  }

  Widget _build() {
    return Container(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Logged In',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 20),
          CircleAvatar(
            backgroundImage: NetworkImage(widget.userf.photoURL),
            radius: 25.0,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Name: ${widget.userf.displayName}',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 15),
          Text(
            'Email: ${widget.userf.email}',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 20.0,
          ),
          SignInButton(Buttons.Facebook, text: 'Sign out of Facebook',
              onPressed: () async {
            var facebookProvider =
                Provider.of<FacebookSignInProvider>(context, listen: false);

            await facebookProvider.logout().whenComplete(() =>
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: Landingpage(), type: PageTransitionType.fade)));
          }),
        ]));
  }
}
