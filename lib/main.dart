import 'dart:math';

import 'package:flutter/material.dart';
import 'package:multi_vendor_project/welcome.dart';
import 'package:multi_vendor_project/user.controller.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'colors.dart';


const AndroidNotificationChannel channel= AndroidNotificationChannel(
    "high_importance_channel", //id
    "High Importance Notification ", //title
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async{
  await Firebase.initializeApp();
  print("Bg Message just sowed Up ${message.messageId}");

}

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage( _firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
  ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true
  );

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
  void initState() {
    FirebaseMessaging.instance.getToken().then((value) {
      var token = value;
      print("tkoen////////////////"+token!);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification?  notification= message.notification;
      AndroidNotification? androidNotification=message.notification?.android;
      if(notification != null && androidNotification != null ){
        flutterLocalNotificationsPlugin.show(notification.hashCode, notification.title, notification.body, NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            color: Colors.blue,
            playSound: true,
            icon: '@mipmap/ic_launcher',
          ),
        ));
      }
    });


    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification?  notification= message.notification;
      AndroidNotification? androidNotification=message.notification?.android;
      if(notification != null && androidNotification != null ){
        showDialog(context: context, builder: (_){
          return AlertDialog(
            title: Text(notification.title  ?? "null"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Text(notification.body ?? "null")
                ],
              ),
            ),
          );
        });
      }
    });

  }



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
