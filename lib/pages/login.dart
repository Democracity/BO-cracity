import 'dart:convert';

import 'package:bo_cracity/pages/create_account.dart';
import 'package:bo_cracity/pages/dashboard.dart';
import 'package:bo_cracity/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:bo_cracity/pages/create_account.dart';
import 'package:http/http.dart' as http;

import '../services/user.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.grey, Colors.grey])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            height: 400,
            width: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("LOGIN",style: TextStyle(fontSize: 30)),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(40),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Username',
                            icon: Icon(Icons.account_circle_outlined)),
                        controller: usernameController,

                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(40),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                            icon: Icon(Icons.lock_open)),
                        controller: passwordController,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [Text("Forgot password?")],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.blueGrey),
                    child: ElevatedButton(
                      onPressed: () async {

                        String username = usernameController.text;
                        String password = passwordController.text;
                        print("connection");
                        bool loginStatus =
                        await ApiServices.login(username, password);
                        //print (await login(username, password));

                        if(loginStatus){
                        _goToDashboard(context, username);
                        } else {
                         ScaffoldMessenger.of(context).showSnackBar(
                             const SnackBar(content: Text("Wrong username or password"))
                        );
                         }

                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("LOGIN"),
                          ],
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Do not have an account? "),
                      GestureDetector(
                          onTap: () => _goToCreateAccount(context),
                          child: const Text("Sign up here. ")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _goToDashboard(BuildContext context, String username) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => Dashboard(admin: username),
      ),
    );
  }
}

void _goToCreateAccount(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) => const CreateAccount(),
    ),
  );
}


