// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:sample/contactsmodel.dart';
import 'package:sample/mongo/mongodb.dart';
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
        "Contact successfully added. ID:" + id.$oid,
        style: GoogleFonts.roboto(fontSize: 15),
      ),
      backgroundColor: Colors.green,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
    ));
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
        backgroundColor: Color.fromRGBO(22, 27, 34, 1),
        appBar: AppBar(
          title: Text(
            "Add Contact",
            style: GoogleFonts.roboto(fontSize: 30),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
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
                    //   style: GoogleFonts.roboto(fontSize: 19),
                    // ),
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
                          backgroundColor: Color.fromRGBO(48, 54, 61, 1),
                        ),
                        controller: fnamecontroller,
                        decoration: InputDecoration(
                          hintText: "First name",
                          hintStyle: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: TextFormField(
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors.white,
                          backgroundColor: Color.fromRGBO(48, 54, 61, 1),
                        ),
                        controller: lnamecontroller,
                        decoration: InputDecoration(
                          hintText: "Last name",
                          hintStyle: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: TextFormField(
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors.white,
                          backgroundColor: Color.fromRGBO(48, 54, 61, 1),
                        ),
                        controller: addresscontroller,
                        minLines: 2,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Address",
                          hintStyle: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: TextFormField(
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors.white,
                          backgroundColor: Color.fromRGBO(48, 54, 61, 1),
                        ),
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
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.all(15),
                                  side: BorderSide(
                                    width: 2,
                                    color: Color.fromRGBO(48, 54, 61, 1),
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
                                  backgroundColor:
                                      Color.fromRGBO(48, 54, 61, 1),
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
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin:
                              EdgeInsets.only(top: 125, left: 292, bottom: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(70, 70),
                              shape: const CircleBorder(),
                              backgroundColor: Color.fromRGBO(48, 54, 61, 1),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/');
                            },
                            child: Icon(Icons.view_list_rounded),
                          ),
                        ),
                      ],
                    )
                  ])),
        ));
  }
}
