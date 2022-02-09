
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_project/user.controller.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'LoadingOverlay.dart';
import 'dashboard.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController cont_num = TextEditingController();
  TextEditingController emil = TextEditingController();
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
                  child: Text("Signup",
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

              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  controller: fname,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 25, 25, 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'First Name',
                    hintStyle:
                    Theme.of(context).textTheme.bodyText2!.merge(const TextStyle(
                      color: Colors.black,
                    )),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),


              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  controller: lname,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 25, 25, 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Last Name',
                    hintStyle:
                    Theme.of(context).textTheme.bodyText2!.merge(const TextStyle(
                      color: Colors.black,
                    )),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),


              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  controller: cont_num,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 25, 25, 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Contact Number',
                    hintStyle:
                    Theme.of(context).textTheme.bodyText2!.merge(const TextStyle(
                      color: Colors.black,
                    )),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  controller: emil,
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
              ),

              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: TextFormField(
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
              ),


              Container(
                margin: const EdgeInsets.only(top: 10.0,left: 5.0),
                child: const Align(
                  child: Text("Gender",
                      style: TextStyle(color: Colors.black)),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 5.0,bottom: 15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ToggleSwitch(
                    minWidth: 100.0,
                    minHeight: 30.0,
                    fontSize: 12.0,
                    borderWidth: 2.0,
                    borderColor: [Colors.blue],
                    initialLabelIndex: 1,
                    activeBgColor: [Colors.blue],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.white,
                    inactiveFgColor: Colors.grey[900],
                    totalSwitches: 2,
                    labels: ['Female', 'Male'],
                    onToggle: (index) {
                      print('switched to: $index');
                    },
                  ),
                ),
              ),


              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  primary: Colors.blue,
                ),
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  SignUp();
                },
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  'Already have an account!',
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
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  // Navigator.of(context).push(CupertinoPageRoute(builder: (context) =>))
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void SignUp() async {
    setState(() {
      loading = true;
    });
    bool status = await userController.Signup(
      fname: fname.text,
      lname: lname.text,
      con_num: cont_num.text,
      email: emil.text,
      pass: password.text,
      gen: "Male",
    );
    if(status){

     /* Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );*/

      Navigator.pop(context);
    }

    setState(() {
      loading = false;
    });
  }
}

