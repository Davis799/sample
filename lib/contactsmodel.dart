// To parse this JSON data, do
//
//     final contacts = contactsFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

Contacts contactsFromJson(String str) => Contacts.fromJson(json.decode(str));

String contactsToJson(Contacts data) => json.encode(data.toJson());

class Contacts {
  Contacts({
    required this.id,
    required this.fname,
    required this.lname,
    required this.address,
    required this.phone,
  });

  ObjectId id;
  String fname;
  String lname;
  String address;
  String phone;

  factory Contacts.fromJson(Map<String, dynamic> json) => Contacts(
        id: json["_id"],
        fname: json["fname"],
        lname: json["lname"],
        address: json["address"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fname": fname,
        "lname": lname,
        "address": address,
        "phone": phone,
      };
}
