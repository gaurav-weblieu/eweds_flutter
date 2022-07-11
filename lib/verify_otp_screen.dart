import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_project/shared_pref.dart';
import 'package:multi_vendor_project/shared_pref_temp.dart';
import 'package:multi_vendor_project/signip_page.dart';
import 'package:multi_vendor_project/user.controller.dart';
import 'package:provider/provider.dart';


import 'LoadingOverlay.dart';
import 'block/login_bloc.dart';
import 'colors.dart';
import 'dashboard.dart';
import 'main.dart';

class VerifyOtpScreen extends StatefulWidget {
  var Var_otp;

  var mobile_number;

  var message;

  var data;

  VerifyOtpScreen(
      {Key? key,
      required this.Var_otp,
      required this.mobile_number,
      required this.message,
      required this.data})
      : super(key: key);

  @override
  _VerifyOtpScreenState createState() =>
      _VerifyOtpScreenState(Var_otp, mobile_number, message, data);
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  TextEditingController otp = TextEditingController();
  late UserController userController;
  bool loading = false;

  shared_pref share_pre = new shared_pref();
  final _formKey = GlobalKey<FormState>();

  var var_otp;
  var mobile_number;

  var message;

  var data;

  SharedPrefTemp share_pre_temp= SharedPrefTemp();

  _VerifyOtpScreenState(
      this.var_otp, this.mobile_number, this.message, this.data);

  @override
  Widget build(BuildContext context) {
    userController = Provider.of<UserController>(context);
    return Scaffold(
      backgroundColor: Colors.white,
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
                  margin: const EdgeInsets.only(top: 10.0),
                  child: Align(
                    child: Image.asset(
                      "images/app_icon.jpg",
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15.0),
                  child: Align(
                    child: Text("Enter 5 digit OTP sent to $mobile_number",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold)),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Wrong Number ?',
                      style: Theme.of(context).textTheme.bodyText2!.merge(
                            const TextStyle(
                              color: GetColor.appPrimaryColors,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15.0),
                  child: TextFormField(
                    autofocus: true,
                    maxLength: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter OTP';
                      }
                      return null;
                    },
                    controller: otp,
                    keyboardType: TextInputType.number,
                    cursorColor: GetColor.appPrimaryColors,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GetColor.appPrimaryColors,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GetColor.appPrimaryColors,
                        ),),
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 25, 25, 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'OTP',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .merge(const TextStyle(
                            color: Colors.black,
                          )),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                  child: Container(
                    margin: EdgeInsets.all(15.0),
                    child:  Text(
                      'verify'.toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () async {
                    if (var_otp == otp.text) {
                      if (message == "alrady") {
                        if (await share_pre.setLoginDetails(
                            data[0]["id"],
                            data[0]["fname"],
                            data[0]["lname"],
                            data[0]["email"],
                            data[0]["mobileno"],
                            data[0]["gender"],
                            true
                        )) {

                          if (await share_pre_temp.setTempData(data[0]["fname"]+" "+data[0]["lname"], data[0]["email"], data[0]["mobileno"])) {}

                         /* Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              DashboardPage()), (Route<dynamic> route) => false);*/

                          LoginBloc loginBloc= LoginBloc();
                          loginBloc.loginSink.add(true);

                          Navigator.pop(context);
                          Navigator.pop(context);

                        }
                        else {
                          log('token not saved');
                          MyApp.sMKey.currentState!.showSnackBar(const SnackBar(
                              content: Text("Login Fail try again")));
                        }
                      } else if (message == "new") {
                        setState(() {
                          loading = false;
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SignUpScreen(mobile_number: mobile_number,
                              ),),
                        );
                      }
                    } else {
                      MyApp.sMKey.currentState!.showSnackBar(
                          const SnackBar(content: Text("Invalid OTP !!!")));
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 50.0,
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
