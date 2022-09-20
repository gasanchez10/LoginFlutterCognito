import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'amplifyconfiguration.dart';
import 'package:pastpostloginfinal/home.dart';

class ConfirmLoginPage extends StatefulWidget {
  const ConfirmLoginPage({Key? key}) : super(key: key);

  @override
  State<ConfirmLoginPage> createState() => ConfirmLoginPageState();
}

class ConfirmLoginPageState extends State<ConfirmLoginPage> {
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

  Future<void> confirmSignInPhoneVerification(String otpCode) async {
    await Amplify.Auth.confirmSignIn(
      confirmationValue: otpCode,
    );
    fetchAuthSession();
  }

  Future<void> fetchAuthSession() async {
    try {
      final result = await Amplify.Auth.fetchAuthSession(
        options: CognitoSessionOptions(getAWSCredentials: true),
      );
      print((result as CognitoAuthSession).userPoolTokens?.accessToken);
      print("idtoken:");
      print((result as CognitoAuthSession).userPoolTokens?.idToken);
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
                      'Confirm sms',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'sms code',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Confirm sms'),
                      onPressed: () {
                        confirmSignInPhoneVerification(nameController.text);
                        print(nameController.text);

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
