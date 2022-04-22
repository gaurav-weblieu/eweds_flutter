import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_project/send_message.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:multi_vendor_project/shared_pref.dart';
import 'api.dart';
import 'colors.dart';
import 'login_copy.dart';
import 'login_with_otp_screen.dart';
import 'main.dart';

class vendor_details extends StatefulWidget {
  var vendor_id;

  vendor_details({Key? key, required this.url, required this.vendor_id}) : super(key: key);
  final String url;

  @override
  _vendor_detailsState createState() => _vendor_detailsState(url, vendor_id);
}

class _vendor_detailsState extends State<vendor_details> {


  List<String> titles = ['Sun'];

  var name = "";
  var city = "";
  var address = "";
  var price = "";
  var des = "";
  var url;

  var var_res_data;

  var vendor_id;

  _vendor_detailsState(this.url, this.vendor_id);

  @override
  void initState() {
    getVendorProfileDetails();
  }

  final Image noImage = Image.asset("images/placeholder.png",
      height: 200, width: double.infinity, fit: BoxFit.fill);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              floating: true,
              bottom: PreferredSize(
                child: Container(),
                preferredSize: Size(0, 20),
              ),
              pinned: false,
              expandedHeight: MediaQuery.of(context).size.height * 0.4,
              flexibleSpace: Stack(
                children: [
                  Positioned(
                      child: (url != null)
                          ? Image.network(
                              url,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.fill,
                              loadingBuilder:
                                  (context, child, loadingProgress) =>
                                      (loadingProgress == null)
                                          ? child
                                          : const Center(
                                              child: CircularProgressIndicator(
                                              color: GetColor.appPrimaryColors,
                                            )),
                              errorBuilder: (context, error, stackTrace) =>
                                  noImage,
                            )
                          : noImage,
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0),
                  Positioned(
                    child: Container(
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(50),
                        ),
                      ),
                    ),
                    bottom: -1,
                    left: 0,
                    right: 0,
                  ),
                ],
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        name,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500),
                      ),
                      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          size: 15,
                          color: Colors.black54,
                        ),
                        Text(
                          city,
                          style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        address,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: const Text(
                        "Veg Price",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 5.0),
                          child: const Text(
                            "Rs ",
                            style: TextStyle(
                                color: GetColor.appPrimaryColors,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            price,
                            style: TextStyle(
                                color: GetColor.appPrimaryColors,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5.0),
                          child: const Text(
                            "",
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: const Text(
                        "Price info",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.grey,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        checkLogin().then((value) {
                          if (value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SendEnquery(var_res: var_res_data)),
                            );
                          } else {
                            Navigator.pushReplacement<void, void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const LoginWithOtp(),
                              ),
                            );
                          }
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                color: Colors.white,
                                child: FlatButton(
                                  onPressed: null,
                                  child: const Text(
                                    'Send Message',
                                    style: TextStyle(
                                        color: GetColor.appPrimaryColors),
                                  ),
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: GetColor.appPrimaryColors,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10.0),
                              child: const Icon(
                                Icons.call_rounded,
                                size: 35,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                   /* Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                          child: Text(
                            'Albums (1)',
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          ),
                        )),
                    _myListView1(),*/
                    /*Container(
                      margin: const EdgeInsets.only(left: 70.0, right: 70.0),
                      child: FlatButton(
                        onPressed: null,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'See All Album',
                              style:
                                  TextStyle(color: GetColor.appPrimaryColors),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 15,
                              color: GetColor.appPrimaryColors,
                            ),
                          ],
                        ),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: GetColor.appPrimaryColors,
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),*/
                    Container(
                      margin: EdgeInsets.only(top: 15.0, bottom: 5.0),
                      child: Text(
                        'About Sya Grand Club & Spa Resort',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        stripHtmlIfNeeded(des),
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0, bottom: 5.0),
                      child: Text(
                        'Been on Eweds Since',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        "3 year 1 month",
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0),
                      ),
                    ),
                   /* Container(
                      margin: EdgeInsets.only(top: 15.0, bottom: 5.0),
                      child: Text(
                        'Outside Alchol perimitted',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0),
                      ),
                    ),*/
                    /*Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        "Outside Alchool is not perimitted ",
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0),
                      ),
                    ),*/
                    /*Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(top: 15.0, bottom: 5.0),
                          child: Text(
                            'Review (1)',
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          ),
                        )),*/
                    /*Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            right: 10.0,
                          ),
                          child: const Icon(
                            Icons.person_pin,
                            size: 70,
                            color: Colors.grey,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 5.0),
                                  child: const Text(
                                    'Yanish Nagar',
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                )),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 5.0),
                                  child: Text(
                                    'Lorem Ipsum is simply dummy text of the \n'
                                    ' printing and  typesetting industry.',
                                    style: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),*/
                   /* Container(
                      margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      width: double.infinity,
                      height: 2.0,
                      color: Colors.grey.shade300,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(right: 10.0),
                            child: FlatButton(
                              onPressed: null,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'See All Album',
                                    style: TextStyle(
                                        color: GetColor.appPrimaryColors),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 15,
                                    color: GetColor.appPrimaryColors,
                                  ),
                                ],
                              ),
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: GetColor.appPrimaryColors,
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10.0),
                            child: FlatButton(
                              onPressed: null,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'See All Album',
                                    style: TextStyle(
                                        color: GetColor.appPrimaryColors),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 15,
                                    color: GetColor.appPrimaryColors,
                                  ),
                                ],
                              ),
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: GetColor.appPrimaryColors,
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                      ],
                    ),*/
                  ],
                ),
              ),
              /*Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Text(
                      'Browse similar Vendors',
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  )),

              _myListView2(),*/
            ],
          ),
        ),
      ),
    );
  }

  Widget _myListView2() {
    return Container(
      height: 250.0,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: titles.length,
        itemBuilder: (context, index) {
          final item = titles[index];
          return GestureDetector(
            onTap: () {
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JobDetailsPage()),
              );*/
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        "images/imageone.jpg",
                        width: 180,
                        height: 160,
                        fit: BoxFit.cover,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: 5.0,
                        ),
                        child: Text(
                          'Saya Grand club & \n and Spa..',
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5.0, top: 5),
                        child: Text(
                          'Bhiwadi',
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5.0, top: 10.0),
                        child: const Text(
                          '1,800 per plate',
                          maxLines: 1,
                          style: TextStyle(
                              color: GetColor.appPrimaryColors,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _myListView1() {
    return Container(
      height: 180.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: titles.length,
        itemBuilder: (context, index) {
          final item = titles[index];
          return GestureDetector(
            onTap: () {
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JobDetailsPage()),
              );*/
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  "images/imageone.jpg",
                  width: 220,
                  height: 160,
                  fit: BoxFit.cover,
                )),
          );
        },
      ),
    );
  }

  Future<bool> getVendorProfileDetails() async {
    Response response;
    try {
      response = await Dio().post(
        API.get_profile,
        data: {"v_id": vendor_id},
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
          },
        ),
      );
      if (response.statusCode != 200) {
        log(response.statusMessage.toString(),
            name: "Get Comment List API Failed");
        MyApp.sMKey.currentState!
            .showSnackBar(SnackBar(content: Text("Network not available")));
        return false;
      }
      /*  if (response.statusCode == 200 && response.data['error'] != 0) {
        log(response.statusMessage.toString(), name: "Get Comment List API Failed");
        MyApp.sMKey.currentState!.showSnackBar(SnackBar(content: Text(response.data["message"])));
        return false;
      }*/
    } on DioError catch (e) {
      if (e.response == null) {
        log(e.message.toString(), name: "Get Comment List API Error");
        MyApp.sMKey.currentState!
            .showSnackBar(SnackBar(content: Text("Network not available")));
      } else {
        log(e.response!.data.toString(), name: "Get Comment List API Error");
        MyApp.sMKey.currentState!
            .showSnackBar(SnackBar(content: Text("Network not available")));
      }
      return false;
    }

    try {
      log(json.encode(jsonDecode(response.data)),
          name: "Get Comment List API Data");

      var data = jsonDecode(response.data);
      var check = data["data"][0]["vendor_name"];
      setState(() {
        var_res_data = jsonDecode(response.data);
        name = check;
        city = data["data"][0]["country"];
        address = data["data"][0]["address"];
        price = data["data1"][0]["package_price"].toString();
        des = data["data"][0]["description"];
      });
      return true;
    } catch (e) {
      log(e.toString(), name: "Get Comment List API Exception");
      MyApp.sMKey.currentState!
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
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


  static String stripHtmlIfNeeded(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
  }

}
