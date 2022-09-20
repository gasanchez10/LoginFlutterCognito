import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'amplifyconfiguration.dart';
import 'package:pastpostloginfinal/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  initState() {
    super.initState();
    /* _configureAmplify();*/
  }

  Future<void> signOutCurrentUser() async {
    try {
      await Amplify.Auth.signOut();
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'You are logged In ',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Log out'),
                      onPressed: () {
                        signOutCurrentUser();
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                    )),
              ],
            )));
  }
}
