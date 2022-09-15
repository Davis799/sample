// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/signup.dart';
import 'screens/forgotPassword.dart';

void main() {
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    title: "SkyConnect-init",
    initialRoute: "/",
    routes: {
      "/": (context) => login(),
      "/signup": (context) => signup(),
      "/forgetPass": (context) => forgotPass()
    },
  ));
}
