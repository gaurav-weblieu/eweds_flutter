import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CompleteRequestPage extends StatefulWidget {
  const CompleteRequestPage({Key? key}) : super(key: key);

  @override
  State<CompleteRequestPage> createState() => _CompleteRequestPageState();
}

class _CompleteRequestPageState extends State<CompleteRequestPage> {


  @override
  void initState() {
    super.initState();


    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        selected=false;
      });
      exitScreen();
    });
  }



  bool selected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Center(
              child: SizedBox(
              width: 500,
              height: 500,
              child: Stack(
                children: <Widget>[
                  AnimatedPositioned(
                    left: 10,
                    right: 10,
                    bottom: selected ? 500.0 : 50.0,
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: GestureDetector(
                      onTap: () {
                      },
                      child:  Center(
                        child: Column(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(top: 22.0),
                                child: Center(child: Lottie.asset('images/complete_req.json',height: 250.0,width: 250.0))),
                            Container(
                              margin: EdgeInsets.only(top: 35.0),
                              child: const Center(child: Text("Enquiry submitted Successfully",style: TextStyle(fontSize: 21.0,
                                  color: Colors.black,fontWeight: FontWeight.bold),)),
                            ),

                            Container(
                              margin: EdgeInsets.only(top: 10.0),
                              child: const Center(child: Text("Vendor will contact you soon",style: TextStyle(fontSize: 16.0,color: Colors.black
                                  ,fontWeight: FontWeight.bold),)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ),
            ),


            ],
          ),
        ),
      ),
    );
  }


  void exitScreen(){
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }


}


