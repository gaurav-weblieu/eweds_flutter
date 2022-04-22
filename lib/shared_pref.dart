import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class shared_pref {
  final String id = "id";
  final String fname = "fname";
  final String lname = "lname";
  final String email = "email";
  final String mobileno = "mobileno";
  final String is_login = "is_login";
  final String gender = "gender";

  String city_id="city_id";

//set data into shared preferences like this
  Future<bool> setLoginDetails(String id, String fname,String lname, String email,String mobileno,String gender,bool is_login ) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(this.id, id);
      prefs.setString(this.fname, fname);
      prefs.setString(this.lname, lname);
      prefs.setString(this.email, email);
      prefs.setString(this.mobileno, mobileno);
      prefs.setString(this.gender, gender);
      prefs.setBool(this.is_login, is_login);
      log('Login details saved in Shared pref');
      return true;
    } catch (e) {
      log('Exception caught in Login details sharedPreference : $e');
      return false;
    }
  }


  Future<bool> setCityDetails(String city_id) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(this.city_id, city_id);
      log('City details saved in Shared pref');
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

  Future<String?> getCity() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      return pref.getString(this.city_id) ?? null;
    } catch (e) {
      log('Exception caught while getting Login token from sharedPreference : $e');
      return null;
    }
  }





  Future<bool?> isLoginCheck() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      return pref.getBool(is_login);
    } catch (e) {
      log('Exception caught while getting Login token from sharedPreference : $e');
      return false;
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
      return true;
    } catch (e) {}
    return false;
  }
}
