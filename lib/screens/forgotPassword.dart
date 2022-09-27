// ignore_for_file: prefer_const_constructors
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample/config/theme.dart';
import 'package:sample/mongo/mongodb.dart';

import '../main.dart';

class forgotPass extends StatefulWidget {
  const forgotPass({super.key});

  @override
  State<forgotPass> createState() => _forgotPassState();
}

class _forgotPassState extends State<forgotPass> {
  final emailController = TextEditingController();

  Future _resetPass() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/resetPass');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Opps! ${e.message!}",
          style: GoogleFonts.roboto(fontSize: 15),
        ),
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      ));
      print(e);
    }
    navigatorKey.currentState!.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme().scaffoldBackgroundColor,
      body: SingleChildScrollView(
          child: Column(
        children: [
          SvgPicture.asset("assets/secure.svg", height: 320, width: 600),
          Padding(
              padding: EdgeInsets.only(left: 17, bottom: 20),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Forgot \nPassword?",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: theme().primaryColorLight),
                  ))),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 15, left: 20, right: 20),
            child: Text(
              "Don't worry! It happens. Please enter the address associated with your account",
              style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
          ),
          Padding(
              padding:
                  EdgeInsets.only(left: 17, bottom: 10, top: 10, right: 17),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: theme().cardColor,
                    prefixIcon: Icon(
                      Icons.alternate_email,
                      color: Colors.grey,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey, width: 1)),
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: 'Email ID'),
                style: GoogleFonts.roboto(
                    fontSize: 17, color: theme().primaryColorLight),
              )),
          Container(
              padding: EdgeInsets.only(top: 30, bottom: 10),
              child: TextButton(
                  // ignore: sort_child_properties_last
                  child: Text(
                    'Submit',
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      color: theme().primaryColorLight,
                    ),
                  ),
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      minimumSize: Size(350, 50),
                      backgroundColor: theme().backgroundColor,
                      alignment: Alignment.center),
                  onPressed: _resetPass)),
        ],
      )),
    );
  }
}
