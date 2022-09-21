// ignore_for_file: prefer_const_constructors
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class resetPass extends StatefulWidget {
  const resetPass({super.key});

  @override
  State<resetPass> createState() => _resetPassState();
}

class _resetPassState extends State<resetPass> {
  bool invisible1 = true;
  bool invisible2 = true;
  void togglePass1() {
    setState(() {
      invisible1 = !invisible1;
    });
  }

  void togglePass2() {
    setState(() {
      invisible2 = !invisible2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 251, 249, 249),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
              padding: EdgeInsets.only(top: 40, bottom: 40),
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset("assets/padlock.svg",
                  height: 200, width: 600)),
          Padding(
              padding: EdgeInsets.only(left: 17, bottom: 20),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Reset \nPassword",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ))),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 15, left: 20, right: 20),
            child: Text(
              "A Link has been sent to your email. Click it to reset your Password",
              style: GoogleFonts.openSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(134, 144, 157, 1)),
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 25, bottom: 10),
              child: TextButton(
                // ignore: sort_child_properties_last
                child: Text(
                  'Okay',
                  style: GoogleFonts.openSans(
                    fontSize: 20.0,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                style: TextButton.styleFrom(
                    padding: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    minimumSize: Size(350, 50),
                    backgroundColor: Color.fromRGBO(1, 101, 255, 1),
                    alignment: Alignment.center),
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
              )),
        ],
      )),
    );
  }
}
