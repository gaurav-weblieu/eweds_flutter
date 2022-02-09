import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_project/vendor_details.dart';

import 'BookmarkPage.dart';

class vendor_list_page extends StatefulWidget {
  const vendor_list_page({Key? key}) : super(key: key);

  @override
  _vendor_list_pageState createState() => _vendor_list_pageState();
}

class _vendor_list_pageState extends State<vendor_list_page> {
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

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    //added the pagination function with listener
    //_scrollController.addListener(pagination);
    super.initState();
  }

  /*void pagination() {
    if ((_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) && (_subCategoryModel.products.length < total)) {
      setState(() {
        isLoading = true;
        page += 1;
        //add api for load the more data according to new page
      });
    }
  }*/

  final List<String> images = [
    'https://www.eweds.in/uploads/blog/shoe-bitefree/shoe-bite.png',
    'https://www.eweds.in/uploads/blog/bridal-jewellery/jewel.png',
    'https://www.eweds.in/uploads/blog/floral-jewellery/Floral-Jewellery.jpg',
    'https://www.eweds.in/uploads/blog/wedding-planning/plan.png',
    'https://www.eweds.in/uploads/blog/gurgaon-venue/front.png'

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.blue, //change your color here
        ),
        elevation: 2.0,
        backgroundColor: Colors.white,
        title: Text("Vendors : Mumbai ",style: TextStyle(color: Colors.blue,fontSize: 16),),
        actions:  [
          Container(
            margin: const EdgeInsets.only(right: 10.0,),
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => book_mark_page()));
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

          Expanded(child: _myListView2()),

        ],
      ),
    );
  }




  Widget _myListView2() {
    return ListView.builder(
      controller: _scrollController,
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
                    children : [
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
                          margin: const EdgeInsets.only(left: 15.0, right: 10.0),
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
                          margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
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
                          margin: EdgeInsets.only(left: 15.0, right: 10.0, top: 5.0),
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
                    margin: EdgeInsets.only(top: 10.0,bottom: 5.0),
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

}
