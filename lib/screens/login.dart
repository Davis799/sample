// ignore_for_file: prefer_const_constructors
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sample/config/theme.dart';

import '../main.dart';
import '../provider/google_sign_in.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool invisible = true;
  void togglePass() {
    setState(() {
      invisible = !invisible;
    });
  }

  final emailController = TextEditingController();
  final passController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  Future _logIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passController.text.trim());
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
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: Scaffold(
        backgroundColor: theme().scaffoldBackgroundColor,
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset("assets/office.svg", height: 332, width: 600),
            Padding(
                padding: EdgeInsets.only(left: 17, bottom: 20),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Login",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.roboto(
                            color: theme().primaryColorLight,
                            fontSize: 40,
                            fontWeight: FontWeight.bold)))),
            Padding(
                padding: EdgeInsets.only(left: 17, bottom: 10, right: 17),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: theme().cardColor,
                      prefixIcon: Icon(
                        Icons.alternate_email,
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      border: InputBorder.none,
                      hintText: 'Enter Your Email',
                      hintStyle: TextStyle(color: Colors.grey)),
                  style: GoogleFonts.roboto(
                      fontSize: 18, color: theme().primaryColorLight),
                )),
            Padding(
                padding: EdgeInsets.only(left: 17, right: 17, bottom: 10),
                child: TextFormField(
                  controller: passController,
                  textInputAction: TextInputAction.next,
                  obscureText: invisible,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: theme().cardColor,
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                        color: Colors.grey,
                      ),
                      suffixIcon: GestureDetector(
                          onTap: togglePass,
                          child: Icon(
                            invisible
                                ? Icons.visibility_off
                                : Icons.visibility_sharp,
                            color: Colors.grey,
                          )),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      border: InputBorder.none,
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey)),
                  style: GoogleFonts.roboto(fontSize: 18, color: Colors.white),
                )),
            Padding(
                padding: EdgeInsets.only(right: 17, top: 5, bottom: 20),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, "/forgotPass"),
                        child: Text(
                          "Forgot Password?",
                          textAlign: TextAlign.right,
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white),
                        )))),
            TextButton(
                // ignore: sort_child_properties_last
                child: Text(
                  'Login',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                style: TextButton.styleFrom(
                    padding: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    minimumSize: Size(350, 50),
                    backgroundColor: theme().accentColor,
                    alignment: Alignment.center),
                onPressed: _logIn),
            Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "OR",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Color.fromRGBO(139, 148, 158, 1)),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: TextButton(
                      // ignore: sort_child_properties_last
                      child: Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/google.svg",
                              width: 25,
                              height: 25,
                            ),
                            Text(
                              '  Login with Google',
                              style: GoogleFonts.roboto(
                                fontSize: 19,
                                color: theme().primaryColor,
                              ),
                            ),
                          ]),
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.all(13),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          minimumSize: Size(350, 50),
                          backgroundColor: Colors.white,
                          alignment: Alignment.center),
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.googleLogin();
                        //Navigator.pushNamed(context, "/homepage");
                      },
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 15),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text.rich(TextSpan(style: GoogleFonts.roboto(),
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              TextSpan(
                                  text: "New to SkyConnect?",
                                  style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      color: Color.fromRGBO(139, 148, 158, 1))),
                              TextSpan(
                                  text: "  Register",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(context, '/signup');
                                    },
                                  style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))
                            ])))),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
