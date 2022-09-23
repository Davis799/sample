import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sample/contactsmodel.dart';
import 'package:sample/mongo/constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URI);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await userCollection.find().toList();
    return arrData;
  }

  static Future<String> insert(Contacts data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return " Contact successfully added ";
      } else
        return " Something went wrong! ";
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
