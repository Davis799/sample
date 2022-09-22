// ignore_for_file: prefer_const_constructors
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample/mongo/mongodb.dart';

import '../main.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  bool invisible = true;
  void togglePass() {
    setState(() {
      invisible = !invisible;
    });
  }

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  Future _signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passController.text.trim());
      //Navigator.pushNamed(context, '/');
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
      backgroundColor: Color.fromARGB(255, 251, 249, 249),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SvgPicture.asset("assets/teamwork.svg", height: 285, width: 600),
          Padding(
              padding: EdgeInsets.only(left: 17, bottom: 20, top: 5),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sign up",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ))),
          Padding(
              padding: EdgeInsets.only(left: 17, bottom: 13, right: 17),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.alternate_email),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 195, 194, 194))),
                    border: InputBorder.none,
                    hintText: 'Enter Your Email'),
                style: GoogleFonts.openSans(
                    fontSize: 17, color: Color.fromARGB(255, 0, 0, 0)),
              )),
          Padding(
              padding: EdgeInsets.only(left: 17, right: 17, bottom: 13),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_rounded),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 195, 194, 194))),
                  border: InputBorder.none,
                  hintText: 'Full name',
                ),
                style: GoogleFonts.openSans(
                    fontSize: 17, color: Color.fromARGB(255, 0, 0, 0)),
              )),
          Padding(
              padding: EdgeInsets.only(left: 17, right: 17, bottom: 13),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 195, 194, 194))),
                  border: InputBorder.none,
                  hintText: 'Mobile',
                ),
                style: GoogleFonts.openSans(
                    fontSize: 17, color: Color.fromARGB(255, 0, 0, 0)),
              )),
          Padding(
              padding: EdgeInsets.only(left: 17, right: 17, bottom: 10),
              child: TextFormField(
                controller: passController,
                textInputAction: TextInputAction.next,
                obscureText: invisible,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_rounded),
                  suffixIcon: GestureDetector(
                      onTap: togglePass,
                      child: Icon(
                        invisible
                            ? Icons.visibility_off
                            : Icons.visibility_sharp,
                      )),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 195, 194, 194))),
                  border: InputBorder.none,
                  hintText: 'Password  (min 6 characters)',
                ),
                style: GoogleFonts.roboto(
                    fontSize: 17, color: Color.fromARGB(255, 0, 0, 0)),
              )),
          Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
              child: Align(
                  alignment: Alignment.center,
                  child: Text.rich(TextSpan(style: GoogleFonts.openSans(),
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        TextSpan(
                            text: "By signing up, you agree to our",
                            style: GoogleFonts.openSans(
                                fontSize: 15,
                                color: Color.fromARGB(255, 117, 123, 132))),
                        TextSpan(
                            text: "  Terms & Conditions",
                            style: GoogleFonts.openSans(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(1, 101, 255, 1))),
                        TextSpan(
                            text: " and ",
                            style: GoogleFonts.openSans(
                                fontSize: 15,
                                color: Color.fromARGB(255, 117, 123, 132))),
                        TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(1, 101, 255, 1)))
                      ])))),
          Container(
              padding: EdgeInsets.only(top: 20),
              child: TextButton(
                  // ignore: sort_child_properties_last
                  child: Text(
                    'Continue',
                    style: GoogleFonts.openSans(
                      fontSize: 17.0,
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
                  onPressed: _signIn)),
          Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Align(
                  alignment: Alignment.center,
                  child: Text.rich(TextSpan(style: GoogleFonts.openSans(),
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        TextSpan(
                            text: "Joined us before?",
                            style: GoogleFonts.openSans(
                                fontSize: 15,
                                color: Color.fromARGB(255, 117, 123, 132))),
                        TextSpan(
                            text: "  Login",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, '/login');
                              },
                            style: GoogleFonts.openSans(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(1, 101, 255, 1)))
                      ])))),
        ],
      )),
    );
  }
}
