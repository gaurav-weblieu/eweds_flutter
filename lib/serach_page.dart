import 'dart:convert';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_project/vendor_details.dart';

import 'BookmarkPage.dart';
import 'api.dart';
import 'city_list_models.dart';
import 'main.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> titles = ['Sun', 'Moon', 'Star', 'Star', 'Star', 'Star', 'Star'];

  final List<String> images = [
    'https://www.eweds.in/uploads/blog/shoe-bitefree/shoe-bite.png',
    'https://www.eweds.in/uploads/blog/bridal-jewellery/jewel.png',
    'https://www.eweds.in/uploads/blog/floral-jewellery/Floral-Jewellery.jpg',
    'https://www.eweds.in/uploads/blog/wedding-planning/plan.png',
    'https://www.eweds.in/uploads/blog/gurgaon-venue/front.png'
  ];

  List<String> colorList = [
    'Orange',
    'Yellow',
    'Pink',
    'White',
    'Red',
    'Black',
    'Green'
  ];

  late  List<Map<String, dynamic>> _allUsers = [];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];

  List<Map<String, dynamic>> results = [];

  late CityListData cityListData;


  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = _allUsers;
    getCityList();
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword, StateSetter setState) {
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["city"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }


    setState(() {
      _foundUsers = results;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.blue, //change your color here
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "Search Vendors",
          style: TextStyle(color: Colors.blue, fontSize: 16),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(
              right: 10.0,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => book_mark_page()));
              },
              child: const Icon(
                Icons.bookmarks_rounded,
                size: 25,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 3.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: FlatButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                contentPadding: const EdgeInsets.only(top: 10.0),
                                title: const Text('City List'),
                                content: StatefulBuilder(
                                    builder: (BuildContext context, StateSetter setState) {
                                  return Container(
                                    height: 350.0,
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          width: double.infinity,
                                          height: 2.0,
                                          color: Colors.black54,
                                        ),
                                        Container(
                                          height: 40.0,
                                          margin: const EdgeInsets.only(
                                              top: 10.0,
                                              left: 10.0,
                                              right: 10.0),
                                          child: TextField(
                                            onChanged: (value) {
                                              _runFilter(value,setState);
                                              setState(() {
                                                _foundUsers = results;
                                              });
                                              },
                                            decoration: const InputDecoration(
                                                labelText: 'Search',
                                                suffixIcon: Icon(Icons.search)),
                                          ),
                                        ),
                                        setupAlertDialoadContainer(),
                                      ],
                                    ),
                                  );
                                }),
                              );
                            });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Select City',
                            style: TextStyle(color: Colors.blue),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 25,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Colors.blue,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: FlatButton(
                      onPressed: null,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Select Vendor',
                            style: TextStyle(color: Colors.blue),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 25,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Colors.blue,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: const BoxDecoration(
                        // The child of a round Card should be in round shape
                        shape: BoxShape.circle,
                        color: Colors.blue),
                    child: const Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(child: _myListView2()),
        ],
      ),
    );
  }

  Widget _myListView2() {
    return ListView.builder(
      itemCount: titles.length,
      itemBuilder: (context, index) {
        final item = titles[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => vendor_details()),
            );
          },
          child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              "images/imageone.jpg",
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.all(15.0),
                        child: const Icon(
                          Icons.bookmark_border_rounded,
                          size: 25,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin:
                              const EdgeInsets.only(left: 15.0, right: 10.0),
                          child: Text(
                            'GCC Hotel and Club',
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 5.0),
                          child: const Text(
                            'Rs 950 per day',
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 15.0, right: 10.0, top: 5.0),
                          child: Text(
                            'Chembur',
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15.0, right: 10.0, top: 5.0),
                    child: Text(
                      'Non-Veg',
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w300,
                          fontSize: 12.0),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
                    width: double.infinity,
                    height: 3.0,
                    color: Colors.grey.shade300,
                  )
                ],
              )),
        );
      },
    );
  }

  Widget setupAlertDialoadContainer() {
    return Container(
      height: 250.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: Expanded(
        child: _foundUsers.isNotEmpty
            ? ListView.builder(
                itemCount: _foundUsers.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    Container(
                        margin: EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(_foundUsers[index]['name']))),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 10.0, right: 10.0),
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.black12,
                    ),
                  ],
                ),
              )
            : const Center(
                child: Text(
                  'No results found',
                  style: TextStyle(fontSize: 12),
                ),
              ),
      ),
    );
  }


  Future<bool> getCityList() async {
    Response response;
    try {
      response = await Dio().get(
        API.city_list,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
          },
        ),
      );
      if (response.statusCode != 200) {
        log(response.statusMessage.toString(), name: "Get Comment List API Failed");
        MyApp.sMKey.currentState!.showSnackBar(SnackBar(content: Text("Network not available")));
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
        MyApp.sMKey.currentState!.showSnackBar(SnackBar(content: Text("Network not available")));
      } else {
        log(e.response!.data.toString(), name: "Get Comment List API Error");
        MyApp.sMKey.currentState!
            .showSnackBar(SnackBar(content: Text("Network not available")));
      }
      return false;
    }

    try {
      log(json.encode(response.data), name: "Get Comment List API Data");
      cityListData = CityListData.fromJson(jsonDecode(response.data));
      _allUsers=cityListData.data.cast<Map<String, dynamic>>();
      return true;
    } catch (e) {
      log(e.toString(), name: "Get Comment List API Exception");
      MyApp.sMKey.currentState!.showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }
}
