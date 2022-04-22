
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_project/user.controller.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'colors.dart';
import 'loading_overlay.dart';
import 'dashboard.dart';

class SignUpScreen extends StatefulWidget {
  var mobile_number;

  SignUpScreen({Key? key, this.mobile_number}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState(mobile_number);
}

class _SignUpScreenState extends State<SignUpScreen> {

  var mobile_number;

  var gender="Male";

  _SignUpScreenState(this.mobile_number);

  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController emil = TextEditingController();
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
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              children: [
                SizedBox(
                  height: 50.0,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter first name';
                      }
                      return null;
                    },
                    controller: fname,
                    cursorColor: GetColor.appPrimaryColors,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: GetColor.appPrimaryColors,
                        ),
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(10, 25, 25, 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'First Name',
                      hintStyle:
                      Theme
                          .of(context)
                          .textTheme
                          .bodyText2!
                          .merge(const TextStyle(
                        color: Colors.black,
                      )),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter last name';
                      }
                      return null;
                    },
                    controller: lname,
                    cursorColor: GetColor.appPrimaryColors,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: GetColor.appPrimaryColors,
                        ),
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(10, 25, 25, 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Last Name',
                      hintStyle:
                      Theme
                          .of(context)
                          .textTheme
                          .bodyText2!
                          .merge(const TextStyle(
                        color: Colors.black,
                      )),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Email Address';
                      }
                      return null;
                    },
                    controller: emil,
                    cursorColor: GetColor.appPrimaryColors,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: GetColor.appPrimaryColors,
                        ),
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(10, 25, 25, 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Email',
                      hintStyle:
                      Theme
                          .of(context)
                          .textTheme
                          .bodyText2!
                          .merge(const TextStyle(
                        color: Colors.black,
                      )),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2,
                  ),
                ),


                Container(
                  margin: const EdgeInsets.only(top: 10.0, left: 5.0),
                  child: const Align(
                    child: Text("Gender",
                        style: TextStyle(color: Colors.black)),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 5.0, bottom: 15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ToggleSwitch(
                      minWidth: 100.0,
                      minHeight: 30.0,
                      fontSize: 12.0,
                      borderWidth: 2.0,
                      borderColor: [GetColor.appPrimaryColors],
                      initialLabelIndex: 1,
                      activeBgColor: [GetColor.appPrimaryColors],
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.white,
                      inactiveFgColor: Colors.grey[900],
                      totalSwitches: 2,
                      labels: ['Female', 'Male'],
                      onToggle: (index) {
                        if (index == 0) {
                          gender = "Female";
                        } else {
                          gender = "Male";
                        }
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
                    primary: GetColor.appPrimaryColors,
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    SignUp(mobile_number);
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: Text(
                    'Already have an account!',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2!
                        .merge(
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
      ),
    );
  }

  void SignUp(mobile_number) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      bool status = await userController.Signup(
        fname: fname.text,
        lname: lname.text,
        con_num: mobile_number,
        email: emil.text,
        gen: gender,
      );
      if (status) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) =>
                DashboardPage()), (Route<dynamic> route) => false);
      } else {
        setState(() {
          loading = false;
        });
      }
    }
  }
}

