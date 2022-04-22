import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefTemp {

  final String fullNameTemp = "fullNameTemp";
  final String emailTemp = "emailTemp";
  final String mobileTemp = "mobileTemp";



  Future<bool> setTempData( String fullNameTemp, String emailTemp,String mobileTemp ) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(this.fullNameTemp, fullNameTemp);
      prefs.setString(this.emailTemp, emailTemp);
      prefs.setString(this.mobileTemp, mobileTemp);
      log('Login details saved in Shared pref');
      return true;
    } catch (e) {
      log('Exception caught in Login details sharedPreference : $e');
      return false;
    }
  }




  Future<bool> clearPreferences() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.remove(this.fullNameTemp);
      await pref.remove(this.emailTemp);
      await pref.remove(this.mobileTemp);
      return true;
    } catch (e) {}
    return false;
  }
}
