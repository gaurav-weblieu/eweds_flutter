import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class PlaningPageScreen extends StatefulWidget {
  const PlaningPageScreen({Key? key}) : super(key: key);

  @override
  _PlaningPageScreenState createState() => _PlaningPageScreenState();
}

class _PlaningPageScreenState extends State<PlaningPageScreen> {

  bool value = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My CheckList",style: TextStyle(color: Colors.white,fontSize: 16.0,),),
        iconTheme: const IconThemeData(
          color: GetColor.appPrimaryColors, //change your color here
        ),
        elevation: 0.0,
        backgroundColor: GetColor.appPrimaryColors,
      ),
      body: Column(
        children: [

          Container(
            height: 40.0,
            color: GetColor.appPrimaryColors,
            child: Align(
              alignment: Alignment.centerRight,
              child: Row(
                children: [

                  Expanded(
                    child: Container(
                      child: Visibility(visible: false,child: const Text("12 Days to go",style: TextStyle(color: Colors.white,),)),
                      margin: EdgeInsets.all(10.0),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        child: Text("12 Days to go",style: TextStyle(color: Colors.white,),),
                    margin: EdgeInsets.all(10.0),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text("12 Days to go",style: TextStyle(color: Colors.white),),
                      margin: EdgeInsets.all(10.0),
                    ),
                  )
                ],
              ),
            ),
          ),


          Expanded(
              child: ListView.builder(
                itemCount: 15,
                  itemBuilder: (context,index){
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5.0),
                          height: 70.0,
                          child: Card(
                            elevation: 0.0,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [


                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container( child: const Text("Groom Dress",style: TextStyle(color: Colors.black,fontSize: 16.0,fontWeight: FontWeight.w500),),
                                        margin: const EdgeInsets.only(left: 20.0,top: 18.0),),
                                      Container( child: const Text("Tap to vendor details",style: TextStyle(color: Colors.grey,fontSize: 12.0,),),
                                        margin: const EdgeInsets.only(left: 20.0,top: 3.0),),
                                    ],
                                  ),
                                ),

                                Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: GetColor.appPrimaryColors,
                                  value: this.value,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      this.value = value!;
                                    });
                                  },
                                ),

                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 2.0
                        )
                      ],
                    );
                  }

              )

          )
        ],
      ),
    );
  }
}
