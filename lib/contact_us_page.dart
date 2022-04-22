import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_vendor_project/colors.dart';

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
        title: const Text("Contact Us",style: TextStyle(fontSize: 16.0),),
        backgroundColor: GetColor.appPrimaryColors,
      ),
      body: Column(
        children: [
          Container(
              height: 250.0,
              child: Lottie.asset('images/contact_us_loti.json',height: 250.0,width: 250.0)),
          Container(
            margin: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: const [
                    Text("Email Address : ", style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.w500),),
                    Text("support.eweds@gmail.com: ", style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w900, decoration: TextDecoration.underline,),),
                  ],
                ),

                Container(
                  margin: EdgeInsets.only(top: 15.0),
                  child: Row(
                    children: const [
                      Text("Contact Number : ", style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.w500,),),
                      Text("+91-120-4153957", style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w900, decoration: TextDecoration.underline,),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
