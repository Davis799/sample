import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sample/contactsmodel.dart';
import 'package:sample/mongo/mongodb.dart';

import '../provider/google_sign_in.dart';

class contactList extends StatefulWidget {
  const contactList({super.key});

  @override
  State<contactList> createState() => _contactListState();
}

class _contactListState extends State<contactList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contacts",
          style: GoogleFonts.roboto(fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
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
      backgroundColor: Color.fromRGBO(22, 27, 34, 1),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: MongoDatabase.getData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                var totalData = snapshot.data.length;
                print(totalData.toString());
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 1, right: 1),
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: ((context, index) {
                              return displayCard(
                                  Contacts.fromJson(snapshot.data[index]));
                            })),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 292, bottom: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(70, 70),
                          shape: const CircleBorder(),
                          backgroundColor: Color.fromRGBO(48, 54, 61, 1),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/addContact');
                        },
                        child: Icon(Icons.add),
                      ),
                    ),
                  ],
                );
              } else {
                print("no data");
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                        child: Text("No contacts available",
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                color: Color.fromARGB(255, 254, 255, 255)))),
                    Container(
                      margin: EdgeInsets.only(top: 290, left: 292, bottom: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(70, 70),
                          shape: const CircleBorder(),
                          backgroundColor: Color.fromRGBO(48, 54, 61, 1),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/addContact');
                        },
                        child: Icon(Icons.add),
                      ),
                    ),
                  ],
                );
              }
            }),
      )),
    );
  }

  Widget displayCard(Contacts data) {
    return Card(
      child: Container(
        padding:
            const EdgeInsets.only(left: 14, top: 12, bottom: 14, right: 14),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Color.fromRGBO(13, 17, 23, 1),
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${data.fname}",
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 5,
            ),
            Text("${data.lname}",
                style: GoogleFonts.roboto(fontSize: 18, color: Colors.white)),
            SizedBox(
              height: 5,
            ),
            Text("${data.address}",
                style: GoogleFonts.roboto(fontSize: 18, color: Colors.white)),
            SizedBox(
              height: 5,
            ),
            Text("${data.phone}",
                style: GoogleFonts.roboto(fontSize: 18, color: Colors.white))
          ],
        ),
      ),
    );
  }
}
