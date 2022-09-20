import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:pastpostloginfinal/login.dart';
import 'amplifyconfiguration.dart';
import 'package:pastpostloginfinal/confirmRegister.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isSignUpComplete = false;
  Future<void> signUpUser(email, pass, phone) async {
    try {
      final userAttributes = <CognitoUserAttributeKey, String>{
        CognitoUserAttributeKey.email: email,
        CognitoUserAttributeKey.phoneNumber: phone,
        // additional attributes as needed
      };
      final result = await Amplify.Auth.signUp(
        username: email,
        password: pass,
        options: CognitoSignUpOptions(userAttributes: userAttributes),
      );
      setState(() {
        isSignUpComplete = result.isSignUpComplete;
      });
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
                      'Sign up',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: phoneController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
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
                TextButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  child: const Text(
                    'Forgot Password',
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Register'),
                      onPressed: () {
                        print("Datos para registro:");
                        signUpUser(nameController.text, passwordController.text,
                            phoneController.text);
                        print(nameController.text);
                        print(passwordController.text);
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    const ConfirmRegisterPage()));
                      },
                    )),
                Row(
                  children: <Widget>[
                    const Text('Have an account?'),
                    TextButton(
                      child: const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            )));
  }
}
