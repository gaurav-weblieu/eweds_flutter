import 'package:flutter/material.dart';
import 'package:multi_vendor_project/profile_page.dart';
import 'package:multi_vendor_project/vendor_page.dart';

import 'main_home_page.dart';

class MyNavigationBar extends StatefulWidget {
  MyNavigationBar ({Key? key}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar > {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    main_job_page(),
    VendorPage(),
    main_job_page(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /*appBar: AppBar(
        elevation: 3.0,
        backgroundColor: Colors.white,
       centerTitle: false,
       titleSpacing: 0.0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Mumbai",
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
            Text(
              'Add your location',
              style: TextStyle(color: Colors.grey, fontSize: 12.0
                  ,fontWeight: FontWeight.w300),
            ),
          ],
        ),
        actions:  [
          Container(
            margin: const EdgeInsets.only(right: 10.0,),
            child: const Icon(
              Icons.search_rounded,
              size: 25,
              color: Colors.black,
            ),
          ),

          Container(
            margin: const EdgeInsets.only(right: 10.0,),
            child: const Icon(
              Icons.person_rounded,
              size: 25,
              color: Colors.black,
            ),
          ),
        ],
      ),*/
      body: SafeArea(
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded,color: Colors.white,),
                title: Text('FOR YOU',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                backgroundColor: Colors.blue
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.storefront_rounded,color: Colors.white,),
                title: Text('VENDORS',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                backgroundColor: Colors.blue

            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.notes_rounded,color: Colors.white,),
                title: Text('PLANING',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                backgroundColor: Colors.blue

            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.face_rounded,color: Colors.white,),
                title: Text('PROFILE',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                backgroundColor: Colors.blue

            ),

          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue ,
          iconSize: 20,
          onTap: _onItemTapped,
          elevation: 8
      ),
    );
  }  }
