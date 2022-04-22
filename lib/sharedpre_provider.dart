import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPerWithProvider {

  final String fullNameTemp = "fullNameProv";
  final String emailTemp = "emailProv";
  final String imageUrl = "imageUrlProv";
  late  String var_name = "";



  Future<bool> setTempDataProfileProv ( String fullNameTemp, String emailTemp,String imageUrl ) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(this.fullNameTemp, fullNameTemp);
      prefs.setString(this.emailTemp, emailTemp);
      prefs.setString(this.imageUrl, imageUrl);
      log('Login details saved in Shared pref');

      return true;
    } catch (e) {
      log('Exception caught in Login details sharedPreference : $e');
      return false;
    }
  }



}