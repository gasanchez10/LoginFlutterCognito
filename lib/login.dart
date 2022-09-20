import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:pastpostloginfinal/confirmLogin.dart';
import 'package:pastpostloginfinal/register.dart';
import 'amplifyconfiguration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  initState() {
    super.initState();
    /* _configureAmplify();*/
  }

  bool isSignedIn = false;
  Future<void> signInUser(String username, String password) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      setState(() {
        isSignedIn = result.isSignedIn;
      });
      print("->>> " + result.isSignedIn.toString());
      //fetchAuthSession();
    } on AuthException catch (e) {
      print("error " + e.message);
      //fetchAuthSession();
    }
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
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                /*
                TextButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  child: const Text(
                    'Forgot Password',
                  ),
                ),*/
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        signInUser(
                            nameController.text, passwordController.text);
                        print(nameController.text);
                        print(passwordController.text);
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    const ConfirmLoginPage()));
                      },
                    )),
                Row(
                  children: <Widget>[
                    const Text('Does not have account?'),
                    TextButton(
                      child: const Text(
                        'Sign up',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const RegisterPage()));
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            )));
  }
}
