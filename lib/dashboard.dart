import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:multi_vendor_project/colors.dart';
import 'package:multi_vendor_project/planing_page.dart';
import 'package:multi_vendor_project/profile_page.dart';
import 'package:multi_vendor_project/setting_screen.dart';
import 'package:multi_vendor_project/shared_pref.dart';
import 'package:multi_vendor_project/vendor_page.dart';
import 'package:vibration/vibration.dart';

import 'image_picker.dart';
import 'login_copy.dart';
import 'login_with_otp_screen.dart';
import 'main_home_page.dart';
import 'new_bott_nav_help.dart';
import 'no_internet.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage ({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage > {


  int _currentIndex = 0;

  final _inactiveColor = Colors.grey;



  Widget? chek(){
    checkLogin().then((value) {
      if (value) {
        return  Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ProfilePage()),
        );
      } else {
        return Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
            const LoginWithOtp(),
          ),
        );
      }
    });
    return null;
  }

  Future<bool> checkLogin() async {
    bool isLogin;
    shared_pref s_f = new shared_pref();
    String? _uid = await s_f.getUid();
    if ((_uid != null)) {
      isLogin = true;
    } else {
      isLogin = false;
    }
    return isLogin;
  }


  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    main_job_page(),
    VendorPage(),
    //PlaningPageScreen(),
    SettingScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      //bottomNavigationBar: _buildBottomBar()
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: GetColor.appPrimaryColors,
              blurRadius: 6,
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.storefront_rounded),
              label: 'Vendors',
            ),
          /*  BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_rounded),
              label: 'Planing',
            ),*/
            BottomNavigationBarItem(
              icon: Icon(Icons.face_rounded),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: GetColor.appPrimaryColors,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          elevation: 18.0,
        ),
      ),
    );
  }



  Widget _buildBottomBar(){
    return CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) {
        setState(() => _currentIndex = index);
        Vibration.vibrate(duration: 50);
        },
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.home_rounded),
          title: Text('Home'),
          activeColor: Colors.white,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.storefront_rounded),
          title: Text('Vendors'),
          activeColor: Colors.white,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        /*BottomNavyBarItem(
          icon: Icon(Icons.list_alt_rounded),
          title: Text(
            'Planing ',
          ),
          activeColor: Colors.white,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),*/
        BottomNavyBarItem(
          icon: Icon(Icons.face_rounded),
          title: Text('Profile'),
          activeColor: Colors.white,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }


  Widget getBody() {
    List<Widget> pages = [
      const main_job_page(),
      const VendorPage(),
    //  const PlaningPageScreen(),
      const ProfilePage(),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }


  /*Widget chek(){
    checkLogin().then((value) {
      if (value) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ProfilePage()),
        );
      } else {
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
            const LoginScreen(),
          ),
        );
      }
    });
  }
*/



}
