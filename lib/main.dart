//import 'dart:developer';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_tutorial/firebase_options.dart';
//import 'package:firebase_tutorial/screens/email_auth/login_screen.dart';
//import 'package:firebase_tutorial/screens/email_auth/login_screen.dart';
import 'package:firebase_tutorial/screens/intial_screen.dart';
import 'package:firebase_tutorial/screens/status_provider.dart';
import 'package:firebase_tutorial/screens/taskprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/homescreen.dart';
import 'package:rename/rename.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //     .collection('users')
  //     .doc("OMFerdTHrfT0yalWMmZe")
  //     .get();
  // print(snapshot.data());
  // Map<String, dynamic> newUserData = {
  //   "Name": "Pankaj Tripathi",
  //   "Email": "pankaj3pathi@gmail.com",
  //   "Phone no": 998765432
  // };
  // _firestore.collection("users").doc("id-goes-here").delete();
  // print("User Deleted!!");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        ChangeNotifierProvider(create: (context) => StatusProvider())
      ],
      child: MaterialApp(
        theme: ThemeData.dark(
          useMaterial3: true,
          // colorSchemeSeed: const Color.fromARGB(255, 255, 143, 30),
          // appBarTheme: const AppBarTheme(
          //     foregroundColor: Colors.white,
          //     backgroundColor: Color.fromARGB(255, 255, 157, 59)),
        ).copyWith(),
        debugShowCheckedModeBanner: false,
        home: (FirebaseAuth.instance.currentUser != null)
            ? HomeScreen(
                userID: FirebaseAuth.instance.currentUser!.email,
              )
            : const InitialScreen(),
      ),
    );
  }
}
