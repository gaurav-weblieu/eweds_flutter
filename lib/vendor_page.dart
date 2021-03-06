import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_project/user.model.dart';
import 'package:multi_vendor_project/vendor_details.dart';
import 'package:multi_vendor_project/vendor_list_page.dart';
import 'package:http/http.dart' as http;

import 'api.dart';

class VendorPage extends StatefulWidget {
  const VendorPage({Key? key}) : super(key: key);

  @override
  _VendorPageState createState() => _VendorPageState();
}

class _VendorPageState extends State<VendorPage> {
  @override
  Widget build(BuildContext context) {
    return BodyLayout();
  }
}

class BodyLayout extends StatefulWidget {
  @override
  BodyLayoutState createState() {
    return new BodyLayoutState();
  }
}

class BodyLayoutState extends State<BodyLayout> {
  List<String> titles = ['Sun', 'Moon', 'Star', 'Star', 'Star', 'Star', 'Star'];


  final List<String> images = [
    'https://www.eweds.in/uploads/blog/shoe-bitefree/shoe-bite.png',
    'https://www.eweds.in/uploads/blog/bridal-jewellery/jewel.png',
    'https://www.eweds.in/uploads/blog/floral-jewellery/Floral-Jewellery.jpg',
    'https://www.eweds.in/uploads/blog/wedding-planning/plan.png',
    'https://www.eweds.in/uploads/blog/gurgaon-venue/front.png'

  ];


  late Future<List<CategoryListModel>> categoryListModel;


  @override
  void initState() {
    categoryListModel = fetchCategory();
  }

  Future<List<CategoryListModel>> fetchCategory() async {

    Uri uri =
    Uri.parse( API.cate_list);
    final response = await http.get(
      uri,
      headers:  {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"},

    );

    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return  responseJson.map((m) => CategoryListModel.fromJson(m)).toList();
    } else {
      // If that call was not successful (response was unexpected), it throw an error.
      throw Exception('Failed to load post');
    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            margin: EdgeInsets.all(0.0),
            child: Container(
              height: 60.0,
              color: Colors.grey.shade100,
              child: Container(
                margin: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                child: Expanded(
                  child: Row(
                    children: [
                      const Expanded(
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Mumbai',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                            )),
                      ),
                      Align(
                        child: Container(
                          margin: EdgeInsets.only(right: 5.0),
                          child: const Icon(
                            Icons.search_rounded,
                            color: Colors.black,
                            size: 25,
                          ),
                        ),
                        alignment: Alignment.centerRight,
                      ),
                      Align(
                        child: Container(
                          margin: const EdgeInsets.only(right: 5.0),
                          child: const Icon(
                            Icons.person_rounded,
                            color: Colors.black,
                            size: 25,
                          ),
                        ),
                        alignment: Alignment.centerRight,
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),


          Expanded(
            child: Expanded(child: newList()),
          ),

        ],
      ),
    );
  }


  Widget _myListView3() {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          shrinkWrap: true,
          children: List.generate(20, (index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => vendor_list_page()),
              );
            },
            child: Stack(
              children :[
                ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Stack(
                      children: [
                        Image.asset(
                          "images/makeup_image.jpg",
                          fit: BoxFit.cover,
                          height: 180,
                        ),
                        Opacity(
                          opacity: 0.5,
                          child: Container(
                            color: Colors.black,
                            height: 180,
                            width: double.infinity,
                          ),
                        ),
                        const SizedBox(
                          height: 180,
                          child: Center(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Vendor Category',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          );
        },
      )),
    );
  }


  Widget newList(){
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: FutureBuilder<List<CategoryListModel>>(
        future: fetchCategory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CategoryListModel>? posts = snapshot.data;
            return GridView.builder(
                itemCount: snapshot.data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                ),
                itemBuilder: (context, index) {
                  final CategoryListModel list_item = posts!.elementAt(index);
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => vendor_list_page()),
                        );
                      },
                      child: Stack(
                        children :[
                          ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    "images/makeup_image.jpg",
                                    fit: BoxFit.cover,
                                    height: 180,
                                  ),
                                  Opacity(
                                    opacity: 0.5,
                                    child: Container(
                                      color: Colors.black,
                                      height: 180,
                                      width: double.infinity,
                                    ),
                                  ),
                                   SizedBox(
                                    height: 180,
                                    child: Center(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          list_item.category_name,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.0),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                    );
                }
            );
          } else if (snapshot.hasError) {
            return Text("Error");
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }


}




