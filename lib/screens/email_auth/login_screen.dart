//import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/screens/email_auth/signup_screen.dart';
import 'package:firebase_tutorial/screens/homescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();
  bool password = true;
  void login() async {
    String email = emailController.text.trim();
    String password = passController.text.trim();
    if (email == "" || password == "") {
      showModalBottomSheet(
        context: context,
        builder: (context) => const SizedBox(
          height: double.maxFinite,
          width: double.infinity,
          child: Center(
            child: Text(
              "Please fill all the fields",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
            ),
          ),
        ),
      );
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        //print('User signed in');
        if (userCredential.user != null) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => HomeScreen(
                    userID: email,
                  )));
        }
      } on FirebaseAuthException catch (e) {
        showModalBottomSheet(
          context: context,
          builder: (context) => SizedBox(
            height: double.maxFinite,
            width: double.infinity,
            child: Center(
              child: Text(
                e.toString(),
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              ),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          // style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        // backgroundColor: Color.fromARGB(255, 178, 36, 255),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email Address'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              obscureText: password,
              controller: passController,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      password = !password;
                    });
                  },
                  child: Icon(
                    (password == true)
                        ? (Icons.remove_red_eye)
                        : (Icons.remove_red_eye_outlined),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CupertinoButton.filled(
                child: const Text('Login'),
                onPressed: () {
                  login();
                }),
            const SizedBox(
              height: 20,
            ),
            CupertinoButton(
                child: const Text('Create an account'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignupScreen()));
                }),
          ]),
        ),
      ),
    );
  }
}
