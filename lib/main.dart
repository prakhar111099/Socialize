import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/constants/Constantcolors.dart';
import 'package:socialapp/provider/google_sign_in.dart';
import 'package:socialapp/screens/Splashscreens/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:socialapp/blocs/auth_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ConstantColors constantColors = ConstantColors();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (_) => FacebookSignInProvider()),
      ],
      child: MaterialApp(
        home: Splashscreens(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            accentColor: constantColors.blueColor,
            fontFamily: 'Poppins',
            canvasColor: Colors.transparent),
      ),
    );
  }
}
