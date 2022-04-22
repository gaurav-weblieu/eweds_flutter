import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'colors.dart';

class NoInternetPage extends StatefulWidget {
  const NoInternetPage({Key? key}) : super(key: key);

  @override
  _NoInternetPageState createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200.0,
                width: 200.0,
                margin: EdgeInsets.all(25.0),

                child: Lottie.asset('images/no_internet.json')),
            Container(
                margin: EdgeInsets.all(10.0),
                child: Text("No Internet Connection !!!",style: const TextStyle(color :  GetColor.appPrimaryColors,fontSize: 21.0,),))
          ],
        ),
      ),
    );
  }
}
