import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_project/user.model.dart';
import 'package:multi_vendor_project/vendor_list_page.dart';
import 'package:http/http.dart' as http;

import 'api.dart';
import 'colors.dart';

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
      appBar: AppBar(
        title: const Text("Wedding Catergories",style: TextStyle(fontSize: 16.0),),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: GetColor.appPrimaryColors,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(child: newList()),

        ],
      ),
    );
  }

  Widget newList(){
    return Container(
      //margin: EdgeInsets.only(top: 10.0),
      height: double.infinity,
      width: double.infinity,
      child: FutureBuilder<List<CategoryListModel>>(
        future: fetchCategory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CategoryListModel>? posts = snapshot.data;
            return  ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final CategoryListModel listItem = posts!.elementAt(index);
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => vendor_list_page(cat_id:listItem.id,cat_name: listItem.category_name,)),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 3.0),
                        child: Stack(
                          children :[
                            ClipRRect(
                                //borderRadius: BorderRadius.circular(8.0),
                                child: Stack(
                                  children: [
                                    Image.network(
                                      listItem.cat_big_img,
                                      fit: BoxFit.fitWidth,
                                      height: 180,
                                      width: double.infinity,
                                    ),
                                    /*Opacity(
                                      opacity: 0.5,
                                      child: Container(
                                        color: Colors.black,
                                        height: 180,
                                        width: double.infinity,
                                      ),
                                    ),*/
                                     /*SizedBox(
                                      height: 180,
                                      child: Center(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            listItem.category_name,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0),
                                          ),
                                        ),
                                      ),
                                    )*/
                                  ],
                                )),
                          ],
                        ),
                      ),
                    );
                }
            );
          } else if (snapshot.hasError) {
            return const Text("Error");
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }


}




