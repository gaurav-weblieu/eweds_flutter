
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_project/signip_page.dart';
import 'package:multi_vendor_project/user.controller.dart';
import 'package:provider/provider.dart';

import 'LoadingOverlay.dart';
import 'dashboard.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  late UserController userController;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    userController = Provider.of<UserController>(context);
    return Scaffold(
      body: SafeArea(
        child: LoadingOverlay(
          isLoading: loading,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            children: [
              SizedBox(
                height: 100.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
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
                margin: EdgeInsets.only(left: 10.0),
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
                controller: email,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(10, 25, 25, 0),
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
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: Theme.of(context).textTheme.bodyText2,
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(10, 25, 25, 0),
                  border: OutlineInputBorder(
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
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  primary: Colors.blue,
                ),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  login();
                },
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    'Forgot Password?',
                    style: Theme.of(context).textTheme.bodyText2!.merge(
                      TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Center(
                child: Text(
                  'Don\'t have an account yet?',
                  style: Theme.of(context).textTheme.bodyText2!.merge(
                    TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  primary: Colors.blue,
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
    );
  }

  void login() async {
    setState(() {
      loading = true;
    });
    bool status = await userController.login(
      email: email.text,
      password: password.text,
    );
    if(status){

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyNavigationBar()),
      );
    }

    setState(() {
      loading = false;
    });
  }
}

