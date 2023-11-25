//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/screens/email_auth/login_screen.dart';
//import 'package:firebase_tutorial/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_tutorial/screens/phone_auth/signupPhone.dart';
import 'package:rename/rename.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Welcome to My App',
          // style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        // backgroundColor: Color.fromARGB(255, 178, 36, 255),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(children: [
              Text(
                'Choose a sign in method',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 25),
              SizedBox(
                width: 200,
                child: TextButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                      ),
                    ),
                    // backgroundColor: MaterialStatePropertyAll(Colors.purple),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                  },
                  child: Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              SizedBox(
                width: 200,
                child: TextButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                      ),
                    ),
                    // backgroundColor: MaterialStatePropertyAll(Colors.purple),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const PhoneSignin()),
                    );
                  },
                  child: Text(
                    'Phone No',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
