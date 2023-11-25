import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_tutorialase_tutorialase_tutorialase_tutorial/screens/update.dart';
import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  void updateTask(String title, String description, String id, String userID) {
    Map<String, dynamic> newUserMap;
    FirebaseFirestore.instance
        .collection(userID)
        .doc(id)
        .update(newUserMap = {"Title": title, "Description": description});
    notifyListeners();
  }
}
