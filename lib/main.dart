// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/google_sign_in.dart';
import 'screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/signup.dart';
import 'screens/forgotPassword.dart';
import 'screens/otp.dart';
import 'screens/resetPassword.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create: (context) => GoogleSignInProvider(),
    child: MaterialApp(
      title: "SkyConnect-init",
      initialRoute: "/",
      routes: {
        "/": (context) => login(),
        "/signup": (context) => signup(),
        "/forgetPass": (context) => forgotPass(),
        "/OTP": (context) => otp(),
        "/resetPass": (context) => resetPass()
      },
    ),
  ));
}
//0721