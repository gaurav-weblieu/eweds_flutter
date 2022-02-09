import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';


class profilePage extends StatefulWidget {
  const profilePage({Key? key}) : super(key: key);

  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {

  late String month="";
  late String year="";

 late String textHolder = '10';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        iconTheme: const IconThemeData(
          color: Colors.blue, //change your color here
        ),
        elevation: 2.0,
        backgroundColor: Colors.white,
        title: Text("Send Message",style: TextStyle(color: Colors.blue,fontSize: 16),),

      ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      child: const Align(
                        child: Text("hiii, Saya Grand & Spa Resort",
                            style: TextStyle(
                                color: Colors.black45, fontSize: 16.0,fontWeight: FontWeight.bold)),
                        alignment: Alignment.centerLeft,
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 5.0),
                      color: Colors.black45,
                      width: double.infinity,
                      height: 1.0,
                    ),

                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: const Align(
                        child: Text("Full Name",
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.grey)),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    Container(
                      child: const TextField(
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'e.g. Gourav Bhati'),
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
                    Container(
                      margin: const EdgeInsets.only(top: 25.0),
                      child: const Align(
                        child: Text("No of gusts* (50 min)",
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.grey)),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    GestureDetector(
                      onTap: showBottomSheet,
                      child: Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        child:  Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            textHolder,
                            style:
                                const TextStyle(color: Colors.grey, fontSize: 16.0),
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
                        child: Text("Function Type",
                            style: TextStyle(color: Colors.grey)),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15.0),
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
                          labels: ['Evening', 'Day'],
                          onToggle: (index) {
                            print('switched to: $index');
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child: const Align(
                        child: Text("Function Time",
                            style: TextStyle(color: Colors.grey)),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15.0),
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
                          labels: ['Pre-wedding', 'Wedding'],
                          onToggle: (index) {
                            print('switched to: $index');
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.only(top: 50.0, bottom: 50.0),
                        child: ElevatedButton(
                          onPressed: () {
                           /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecentWorkExperiance()),
                            );*/
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child: const Text('Send Message'),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  late int selectedValue;

  showBottomSheet() {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius:BorderRadius.circular(10.0)
        ),
        builder: (BuildContext bc) {
          return Wrap(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                  setState(() {
                                    textHolder = 'e.g. 26 Aug 1985';
                                  });
                                  },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )),
                      ),
                      Expanded(
                        child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: const EdgeInsets.all(10.0),
                              child: const Text(
                                'No of People',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                      Expanded(
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                  setState(() {
                                    textHolder=month+" "+year;
                                  });
                                },
                                child: const Text(
                                  'Save',
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 250.0,
                          child: CupertinoPicker(
                            backgroundColor: Colors.white,
                            useMagnifier: true,
                            magnification: 1.2,
                            onSelectedItemChanged: (value) {
                              setState(() {
                                selectedValue = value;
                                switch(value){
                                  case 0:
                                    month = '10-20';
                                    break;

                                  case 1:
                                    month = "20-30";
                                    break;

                                  case 2:
                                    month = "30-40";
                                    break;
                                  case 3:
                                    month = "40-50";
                                    break;

                                }
                              });
                            },
                            itemExtent: 32.0,
                            children: const [
                              Text('10-20'),
                              Text('20-30'),
                              Text('30-40'),
                              Text('40-50'),
                              Text('50-60'),
                              Text('60-100'),
                              Text('100-150'),
                              Text('150-200'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          );
        });
  }
}
