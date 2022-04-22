import 'package:flutter/material.dart';
import 'package:multi_vendor_project/welcome.dart';
import 'package:multi_vendor_project/user.controller.dart';
import 'package:provider/provider.dart';

import 'colors.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static GlobalKey<ScaffoldMessengerState> sMKey = GlobalKey<ScaffoldMessengerState>();
  static GlobalKey<NavigatorState> nKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserController()),
          ChangeNotifierProvider(create: (context) => UserController())
        ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: sMKey,
      navigatorKey: nKey,
      title: 'Flutter Demo',
      home:  WelcomePage(),
    )

    );}
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: GetColor.appPrimaryColors,
        title: Text(""),
      ),
      body: Center(

        child: Container(
          margin: EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
             Card(
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(50),
               ),
               elevation: 8.0,
               child: Image.asset(
                 "images/demo_image.png",
                 width: double.infinity,
                 height: 180.0,
                 fit: BoxFit.cover,
               ),
             ),


            ],
          ),
        ),
      ),

    );
  }
}
