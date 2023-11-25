import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PhoneSignin extends StatefulWidget {
  const PhoneSignin({super.key});

  @override
  State<PhoneSignin> createState() => _PhoneSigninState();
}

class _PhoneSigninState extends State<PhoneSignin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 178, 36, 255),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            const TextField(
              //controller: emailController,
              decoration: InputDecoration(labelText: 'Phone No'),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            CupertinoButton.filled(
                child: const Text('Login'),
                onPressed: () {
                  //login();
                }),
            const SizedBox(
              height: 20,
            ),
            // CupertinoButton(
            //     child: const Text('Create an account'),
            //     onPressed: () {
            //       // Navigator.of(context).push(
            //       //     MaterialPageRoute(builder: (context) => SignupScreen()));
            //     }),
          ]),
        ),
      ),
    );
  }
}
