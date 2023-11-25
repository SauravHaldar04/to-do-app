import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_tutorial/screens/update.dart';
import 'package:flutter/material.dart';

class StatusProvider extends ChangeNotifier {
  void statusUpdate(bool isDone, String id, String userID) {
    isDone = !isDone;
    Map<String, dynamic> newUserMap;
    FirebaseFirestore.instance
        .collection(userID)
        .doc(id)
        .update(newUserMap = {"Status": isDone});
    notifyListeners();
  }
}
