// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:sample/config/theme.dart';
import 'package:sample/contactsmodel.dart';
import 'package:sample/mongo/mongodb.dart';
import 'package:sample/screens/contactlist.dart';
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

  Future _insertContact(
      String fname, String lname, String address, String phone) async {
    var id = M.ObjectId();
    final data = Contacts(
        id: id, fname: fname, lname: lname, address: address, phone: phone);
    var result = await MongoDatabase.insert(data);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "Contact successfully added " + fname,
        style: GoogleFonts.roboto(fontSize: 15),
      ),
      backgroundColor: Colors.green,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
    ));
    Navigator.pushNamed(context, "/contactList");
  }

  Future _updateContact(
      var id, String fname, String lname, String address, String phone) async {
    final updateData = Contacts(
        id: id, fname: fname, lname: lname, address: address, phone: phone);
    await MongoDatabase.update(updateData)
        .whenComplete(() => Navigator.pop(context));
  }

  void _clearAll() {
    fnamecontroller.text = " ";
    lnamecontroller.text = " ";
    addresscontroller.text = " ";
    phonecontroller.text = " ";
  }

  void fakedata() {
    setState(() {
      fnamecontroller.text = faker.person.firstName();
      lnamecontroller.text = faker.person.lastName();
      addresscontroller.text =
          faker.address.city() + "\n" + faker.address.streetName();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: theme().scaffoldBackgroundColor,
        floatingActionButton: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(60, 60),
            shape: const CircleBorder(),
            backgroundColor: theme().accentColor,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
          child: Icon(Icons.view_list_rounded),
        ),
        appBar: AppBar(
          title: Text(
            "Add Contact",
            style: GoogleFonts.roboto(fontSize: 30),
          ),
          centerTitle: true,
          backgroundColor: theme().primaryColorDark,
        ),
        body: SingleChildScrollView(
          child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Email:  " + user.email!,
                      style:
                          GoogleFonts.roboto(fontSize: 19, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Last sign in: " +
                          user.metadata.lastSignInTime.toString(),
                      style:
                          GoogleFonts.roboto(fontSize: 19, color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    // Center(
                    //   child: Text(
                    //     "Enter a contact",
                    //     style: GoogleFonts.roboto(
                    //         fontSize: 27,
                    //         fontWeight: FontWeight.bold,
                    //         color: Color.fromARGB(255, 255, 255, 255)),
                    //   ),
                    // ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: TextFormField(
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        controller: fnamecontroller,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: theme().cardColor,
                            hintText: "First name",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: TextFormField(
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        controller: lnamecontroller,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: theme().cardColor,
                            hintText: "Last name",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: TextFormField(
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        controller: addresscontroller,
                        minLines: 2,
                        maxLines: 3,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: theme().cardColor,
                            hintText: "Address",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: TextFormField(
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        keyboardType: TextInputType.number,
                        controller: phonecontroller,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: theme().cardColor,
                            hintText: "Phone number",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.all(15),
                                  side: BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  minimumSize: Size(115, 10),
                                  alignment: Alignment.center),
                              onPressed: fakedata,
                              child: Text(
                                "Generate",
                                style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              )),
                          ElevatedButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.all(15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: theme().backgroundColor,
                                  minimumSize: Size(115, 10),
                                  alignment: Alignment.center),
                              onPressed: () {
                                _insertContact(
                                    fnamecontroller.text.trim(),
                                    lnamecontroller.text.trim(),
                                    addresscontroller.text.trim(),
                                    phonecontroller.text.trim());
                              },
                              child: Text(
                                "Add",
                                style: GoogleFonts.roboto(fontSize: 20),
                              ))
                        ],
                      ),
                    )
                  ])),
        ));
  }
}
