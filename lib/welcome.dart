
import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_project/colors.dart';
import 'package:multi_vendor_project/main.dart';
import 'package:multi_vendor_project/shared_pref.dart';
import 'package:multi_vendor_project/signip_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard.dart';
import 'intro_slider.dart';
import 'login_copy.dart';
import 'no_internet.dart';

class WelcomePage extends StatefulWidget {
  static String get routeName => '@routes/welcome-page';
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  bool hide = false;

  @override
  void initState() {
    super.initState();


    Future.delayed(const Duration(seconds: 2), () {
      _checkInternetConnection();
    });
  }

  Future<void> _checkInternetConnection() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final response = await InternetAddress.lookup('www.google.com');
      if (response.isNotEmpty) {

        bool? con=prefs.getBool("welcome");

        if(con==null){

          Navigator.pushReplacement<void, void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) =>  Intro(),
            ),
          );
        } else

        if(con){
          Navigator.pushReplacement<void, void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) =>  DashboardPage(),
            ),
          );
        }else{
          Navigator.pushReplacement<void, void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) =>  Intro(),
            ),
          );
        }


      }
    } on SocketException catch (err) {

      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) =>  const NoInternetPage(),
        ),
      );

      if (kDebugMode) {
        print(err);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Container(
        child: Center(
          child: Image.asset("images/app_icon.jpg",
            height: 300.0,
            width: 300.0,
          ),
        ),
      ),

    );
  }

  Future<bool> checkLogin() async {
    bool isLogin;
    shared_pref s_f= new shared_pref();
    String? _uid = await s_f.getUid();
   if((_uid != null)) {
     isLogin = true;
   }
   else {
      isLogin = false;
    }
    return isLogin;
  }
}
