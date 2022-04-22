import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_vendor_project/about_us.dart';
import 'package:multi_vendor_project/colors.dart';
import 'package:multi_vendor_project/profile_page.dart';
import 'package:multi_vendor_project/shared_pref.dart';
import 'package:multi_vendor_project/sharedpre_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'contact_us_page.dart';
import 'login_with_otp_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool is_login=false;

   String var_final_name="";

   String var_final_image="https://www.eweds.in/uploads/blog/gurgaon-venue/front.png";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              checkLogin().then((value) {
                if (value) {
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const ProfilePage()),
                  );*/

                  Route route = MaterialPageRoute(builder: (context) => ProfilePage());
                  Navigator.push(context, route).then(setTempDate);


                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const LoginWithOtp()),
                  );
                }
              });
            },
            child: Container(
              color: GetColor.appPrimaryColors,
              height: 100.0,
              child: is_login ?  Row(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child:  Container(
                      margin: const EdgeInsets.only(top: 22.0),
                        width: 80.0,
                        height: 100.0,
                        child: Center(child: Lottie.asset('images/robot_hello.json',height: 250.0,width: 250.0)))
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 45.0,left: 25.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:  [
                          Text("Hello, "+var_final_name,
                                  style: const TextStyle(fontSize: 16.0,color: Colors.white,
                                  fontWeight: FontWeight.w600),),
                          Container(
                              margin: const EdgeInsets.only(top: 5.0),

                              child: const Text("View Profile",style: TextStyle(fontSize: 12.0,color: Colors.white),)),
                        ],
                      ),
                    ),
                  )
                ],
              ) : const Center(
                child: Text("Login Please"),
              )
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AboutUs()),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20.0,right: 20.0,top: 35.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.info_rounded,color: GetColor.appPrimaryColors,size: 18.0,
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 10.0),
                          child: const Text("About Us",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),)),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20.0,right: 20.0),
            child: const Divider(
              thickness: 1.0,
            ),
          ),


         /* Container(
            margin: EdgeInsets.only(left: 20.0,right: 20.0,top: 15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.reviews_rounded,color: GetColor.appPrimaryColors,size: 18.0,
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 10.0),
                        child: const Text("Write Review",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),)),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20.0,right: 20.0,bottom: 5.0),
            child: const Divider(
              thickness: 1.0,
            ),
          ),*/

          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ContactUs()),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20.0,right: 20.0,top: 15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.support_agent_rounded,color: GetColor.appPrimaryColors,size: 18.0,
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 10.0),
                          child: const Text("Contact Us",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),)),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20.0,right: 20.0,bottom: 5.0),
            child: const Divider(
              thickness: 1.0,
            ),
          ),


          Container(
            margin: EdgeInsets.only(left: 20.0,right: 20.0,top: 15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.share,color: GetColor.appPrimaryColors,size: 18.0,
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 10.0),
                        child: const Text("Share App",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),)),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20.0,right: 20.0,bottom: 30.0),
            child: const Divider(
              thickness: 1.0,
            ),
          )

        ],
      ),
    );
  }

  Future<bool> checkLogin() async {

    bool isLogin;
    shared_pref s_f = new shared_pref();
    String? _uid = await s_f.getUid();
    if ((_uid != null)) {
      isLogin = true;
      setState(() {
        is_login=true;
      });
    } else {
      setState(() {
        is_login=false;
      });
      isLogin = false;
    }
    return isLogin;
  }

  @override
  void initState() {
    checkLogin();
    setTempDate(0);
  }


  Future<void> setTempDate(dynamic value) async {

    SharedPreferences pref = await SharedPreferences.getInstance();
     var name=pref.getString("fullNameProv")!;
    var email=pref.getString("emailProv")!;
    var image=pref.getString("imageUrlProv")!;

    setState(() {
      var_final_name=name;
      var_final_image=image;
    });

  }


}
