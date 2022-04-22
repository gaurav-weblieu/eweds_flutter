
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_project/signip_page.dart';
import 'package:multi_vendor_project/user.controller.dart';
import 'package:provider/provider.dart';

import 'colors.dart';
import 'loading_overlay.dart';
import 'dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  late UserController userController;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    userController = Provider.of<UserController>(context);
    return Scaffold(
      body: SafeArea(
        child: LoadingOverlay(
          isLoading: loading,
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              children: [
                const SizedBox(
                  height: 100.0,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: const Align(
                    child: Text("Candidate",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 21.0,
                            fontWeight: FontWeight.bold)),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: const Align(
                    child: Text("Login",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 21.0,
                            fontWeight: FontWeight.bold)),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: Align(
                    child: Image.asset(
                      "images/person_icon.png",
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ),

                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Email Address';
                    }
                    return null;
                  },
                  controller: email,
                  cursorColor: GetColor.appPrimaryColors,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: GetColor.appPrimaryColors,
                      ),
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 25, 25, 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Email',
                    hintStyle:
                    Theme.of(context).textTheme.bodyText2!.merge(const TextStyle(
                      color: Colors.black,
                    )),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter  password';
                    }else if(value.length<6){
                      return 'Please enter valid password';
                    }
                    return null;
                  },
                  controller: password,
                  obscureText: true,
                  cursorColor: GetColor.appPrimaryColors,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: GetColor.appPrimaryColors,
                      ),
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 25, 25, 0),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: GetColor.appPrimaryColors,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Password',
                    hintStyle:Theme.of(context).textTheme.bodyText2!.merge(const TextStyle(
                      color: Colors.black,
                    )),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    primary: GetColor.appPrimaryColors,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    login();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      'Forgot Password?',
                      style: Theme.of(context).textTheme.bodyText2!.merge(
                        TextStyle(
                          color: GetColor.appPrimaryColors,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Center(
                  child: Text(
                    'Don\'t have an account yet?',
                    style: Theme.of(context).textTheme.bodyText2!.merge(
                      const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    primary: GetColor.appPrimaryColors,
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                   Navigator.of(context).push(CupertinoPageRoute(builder: (context) =>SignUpScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() async {

    if(_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      bool status = await userController.login(
        email: email.text,
        password: password.text,
      );
      if (status) {
        Navigator.pop(context);

        /*Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
      );*/
      }

      setState(() {
        loading = false;
      });
    }}
}

