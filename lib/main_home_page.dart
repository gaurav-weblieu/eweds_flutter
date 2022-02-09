import 'dart:convert';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_project/serach_page.dart';
import 'package:multi_vendor_project/user.controller.dart';
import 'package:multi_vendor_project/user.model.dart';
import 'package:multi_vendor_project/vendor_details.dart';
import 'package:multi_vendor_project/vendor_list_page.dart';
import 'package:http/http.dart' as http;
import 'api.dart';
import 'city_list_models.dart';
import 'main.dart';

class main_job_page extends StatefulWidget {
  const main_job_page({Key? key}) : super(key: key);

  @override
  _main_job_pageState createState() => _main_job_pageState();
}

class _main_job_pageState extends State<main_job_page> {
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
  late UserController userController;
  late Future<List<CategoryListModel>> categoryListModel;

  late CityListData cityListData;

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



  final List<String> images = [
    'https://www.eweds.in/uploads/blog/shoe-bitefree/shoe-bite.png',
    'https://www.eweds.in/uploads/blog/bridal-jewellery/jewel.png',
    'https://www.eweds.in/uploads/blog/floral-jewellery/Floral-Jewellery.jpg',
    'https://www.eweds.in/uploads/blog/wedding-planning/plan.png',
    'https://www.eweds.in/uploads/blog/gurgaon-venue/front.png'

  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SearchPage()),
                              );
                            },
                            child: const Icon(
                              Icons.search_rounded,
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                        ),
                        alignment: Alignment.centerRight,
                      ),
                      Align(
                        child: Container(
                          margin: EdgeInsets.only(right: 5.0),
                          child: Icon(
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


          Container(
            margin: EdgeInsets.only(top: 12.0,bottom: 12.0),
              child: CarouselSlider.builder(
                itemCount: images.length,
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  height: 160,
                  enlargeCenterPage: true,
                ),
                itemBuilder: (context, index, realIdx) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 3.0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => vendor_list_page()),
                        );
                      },
                      child: Container(
                        child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(images[index],
                                  fit: BoxFit.cover, width: 1000,height: 160,),
                            )),
                      ),
                    ),
                  );
                },
              )),

          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Text(
                  'Categories',
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
              )),

          Container(
            height: 130,
            child: Expanded(child: CategoryList()),
          ),

          Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 10.0,top: 10.0),
                    child: Text(
                      'Venue in your City',
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  )),
              Container(
                height: 250,
                child: Expanded(child: _myListView1()),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => vendor_list_page()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(left: 8.0,right: 8.0,top: 5.0),
                  child: FlatButton(
                    onPressed: null,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('See All Venue', style: TextStyle(
                            color: Colors.blue
                        ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(side: const BorderSide(
                        color: Colors.blue,
                        width: 1,
                        style: BorderStyle.solid
                    ), borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),



          Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 20.0,left: 10.0),
                    child: Text(
                      'Photographers for you',
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  )),
              Container(
                height: 250,
                child: Expanded(child: _myListView2()),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => vendor_list_page()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(left: 8.0,right: 8.0,top: 5.0),
                  child: FlatButton(
                    onPressed: null,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('See All Photographer', style: TextStyle(
                            color: Colors.blue
                        ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(side: const BorderSide(
                        color: Colors.blue,
                        width: 1,
                        style: BorderStyle.solid
                    ), borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),



          Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 20.0,left: 10.0),
                    child: Text(
                      'Popular Near You',
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  )),
              Container(
                height: 250,
                child: Expanded(child: _myListView3()),
              ),

            ],
          ),


          Container(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  "images/bannner.jpg",
                  width: double.infinity,
                  height: 170,
                  fit: BoxFit.fill,
                )),
          ),




        ],
      ),
    );
  }

  Widget CategoryList() {
    return FutureBuilder<List<CategoryListModel>>(
      future: fetchCategory(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        List<CategoryListModel>? posts = snapshot.data;
        return  ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
          itemBuilder: (context, index) {
            final CategoryListModel list_item = posts!.elementAt(index);
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => vendor_list_page()),
                );
              },
              child: Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.all(8.0),
                            width: 80.0,
                            height: 80.0,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        'https://www.eweds.in/uploads/blog/gurgaon-venue/front.png'
                                    )
                                )
                            )),
                        Text(
                          list_item.category_name,
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0),
                        ),
                      ],
                    ),
                  )),
            );
          }
        );
      },
    );
  }

  Widget _myListView1() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
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
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(10.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      "images/imageone.jpg",
                      width: 220,
                      height: 160,
                      fit: BoxFit.cover,
                    )),
              ),
              Container(
                width: 180,
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Text(
                  'Saya Grand club & and Spa..',
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
              ),
              Container(
                width: 180,
                margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
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
                width: 180,
                margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                child: const Text(
                  '1,800 per plate',
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
              ),
            ],
          )),
        );
      },
    );
  }


  Widget _myListView2() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          "images/banner_two.jpg",
                          width: 220,
                          height: 160,
                          fit: BoxFit.cover,
                        )),
                  ),
                  Container(
                    width: 180,
                    margin: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Text(
                      'Bombay Paprazi',
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                  Container(
                    width: 180,
                    margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                    child: Text(
                      'Chembur',
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0),
                    ),
                  ),
                  Container(
                    width: 180,
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                    child: const Text(
                      '75,000 pr day',
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }




  Widget _myListView3() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          "images/makeup_image.jpg",
                          width: 140,
                          height: 170,
                          fit: BoxFit.cover,
                        )),
                  ),
                  Container(
                    width: 120,
                    margin: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Text(
                      'Ram Kishan..',
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                  Container(
                    width: 120,
                    margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                    child: Text(
                      'Delhi NCR',
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0),
                    ),
                  ),

                ],
              )),
        );
      },
    );
  }




}
