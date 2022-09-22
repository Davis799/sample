// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:faker/faker.dart';
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
  final fnamecontroller = TextEditingController();
  final lnamecontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future fakedata() async {
      fnamecontroller.text = faker.person.firstName();
      lnamecontroller.text = faker.person.lastName();
      addresscontroller.text =
          faker.address.city() + ", " + faker.address.streetName();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Welcome",
            style: GoogleFonts.roboto(fontSize: 30),
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(13, 17, 23, 1),
          actions: [
            IconButton(
                icon: Icon(Icons.logout_rounded, size: 33),
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googleLogout();
                }),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      style: GoogleFonts.roboto(fontSize: 17),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Last sign in: " +
                          user.metadata.lastSignInTime.toString(),
                      style: GoogleFonts.roboto(fontSize: 17),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        "Enter a contact",
                        style: GoogleFonts.roboto(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 20, 20, 1)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 13),
                      child: TextFormField(
                        controller: fnamecontroller,
                        decoration: InputDecoration(
                          hintText: "First name",
                          hintStyle: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 13),
                      child: TextFormField(
                        controller: lnamecontroller,
                        decoration: InputDecoration(
                          hintText: "Last name",
                          hintStyle: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 13),
                      child: TextFormField(
                        controller: addresscontroller,
                        decoration: InputDecoration(
                          hintText: "Address",
                          hintStyle: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 13),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: phonecontroller,
                        decoration: InputDecoration(
                          hintText: "Phone number",
                          hintStyle: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.all(15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor:
                                      Color.fromRGBO(13, 17, 23, 1),
                                  minimumSize: Size(115, 10),
                                  alignment: Alignment.center),
                              onPressed: fakedata,
                              child: Text(
                                "Generate",
                                style: GoogleFonts.roboto(fontSize: 20),
                              )),
                          ElevatedButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.all(15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor:
                                      Color.fromRGBO(13, 17, 23, 1),
                                  minimumSize: Size(115, 10),
                                  alignment: Alignment.center),
                              onPressed: () {},
                              child: Text(
                                "Add",
                                style: GoogleFonts.roboto(fontSize: 20),
                              ))
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin:
                              EdgeInsets.only(top: 79, left: 279, bottom: 10),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(80, 80),
                                shape: const CircleBorder(),
                                backgroundColor: Color.fromRGBO(13, 17, 23, 1),
                              ),
                              onPressed: () {},
                              child: Text(
                                "View",
                                style: GoogleFonts.roboto(fontSize: 20),
                              )),
                        ),
                      ],
                    )
                  ])),
        ));
  }
}
