import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_project/city_list_models.dart';
import 'package:multi_vendor_project/shared_pref_temp.dart';
import 'package:multi_vendor_project/user.model.dart';
import 'shared_pref.dart';
import 'api.dart';
import 'city_list_models.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

class UserController extends ChangeNotifier {
   late String? token;
  late UserLoginData user;
  late SignupModel signupModel;
  late CategoryListModel categoryListModel;
   shared_pref share_pre= new shared_pref();

  late CityListData cityListData;

   SharedPrefTemp share_pre_temp= SharedPrefTemp();


  Future<bool> login({required String email, required String password,}) async
  {
    Response response;
    try {
      response = await Dio().post(
        API.login,
        data: {
          "email": email,
          "password": password,
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
        MyApp.sMKey.currentState!.showSnackBar(SnackBar(content: Text(response.statusMessage.toString())));
        return false;
      }
      /*if (response.statusCode == 200 && response.data'error' != 0) {
        log(response.statusMessage.toString(), name: "Login API Failed");
        MyApp.sMKey.currentState!.showSnackBar(SnackBar(content: Text(response.data.toString())));
        return false;
      }*/
    } on DioError catch (e) {
      if (e.response == null) {
        log(e.message.toString(), name: "Login API Error");
        MyApp.sMKey.currentState!
            .showSnackBar(SnackBar(content: Text("Network not available")));
      } else {
        log(e.response!.data.toString(), name: "Login API Error");
        MyApp.sMKey.currentState!
            .showSnackBar(SnackBar(content: Text("Network not available")));
      }
      return false;
    }

    try {
     /* log(json.encode(response.data), name: "Get Comment List API Data");
       this.user= UserLoginData.fromJson(jsonDecode(response.data));
      if ( await share_pre.setLoginDetails(user.data.elementAt(0).id,user.data.elementAt(0).fname,user.data.elementAt(0).lname,
          user.data.elementAt(0).email,
          user.data.elementAt(0).mobileno,true)) {
        MyApp.sMKey.currentState!.showSnackBar(SnackBar(content: Text("User Login Successfully!!!")));
        notifyListeners();
        return true;
      } else {

        log('token not saved');
        return false;

      }*/
      return false;

    } catch (e) {
      log(e.toString(), name: "Get User Details API Exception");
      MyApp.sMKey.currentState!
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }



   Future<bool> Signup({required String fname, required String lname,
     required String con_num, required String email,required String gen}) async
   {

     Response response;
     try {
       response = await Dio().post(
         API.signup,
         data: {
           "email" :  email,
           "fname"  : fname,
           "gender"  : gen,
           "lname" : lname,
           "mobileno" : con_num
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
         MyApp.sMKey.currentState!.showSnackBar(SnackBar(content: Text(response.statusMessage.toString())));
         return false;
       }
       /*if (response.statusCode == 200 && response.data'error' != 0) {
        log(response.statusMessage.toString(), name: "Login API Failed");
        MyApp.sMKey.currentState!.showSnackBar(SnackBar(content: Text(response.data.toString())));
        return false;
      }*/
     } on DioError catch (e) {
       if (e.response == null) {
         log(e.message.toString(), name: "Login API Error");
         MyApp.sMKey.currentState!
             .showSnackBar(const SnackBar(content: Text("Network not available")));
       } else {
         log(e.response!.data.toString(), name: "Login API Error");
         MyApp.sMKey.currentState!
             .showSnackBar(const SnackBar(content: Text("Network not available")));
       }
       return false;
     }

     try {
       log(json.encode(response.data), name: "Get Comment List API Data");
       //signupModel= SignupModel.fromJson(jsonDecode(response.data));
       log(json.encode(response.data), name: "Get Comment List API Data");
       var res = jsonDecode(response.data);
       if (res["error"] == "0") {
         var data = res["data"];

         if (await share_pre_temp.setTempData(data[0]["fname"]+" "+data[0]["lname"], data[0]["email"], data[0]["mobileno"])) {}

         if (await share_pre.setLoginDetails(
             data[0]["id"],
             data[0]["fname"],
             data[0]["lname"],
             data[0]["email"],
             data[0]["mobileno"],
             data[0]["gender"],
             true
         )) {
           MyApp.sMKey.currentState!.showSnackBar(const SnackBar(content: Text("User Login Successfully!!!")));
           notifyListeners();
           return true;
         } else {
           log('token not saved');
           return false;
         }
       }
       return true;

     } catch (e) {
       log(e.toString(), name: "Get User Details API Exception");
       MyApp.sMKey.currentState!.showSnackBar(SnackBar(content: Text(e.toString())));
       return false;
     }
   }



   Future<bool> getCityList() async {
     Response response;
     try {
       response = await Dio().get(
         API.city_list,
         options: Options(
           headers: {
             "Accept": "application/json",
             "Content-Type": "application/x-www-form-urlencoded"
           },
         ),
       );
       if (response.statusCode != 200) {
         log(response.statusMessage.toString(), name: "Get Comment List API Failed");
         MyApp.sMKey.currentState!.showSnackBar(SnackBar(content: Text("Network not available")));
         return false;
       }
       if (response.statusCode == 200 && response.data['error'] != 0) {
         log(response.statusMessage.toString(), name: "Get Comment List API Failed");
         MyApp.sMKey.currentState!.showSnackBar(SnackBar(content: Text(response.data["message"])));
         return false;
       }
     } on DioError catch (e) {
       if (e.response == null) {
         log(e.message.toString(), name: "Get Comment List API Error");
         MyApp.sMKey.currentState!.showSnackBar(SnackBar(content: Text("Network not available")));
       } else {
         log(e.response!.data.toString(), name: "Get Comment List API Error");
         MyApp.sMKey.currentState!
             .showSnackBar(SnackBar(content: Text("Network not available")));
       }
       return false;
     }

     try {
       log(json.encode(response.data), name: "Get Comment List API Data");
       // this.token = response.data['data']['token'];
       var test=response.data['data'];
       if (response.data["data"] != null) {
        cityListData = CityListData.fromJson(response.data);
       }
       notifyListeners();
       return true;
     } catch (e) {
       log(e.toString(), name: "Get Comment List API Exception");
       MyApp.sMKey.currentState!.showSnackBar(SnackBar(content: Text(e.toString())));
       return false;
     }
   }


}




