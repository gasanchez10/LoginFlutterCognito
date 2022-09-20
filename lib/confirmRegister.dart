import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'amplifyconfiguration.dart';
import 'package:pastpostloginfinal/home.dart';

class ConfirmRegisterPage extends StatefulWidget {
  const ConfirmRegisterPage({Key? key}) : super(key: key);

  @override
  State<ConfirmRegisterPage> createState() => ConfirmRegisterPageState();
}

class ConfirmRegisterPageState extends State<ConfirmRegisterPage> {
  @override
  initState() {
    super.initState();
    /* _configureAmplify();*/
  }

  Future<void> _configureAmplify() async {
    // Add any Amplify plugins you want to use
    final authPlugin = AmplifyAuthCognito();
    await Amplify.addPlugin(authPlugin);

    // You can use addPlugins if you are going to be adding multiple plugins
    // await Amplify.addPlugins([authPlugin, analyticsPlugin]);

    // Once Plugins are added, configure Amplify
    // Note: Amplify can only be configured once.
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }

  bool isSignUpComplete = false;
  Future<void> confirmUser(code) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
          username: 'gersan97@mit.edu', confirmationCode: code);
      setState(() {
        isSignUpComplete = result.isSignUpComplete;
      });
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                      'Past Post Draft ',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Confirm email',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'email code',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Confirm email'),
                      onPressed: () {
                        confirmUser(nameController.text);
                        print(nameController.text);
                        print(passwordController.text);
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const HomePage()));
                      },
                    )),
              ],
            )));
  }
}
