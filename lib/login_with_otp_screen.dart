import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_project/shared_pref.dart';
import 'package:multi_vendor_project/user.controller.dart';
import 'package:multi_vendor_project/verify_otp_screen.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'LoadingOverlay.dart';
import 'api.dart';
import 'colors.dart';
import 'dashboard.dart';
import 'main.dart';

class LoginWithOtp extends StatefulWidget {
  const LoginWithOtp({Key? key}) : super(key: key);

  @override
  _LoginWithOtpState createState() => _LoginWithOtpState();
}

class _LoginWithOtpState extends State<LoginWithOtp> {
  TextEditingController phone = TextEditingController();
  late UserController userController;
  bool loading = false;

  shared_pref share_pre= new shared_pref();
  final _formKey = GlobalKey<FormState>();


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
                  child: const Align(
                    child: Text("Enter Your Mobile Number",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold)),
                    alignment: Alignment.centerLeft,
                  ),
                ),


                Container(
                  margin: const EdgeInsets.only(top: 15.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length !=10) {
                        return 'Please enter valid Mobile Number';
                      }
                      return null;
                    },
                    autofocus: true,
                    controller: phone,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    cursorColor: GetColor.appPrimaryColors,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 25, 25, 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GetColor.appPrimaryColors,
                        ),borderRadius: BorderRadius.all(Radius.circular(15.0))
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GetColor.appPrimaryColors,
                        ),),
                      hintText: 'Mobile Number',
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
                SizedBox(
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
                    child: const Text(
                      'GET OTP',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () {
                    getOtp(phone: phone.text);
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

  void getOtp({required String? phone}) async
  {

    if (_formKey.currentState!.validate()) {

      setState(() {
        loading = true;
      });

      var response;
      try {
        response = await Dio().post(
          API.get_opt_user,
          data: {
            "mobile": phone
          },
          options: Options(
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/x-www-form-urlencoded"
            },
          ),
        );
        if (response.statusCode != 200) {
          log(response.toString());
          log(response.statusMessage.toString(), name: "Login API Failed");
          SnackBar(content: Text(response.statusMessage.toString()));
        }
      } on DioError catch (e) {
        if (e.response == null) {
          log(e.message.toString(), name: "Login API Error");
          MyApp.sMKey.currentState!.showSnackBar(
              const SnackBar(content: Text("Network not available")));
        } else {
          log(e.response!.data.toString(), name: "Login API Error");
          MyApp.sMKey.currentState!.showSnackBar(
              const SnackBar(content: Text("Network not available")));
        }
      }

      try {
        log(json.encode(response.data), name: "Get Comment List API Data");
        var res = jsonDecode(response.data);
        if (res["status"] == "true") {
          var message = res["message"];
          var data = res["data"];

          String otp=res["otp"] as String;
          Navigator.of(context).push(CupertinoPageRoute(builder: (context) =>  VerifyOtpScreen(Var_otp: otp, mobile_number: phone, message: message, data: data,)));

          setState(() {
            loading=false;
          });

        } else {
          log('token not saved');
        }
      } catch (e) {
        log(e.toString(), name: "Get User Details API Exception");
        MyApp.sMKey.currentState!.showSnackBar(
            SnackBar(content: Text(e.toString())));
      }
    }
  }


}
