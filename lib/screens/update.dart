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

class update extends StatefulWidget {
  const update({super.key});

  @override
  State<update> createState() => _updateState();
}

class _updateState extends State<update> {
  final user = FirebaseAuth.instance.currentUser!;
  final fnamecontroller = TextEditingController();
  final lnamecontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final phonecontroller = TextEditingController();

  Future _updateContact(
      var id, String fname, String lname, String address, String phone) async {
    final updateData = Contacts(
        id: id, fname: fname, lname: lname, address: address, phone: phone);
    await MongoDatabase.update(updateData)
        .whenComplete(() => Navigator.pop(context));
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
    Contacts data = ModalRoute.of(context)?.settings.arguments as Contacts;
    if (data != null) {
      fnamecontroller.text = data.fname;
      lnamecontroller.text = data.lname;
      addresscontroller.text = data.address;
      phonecontroller.text = data.phone;
    }
    return Scaffold(
        backgroundColor: Color.fromRGBO(22, 27, 34, 1),
        appBar: AppBar(
          title: Text(
            "Update Contact",
            style: GoogleFonts.roboto(fontSize: 30),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
        ),
        floatingActionButton: ElevatedButton(
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
        body: SingleChildScrollView(
          child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
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
                            fillColor: Color.fromRGBO(13, 17, 23, 1),
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
                            fillColor: Color.fromRGBO(13, 17, 23, 1),
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
                            fillColor: Color.fromRGBO(13, 17, 23, 1),
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
                            fillColor: Color.fromRGBO(13, 17, 23, 1),
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
                                _updateContact(
                                    data.id,
                                    fnamecontroller.text,
                                    lnamecontroller.text,
                                    addresscontroller.text,
                                    phonecontroller.text);
                              },
                              child: Text(
                                "Update",
                                style: GoogleFonts.roboto(fontSize: 20),
                              ))
                        ],
                      ),
                    )
                  ])),
        ));
  }
}
