// ignore_for_file: prefer_const_constructors
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ))),
          Padding(
              padding:
                  EdgeInsets.only(left: 17, bottom: 15, top: 10, right: 17),
              child: TextFormField(
                obscureText: invisible1,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_rounded),
                  suffixIcon: GestureDetector(
                      onTap: togglePass1,
                      child: Icon(
                        invisible1
                            ? Icons.visibility_off
                            : Icons.visibility_sharp,
                      )),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 195, 194, 194))),
                  border: InputBorder.none,
                  hintText: 'New password',
                ),
                style: TextStyle(
                    fontSize: 17, color: Color.fromARGB(255, 0, 0, 0)),
              )),
          Padding(
              padding:
                  EdgeInsets.only(left: 17, bottom: 15, top: 10, right: 17),
              child: TextFormField(
                obscureText: invisible2,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_rounded),
                  suffixIcon: GestureDetector(
                      onTap: togglePass2,
                      child: Icon(
                        invisible2
                            ? Icons.visibility_off
                            : Icons.visibility_sharp,
                      )),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 195, 194, 194))),
                  border: InputBorder.none,
                  hintText: 'Confirm New Password',
                ),
                style: TextStyle(
                    fontSize: 17, color: Color.fromARGB(255, 0, 0, 0)),
              )),
          Container(
              padding: EdgeInsets.only(top: 25, bottom: 10),
              child: TextButton(
                // ignore: sort_child_properties_last
                child: Text(
                  'Submit',
                  style: TextStyle(
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
                onPressed: () {},
              )),
        ],
      )),
    );
  }
}
