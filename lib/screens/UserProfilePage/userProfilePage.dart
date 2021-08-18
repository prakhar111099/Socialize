import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/provider/google_sign_in.dart';
import 'package:socialapp/screens/LandingPage/landingPage.dart';

class UserProfilePage extends StatefulWidget {
  final User user;

  const UserProfilePage({Key key, this.user}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Logged In',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          CircleAvatar(
            maxRadius: 25,
            backgroundImage: NetworkImage(widget.user.photoURL),
          ),
          SizedBox(height: 8),
          Text(
            'Name: ${widget.user.displayName}',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            'Email: ${widget.user.email}',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          TextButton(
              onPressed: () async {
                var googleProvider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                await googleProvider.logout().whenComplete(() =>
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: Landingpage(),
                            type: PageTransitionType.fade)));
              },
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
