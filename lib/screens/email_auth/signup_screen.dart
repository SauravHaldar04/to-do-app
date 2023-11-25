// import 'login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // late BuildContext context;
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  final TextEditingController cpassController = TextEditingController();

  void createUser() async {
    String email = emailController.text.trim();
    String password = passController.text.trim();
    String cpassword = cpassController.text.trim();
    if (email == "" || password == "" || cpassword == "") {
      showModalBottomSheet(
        context: context,
        builder: (context) => const SizedBox(
          height: double.minPositive,
          width: double.infinity,
          child: Center(
            child: Text(
              "Please fill all the fields",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
            ),
          ),
        ),
      );
      // print(C);
    } else if (password != cpassword) {
      showModalBottomSheet(
        context: context,
        builder: (context) => const SizedBox(
          height: double.minPositive,
          width: double.infinity,
          child: Center(
            child: Text(
              "Password don't match",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
            ),
          ),
        ),
      );
      //print("Password don't match");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        showModalBottomSheet(
          context: context,
          builder: (context) => const SizedBox(
            height: double.minPositive,
            width: double.infinity,
            child: Center(
              child: Text(
                "User created !!",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              ),
            ),
          ),
        );
        if (userCredential.user != null) {
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (e) {
        showModalBottomSheet(
          context: context,
          builder: (context) => SizedBox(
            height: double.minPositive,
            width: double.infinity,
            child: Center(
              child: Text(
                e.code.toString(),
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
          'Sign Up',
          // style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        // backgroundColor: const Color.fromARGB(255, 178, 36, 255),
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
              controller: passController,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: cpassController,
              decoration: const InputDecoration(labelText: ' Confirm Password'),
            ),
            const SizedBox(
              height: 20,
            ),
            CupertinoButton.filled(
                child: const Text('Create an account'),
                onPressed: () {
                  createUser();
                }),
          ]),
        ),
      ),
    );
  }
}
