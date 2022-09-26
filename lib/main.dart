// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/mongo/mongodb.dart';
import 'package:sample/provider/google_sign_in.dart';
import 'package:sample/screens/addContact.dart';
import 'package:sample/screens/contactlist.dart';
import 'screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/signup.dart';
import 'screens/forgotPassword.dart';
import 'screens/otp.dart';
import 'screens/resetPassword.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  await Firebase.initializeApp();

  runApp(ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        initialRoute: '/',
        routes: {
          '/': (context) => homepage(),
          '/signup': (context) => signup(),
          '/login': (context) => login(),
          '/addContact': (context) => LoggedIn(),
          '/forgotPass': (context) => forgotPass(),
          '/otp': (context) => otp(),
          '/resetPass': (context) => resetPass(),
          '/contactList': (context) => contactList(),
        },
      )));
}

class homepage extends StatelessWidget {
  const homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return contactList();
          } else if (snapshot.hasError) {
            return Center(child: Text("Something went wrong!"));
          } else {
            return login();
          }
        });
  }
}
//0721