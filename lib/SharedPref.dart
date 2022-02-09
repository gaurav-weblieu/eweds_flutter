import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class shared_pref {
  final String id = "id";
  final String fname = "fname";
  final String lname = "lname";
  final String email = "email";
  final String mobileno = "mobileno";

//set data into shared preferences like this
  Future<bool> setLoginDetails(String id, String fname,String lname, String email,String mobileno ) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(this.id, id);
      prefs.setString(this.fname, fname);
      prefs.setString(this.lname, lname);
      prefs.setString(this.email, email);
      prefs.setString(this.mobileno, mobileno);
      log('Login details saved in Shared pref');
      return true;
    } catch (e) {
      log('Exception caught in Login details sharedPreference : $e');
      return false;
    }
  }

//get value from shared preferences

  Future<String?> getUid() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      return pref.getString(this.id) ?? null;
    } catch (e) {
      log('Exception caught while getting Login token from sharedPreference : $e');
      return null;
    }
  }


//set data int shared preferences like this
/*  Future<bool> setAuthToken(String auth_token) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(this.authToken, auth_token);
      log('Token saved in Shared pref');
      return true;
    } catch (e) {
      log('Exception caught in Login token sharedPreference : $e');
      return false;
    }
  }*/

//get value from shared preferences



  Future<bool> checkSharedPref(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.containsKey(key);
  }

  Future<bool> clearPreferences() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.remove(this.id);
      await pref.remove(this.fname);
      await pref.remove(this.lname);
      await pref.remove(this.email);
      await pref.remove(this.mobileno);
      await Future.delayed(Duration(seconds: 2));
      return true;
    } catch (e) {}
    return false;
  }
}
