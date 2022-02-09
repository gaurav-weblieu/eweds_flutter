import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  late String month="";
  late String year="";

  late String textHolder = '10';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.blue, //change your color here
        ),
        elevation: 2.0,
        backgroundColor: Colors.white,
        title: const Text("Profile",style: TextStyle(color: Colors.blue,fontSize: 16),),
        actions:  [
          Container(
            margin: const EdgeInsets.only(right: 10.0,),
            child: const Center(
              child: Text(
              "Update",
                style: TextStyle(color: Colors.blue,fontSize: 16.0),
              ),
            ),
          ),

        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10.0,),
              child: Center(
                child: Stack(
                  children:[
                    Card(
                      margin: EdgeInsets.all(10.0),
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(150),
                      ),
                      child: Container(
                          width: 120.0,
                          height: 120.0,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      'https://www.eweds.in/uploads/blog/gurgaon-venue/front.png'
                                  )
                              )
                          ))
                  ),
                    Positioned(
                      top: 90.0,
                      left: 95.0,
                      child:
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          // The child of a round Card should be in round shape
                            shape: BoxShape.circle,
                            color: Colors.blue
                        ),
                        child:   const Icon(
                          Icons.add_a_photo_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),

                  ]
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 15.0),
              child: Card(
                elevation: 3.0,
                margin: EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Column(
                            children: [

                              Container(
                                margin: const EdgeInsets.only(top: 10.0),
                                child: const Align(
                                  child: Text("Full Name", style: TextStyle(fontSize: 12.0, color: Colors.grey)),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              Container(
                                child: const TextField(
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'e.g. Gourav Bhati',),
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 25.0),
                                child: const Align(
                                  child: Text("Mobile No",
                                      style:
                                      TextStyle(fontSize: 12.0, color: Colors.grey)),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              Container(
                                child: const TextField(
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'e.g. 8585858585'),
                                  keyboardType: TextInputType.phone,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 25.0),
                                child: const Align(
                                  child: Text("Email Address",
                                      style:
                                      TextStyle(fontSize: 12.0, color: Colors.grey)),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              Container(
                                child: const TextField(
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'e.g. gourav@gmail.com'),
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 20.0,bottom: 10.0),
                                  child:  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Set Password >",
                                      style:
                                      TextStyle(color: Colors.black54, fontSize: 16.0,fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5.0),
                                color: Colors.black45,
                                width: double.infinity,
                                height: 1.0,
                              ),

                              Container(
                                margin: const EdgeInsets.only(top: 15.0),
                                child: const Align(
                                  child: Text("Gender",
                                      style: TextStyle(color: Colors.grey)),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 15.0,bottom: 15.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: ToggleSwitch(
                                    minWidth: 100.0,
                                    minHeight: 30.0,
                                    fontSize: 12.0,
                                    borderWidth: 2.0,
                                    borderColor: [Colors.blue],
                                    initialLabelIndex: 1,
                                    activeBgColor: [Colors.blue],
                                    activeFgColor: Colors.white,
                                    inactiveBgColor: Colors.white,
                                    inactiveFgColor: Colors.grey[900],
                                    totalSwitches: 2,
                                    labels: ['Female', 'Male'],
                                    onToggle: (index) {
                                      print('switched to: $index');
                                    },
                                  ),
                                ),
                              ),

                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }



}
