import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_vendor_project/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;



class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contact Us",
          style: TextStyle(fontSize: 16.0),
        ),
        backgroundColor: GetColor.appPrimaryColors,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50.0,left: 10.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          UrlLauncher.launch("tel:/"+"+91-120-4153957");
                        },
                        child: Column(
                          children: const [
                            Text(
                              "Contact Us : ",
                              style: TextStyle(fontSize: 12.0),
                            ),
                            Text(
                              "+91-120-4153957",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w900,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 25.0),
                          height: 150.0,
                          child: Image.asset("images/contact.png")),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 130.0),
                  child: Row(
                    children: [
                      Container(
                          margin: const EdgeInsets.only( right: 15.0),
                          height: 150.0,
                          child: Image.asset("images/contact_two.png")),
                      GestureDetector(
                        onTap: (){
                          var url ="mailto:"+"support@eweds.in"+"?subject=News&body=New%20plugin";
                          UrlLauncher.launch(url);
                        },
                        child: Column(
                          children: const [
                            Text(
                              "Email Address : ",
                              style: TextStyle(fontSize: 12.0),
                            ),
                            Text(
                              "mailto:support@eweds.in",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w900,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 70.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      GestureDetector(
                        onTap: (){
                          openwhatsapp();
                        },
                        child: Container(
                            margin: const EdgeInsets.only( right: 15.0),
                            height: 70.0,
                            child: Image.asset("images/whatapps_icon.png")),
                      ),

                      GestureDetector(
                        onTap: (){
                          _launchUrl(Uri.parse('https://in.pinterest.com/ewedsi/_created/'));
                        },
                        child: Container(
                            margin: const EdgeInsets.only( right: 15.0),
                            height: 70.0,
                            child: Image.asset("images/pins_icon.png")),
                      ),

                      GestureDetector(
                        onTap: (){
                          _launchUrl(Uri.parse('https://www.instagram.com/eweds_india/'));
                        },
                        child: Container(
                            margin: EdgeInsets.only( right: 15.0),
                            height: 70.0,
                            child: Image.asset("images/insta_iocn.png")),
                      ),

                      GestureDetector(
                        onTap: (){
                          _launchUrl(Uri.parse('https://www.facebook.com/ewedsindia'));
                        },
                        child: Container(
                            margin: EdgeInsets.only( right: 15.0),
                            height: 70.0,
                            child: Image.asset("images/face_icon.png")),
                      )

                    ],
                  ),
                )

              ],
            ),
          ),
        ],
      ),
    );
  }

  void _launchUrl(Uri _url) async {
    if (! await launchUrl(_url)) throw 'Could not launch $_url';
  }


  openwhatsapp() async{
    var whatsapp ="+919958049353";
    var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=hello";
    var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if(Platform.isIOS){
      // for iOS phone only
      if( await canLaunch(whatappURL_ios)){
        await launch(whatappURL_ios, forceSafariVC: false);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp no installed")));
      }
    }else{
      // android , web
      if( await canLaunch(whatsappURl_android)){
        await launch(whatsappURl_android);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp no installed")));
      }
    }
  }

}
