// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/google_sign_in.dart';

class LoggedIn extends StatefulWidget {
  const LoggedIn({super.key});

  @override
  State<LoggedIn> createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Welcome",
            style: GoogleFonts.roboto(),
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(13, 17, 23, 1),
          actions: [
            TextButton(
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googleLogout();
                  // Navigator.pushNamed(context, "/homepage");
                },
                child: Text(
                  'Logout',
                  style: GoogleFonts.roboto(),
                ))
          ],
        ),
        body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Text(
              //   "Profile",
              //   style: GoogleFonts.roboto(
              //       fontSize: 25, fontWeight: FontWeight.w700),
              // ),
              SizedBox(height: 10),
              // CircleAvatar(
              //     radius: 77, backgroundImage: NetworkImage(user.photoURL!)),
              SizedBox(height: 30),
              // Text(
              //   "Name:  " + user.displayName!,
              //   style: GoogleFonts.roboto(fontSize: 20),
              // ),
              SizedBox(height: 10),
              Text(
                "Email:  " + user.email!,
                style: GoogleFonts.roboto(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                "Last sign in: " + user.metadata.lastSignInTime.toString(),
                style: GoogleFonts.roboto(fontSize: 20),
              )
            ])));
  }
}
