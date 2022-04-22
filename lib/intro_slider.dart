import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:multi_vendor_project/colors.dart';
import 'package:multi_vendor_project/dashboard.dart';
import 'package:multi_vendor_project/shared_pref_temp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Intro extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return IntroState();
  }
}

class IntroState extends State<Intro> {
  List<Slide> listSlides = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IntroSlider(
      slides: listSlides,
      renderSkipBtn: this.renderSkipBtn(),
      skipButtonStyle: myButtonStyle(),

      // Next button
      renderNextBtn: this.renderNextBtn(),
      nextButtonStyle: myButtonStyle(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onPressedDone,
      doneButtonStyle: myButtonStyle(),

      // Dot indicator
      colorDot: Colors.grey,
      colorActiveDot: GetColor.appPrimaryColors,
      sizeDot: 13.0,

      // Show or hide status bar
      hideStatusBar: false,
      backgroundColorAllSlides: Colors.grey,

      // Scrollbar
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    listSlides.add(Slide(
        backgroundImage: "images/splash_one.png",
      backgroundColor: Colors.white,
      centerWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(left: 15.0,right: 15.0,top: 400.0),
              child: const Text("Make Your Worries Less",style: TextStyle(color: GetColor.appPrimaryColors,fontSize: 25.0,fontWeight: FontWeight.w800),)),
          Container(
            margin: EdgeInsets.only(left: 15.0,right: 15.0,top: 10.0),
            child: const Text("Don’t panic with the work load, we are hereWedding planning is our duty",
              style: TextStyle(color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.w500),),
          ),
        ],
      )
    ));

    listSlides.add(Slide(
        backgroundColor: Colors.white,
        backgroundImage: "images/splash_two.png",
        centerWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

           // Image.asset("images/splash_two.png"),
            Container(
                margin: EdgeInsets.only(left: 15.0,right: 15.0,top: 400.0),
                child: const Text("A wedding is Event of Life",style: TextStyle(color: GetColor.appPrimaryColors,fontSize: 25.0,fontWeight: FontWeight.w800),)),
            Container(
              margin: EdgeInsets.only(left: 15.0,right: 15.0,top: 10.0),
              child: const Text("A wedding is and event but marriage is a life",
                style: TextStyle(color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.w500),),
            ),
          ],
        )
    ));

    listSlides.add(
        Slide(
        backgroundImage: "images/splash_three.png",
        backgroundColor: Colors.white,
        centerWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(left: 15.0,right: 15.0,top: 400.0),
                child: const Text("Planning Unplanned things",style: TextStyle(color: GetColor.appPrimaryColors,fontSize: 25.0,fontWeight: FontWeight.w800),)),
            Container(
              margin: const EdgeInsets.only(left: 15.0,right: 15.0,top: 10.0),
              child: const Text("Loosen your grip on plan and enjoy the unplanned the unexpected",
                style: TextStyle(color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.w500),),
            ),
          ],
        )
    ));

  }

  onPressedDone() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("welcome", true);

    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => DashboardPage(),
      ),
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFFEBEE)),
      overlayColor: MaterialStateProperty.all<Color>(Color(0xFFFFEBEE)),
    );
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: GetColor.appPrimaryColors,
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: GetColor.appPrimaryColors,
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: GetColor.appPrimaryColors,
    );
  }

}