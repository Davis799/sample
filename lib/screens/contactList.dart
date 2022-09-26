import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sample/contactsmodel.dart';
import 'package:sample/mongo/mongodb.dart';
import 'package:sample/screens/update.dart';

import '../provider/google_sign_in.dart';
import 'addContact.dart';

class contactList extends StatefulWidget {
  const contactList({super.key});

  @override
  State<contactList> createState() => _contactListState();
}

class _contactListState extends State<contactList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(22, 27, 34, 1),
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
      floatingActionButton: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Color.fromRGBO(48, 54, 61, 1),
            borderRadius: BorderRadius.circular(50)),
        child: IconButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/addContact');
            },
            icon: Icon(Icons.add)),
      ),
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
                return Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 1, right: 1),
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: ((context, index) {
                          return displayCard(
                              Contacts.fromJson(snapshot.data[index]));
                        })),
                  ),
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
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.centerLeft,
        decoration: const BoxDecoration(
            color: Color.fromRGBO(13, 17, 23, 1),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${data.fname}",
                    style: GoogleFonts.roboto(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 5,
                ),
                Text("${data.lname}",
                    style:
                        GoogleFonts.roboto(fontSize: 18, color: Colors.white)),
                SizedBox(
                  height: 5,
                ),
                Text("${data.address}",
                    style:
                        GoogleFonts.roboto(fontSize: 18, color: Colors.white)),
                SizedBox(
                  height: 5,
                ),
                Text("${data.phone}",
                    style:
                        GoogleFonts.roboto(fontSize: 18, color: Colors.white))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Color.fromRGBO(48, 54, 61, 1),
                      minimumSize: Size(10, 10),
                      alignment: Alignment.center),
                  onPressed: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return update();
                                },
                                settings: RouteSettings(arguments: data)))
                        .then((value) {
                      setState(() {});
                    });
                  },
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 130,
                ),
                ElevatedButton(
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: const Color.fromRGBO(48, 54, 61, 1),
                        minimumSize: const Size(10, 10),
                        alignment: Alignment.center),
                    onPressed: () {
                      MongoDatabase.delete(data);
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
