import 'dart:convert';
import 'dart:developer';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:multi_vendor_project/city_select_page.dart';
import 'package:multi_vendor_project/serach_page.dart';
import 'package:multi_vendor_project/shared_pref.dart';
import 'package:multi_vendor_project/user.controller.dart';
import 'package:multi_vendor_project/user.model.dart';
import 'package:multi_vendor_project/vendor_details.dart';
import 'package:multi_vendor_project/vendor_list_page.dart';
import 'package:http/http.dart' as http;
import 'package:multi_vendor_project/vendor_page.dart';
import 'api.dart';
import 'city_list_models.dart';
import 'colors.dart';
import 'dashboard.dart';
import 'main.dart';
import 'search_list_models.dart';
import 'package:geocoding/geocoding.dart' as geocoding ;
import 'package:location/location.dart'  as location ;




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


  late LocationData _currentPosition;
  late String _address;

  var arr=[
    "images/c_delhi.jpg",
    "images/c_noida.jpg",
    "images/c_ghazibad.jpg",
    "images/c_grugram.jpg",
    "images/c_faridabad.jpg",
  ];


  location.Location location_user =  location.Location();

  late UserController userController;
  late Future<List<CategoryListModel>> categoryListModel;

  late CityListData cityListData;
  late List<CityData> _allUsers = [];
  List<CityData> _foundUsers = [];



  late SearchListData searchListData;
  late List<DataVendorList> _allSearchData = [];
  late List<DataVendorList> _allPhotographerData = [];

  String var_city_select = "";

  late SearchListData photographerListData;


  @override
  void initState() {
    getCityDetails();
    categoryListModel = fetchCategory();
  }

  Future<List<CategoryListModel>> fetchCategory() async {
    Uri uri = Uri.parse(API.cate_list);
    final response = await http.get(
      uri,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
    );

    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => CategoryListModel.fromJson(m)).toList();
    } else {
      // If that call was not successful (response was unexpected), it throw an error.
      throw Exception('Failed to load post');
    }
  }

   var cityLoading = false;

  final List<String> images = [
    'https://www.eweds.in/uploads/blog/shoe-bitefree/shoe-bite.png',
    'https://www.eweds.in/uploads/blog/bridal-jewellery/jewel.png',
    'https://www.eweds.in/uploads/blog/floral-jewellery/Floral-Jewellery.jpg',
    'https://www.eweds.in/uploads/blog/wedding-planning/plan.png',
    'https://www.eweds.in/uploads/blog/gurgaon-venue/front.png'
  ];

  @override
  Widget build(BuildContext context) {
    /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white
    ));*/
    return Scaffold(
      appBar: AppBar(
         systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: GetColor.appPrimarySecColors,
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        elevation: 0.0,
        backgroundColor: GetColor.appPrimaryColors,
        title: Container(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
            child: Container(
              width: double.infinity,
              height: 45.0,
              child: Card(
                elevation: 0.0,
                child:  Row(
                  children:  [
                    Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      child: const Icon(
                        Icons.search_rounded,
                        color: GetColor.appPrimaryColors,
                        size: 25,
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 10.0),
                        child:  DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black38
                          ),
                          child: AnimatedTextKit(
                            repeatForever: true,
                            pause: const Duration(milliseconds: 2000),
                            animatedTexts: [
                              WavyAnimatedText('Search Vendor in your city'),
                              WavyAnimatedText('Search Vendor by City'),
                              WavyAnimatedText('Search Vendor in your area'),
                            ],
                            isRepeatingAnimation: true,
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SearchPage()),
                              );
                            },
                          ),
                        )

                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        /*title: SizedBox(
          width: 170.0,
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SelectCityPage()));
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                    topLeft: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0)),
              ),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5.0, left: 5.0),
                    child: const Icon(
                      Icons.location_on_rounded,
                      color: GetColor.appPrimaryColors,
                      size: 20,
                    ),
                  ),
                  Expanded(
                      child: Text(
                    var_city_select,
                    style: const TextStyle(
                        color: GetColor.appPrimaryColors,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: GetColor.appPrimaryColors,
                    size: 25,
                  ),
                ],
              ),
            ),
          ),
        ),*/
        actions: const [

          /*Container(
            height: 25,
            width: 25,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
            margin: const EdgeInsets.only(right: 15.0),
            child: const Icon(
              Icons.person_rounded,
              color: GetColor.appPrimaryColors,
              size: 20,
            ),
          ),*/
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Container(
              margin: const EdgeInsets.only(top: 10.0, left: 10.0),
              height: 120.0,
              child: Row(
                children: [
                  Column(
                      children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          cityLoading=true;
                        });
                        fetchLocation();
                      },
                      child: Column(
                        children: [

                          Container(
                            margin: const EdgeInsets.all(10.0),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: GetColor.appPrimaryColors
                              ,
                               ),
                            height: 60.0,
                            width: 60.0,
                            child: cityLoading ? const SizedBox(
                                height: 5.0,
                                width: 5.0,
                                child: Center(child: CircularProgressIndicator(color: Colors.white,)))
                                : const Icon(Icons.location_on_rounded, color: Colors.white,),
                          ),
                          Container(
                              margin:
                                  const EdgeInsets.only(left: 10.0, right: 10.0),
                              child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "NearBy",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ))),
                        ],
                      ),
                    ),
                  ]),
                  Expanded(child: CityListWidget()),


                ],
              ),
            ),


            SizedBox(
              height: 180.0,
              child: CarouselSlider.builder(
                itemCount: images.length,
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  height: 180,
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
                          MaterialPageRoute(
                              builder: (context) => vendor_list_page(
                                  cat_id: "46", cat_name: "Noida")),
                        );
                      },
                      child: Container(
                        child: Center(
                            child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            images[index],
                            fit: BoxFit.cover,
                            width: 1000,
                            height: 180,
                          ),
                        )),
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: const Text(
                    'Categories',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                )),
            Flexible(child: CategoryList()),
            const Divider(
              thickness: 2.0,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: const Text(
                    'Venue in your City',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                )),
            Flexible(child: BuildVendorVenueList()),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => vendor_list_page(
                          cat_id: "46", cat_name: "Venue in your city")),
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: GetColor.appPrimaryColors,
                    borderRadius: BorderRadius.all(Radius.circular(18.0))
                ),
                height: 35.0,
                margin: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0,bottom: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'See All Venue',
                      style: TextStyle(color:Colors.white,fontSize: 12.0),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              thickness: 2.0,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: const Text(
                    'Photographer for you',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                )),
            Flexible(child: BuildPhototList()),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => vendor_list_page(
                          cat_id: "53", cat_name: "Photographer for you")),
                );
              },
              child: Container(
                margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0),
                child: Container(
                  decoration: const BoxDecoration(
                      color: GetColor.appPrimaryColors,
                      borderRadius: BorderRadius.all(Radius.circular(18.0))
                  ),
                  height: 35.0,
                  margin: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0,bottom: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'See All Photographer',
                        style: TextStyle(color:Colors.white,fontSize: 12.0),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(
              thickness: 2.0,
            ),
           /* Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(top: 20.0, left: 10.0),
                  child: Text(
                    'Popular Near You',
                    style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                )),*/
            //Flexible(child: _myListView3()),
            Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.asset(
                    "images/banner.png",
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.fill,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget CategoryList() {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, top: 10.0),
      height: 130.0,
      child: FutureBuilder<List<CategoryListModel>>(
        future: fetchCategory(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
              color: GetColor.appPrimaryColors,
            ));
          }
          List<CategoryListModel>? posts = snapshot.data;
          return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (context, index) {
                final CategoryListModel listItem = posts!.elementAt(index);
                return index<6 ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => vendor_list_page(
                                cat_id: listItem.id,
                                cat_name: listItem.category_name,
                              )),
                    );
                  },
                  child: Container(
                      margin: EdgeInsets.only(right: 5.0, left: 5.0),
                      height: 130.0,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Container(
                                margin: const EdgeInsets.all(8.0),
                                width: 60.0,
                                height: 60.0,
                                child: Container(
                                  margin: EdgeInsets.all(15.0),
                                  child: Image.network(
                                    listItem.app_five_icon,
                                    width: double.infinity,


                                  ),
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  color: GetColor.appPrimaryColors
                                      .withOpacity(0.1),
                                  /*image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          'https://www.eweds.in/uploads/blog/gurgaon-venue/front.png'
                                      )
                                  )*/
                                )),
                            Text(
                              listItem.category_name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0),
                            ),
                          ],
                        ),
                      )),
                ):GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VendorPage()),
                    );
                  },
                  child: Container(
                      margin: EdgeInsets.only(right: 5.0, left: 5.0),
                      height: 130.0,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Container(
                                margin: const EdgeInsets.all(8.0),
                                width: 60.0,
                                height: 60.0,
                                child: Container(
                                  margin: EdgeInsets.all(15.0),
                                  child: Icon(Icons.read_more_rounded,color: Colors.black,),

                      ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                  BorderRadius.all(const Radius.circular(5.0)),
                                  color: GetColor.appPrimaryColors
                                      .withOpacity(0.1),
                                  /*image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          'https://www.eweds.in/uploads/blog/gurgaon-venue/front.png'
                                      )
                                  )*/
                                )),
                            const Text(
                              "More Category",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.0),
                            ),
                          ],
                        ),
                      )),
                );
              });
        },
      ),
    );
  }

  Widget _myListView3() {
    return Container(
      height: 250.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => vendor_details(
                        url: "null",
                        vendor_id: "city-stay-hotel-saffron-banquet")),
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
      ),
    );
  }

  Future<bool> fetchVendorVanue(String catId) async {
    Response response;
    try {
      response = await Dio().post(
        API.get_vendor_list,
        data: {
          "catid": catId,
          "cityid": var_city_select,
          "pincode": "",
          "offsets": "0",
        },
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
     // log(json.encode(jsonDecode(response.data)),name: "Get Comment List API Data");

      searchListData = SearchListData.fromJson(jsonDecode(response.data));
      _allSearchData = searchListData.data!;
      return true;
    } catch (e) {
      log(e.toString(), name: "Get Comment List API Exception");
     // MyApp.sMKey.currentState!.showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }

  Future<bool> fetchPhotographer() async {
    Response response;
    try {
      response = await Dio().post(
        API.get_vendor_list,
        data: {
          "catid": "53",
          "cityid": var_city_select,
          "pincode": "",
          "offsets": "0",
        },
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
          },
        ),
      );
      if (response.statusCode != 200) {
        //log(response.statusMessage.toString(),name: "Get Comment List API Failed");
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
    //  log(json.encode(jsonDecode(response.data)),name: "Get Comment List API Data");
      _allPhotographerData.clear();
      photographerListData = SearchListData.fromJson(jsonDecode(response.data));
      _allPhotographerData = photographerListData.data!;
      return true;
    } catch (e) {
      log(e.toString(), name: "Get Comment List API Exception");
    //  MyApp.sMKey.currentState!.showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }

  Widget BuildVendorVenueList() {
    return Container(
      height: 250.0,
      child: FutureBuilder<bool>(
          future: fetchVendorVanue("46"),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: CircularProgressIndicator(
                color: GetColor.appPrimaryColors,
              ));
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _allSearchData.length >= 5 ? 5 : _allSearchData.length,
              itemBuilder: (context, index) {
                final item = _allSearchData[index];
                var image_url="https://www.askgalore.com/wp-content/uploads/2020/06/placeholder.png";
                if(item.profilepic!=null){
                  var temp_image_url=item.profilepic;
                  image_url = API.CATEGORY_DETAILS_IMAGE1+temp_image_url;
                }
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => vendor_details(
                              url:
                                 image_url,
                              vendor_id: item.email)),
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
                            child: Image.network(
                             image_url,
                              width: 220,
                              height: 160,
                              fit: BoxFit.cover,
                            )),
                      ),
                      Container(
                        width: 180,
                        margin: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Text(
                          item.vendor_name.toString(),
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        width: 180,
                        margin:
                            EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                        child: Text(
                          item.localarea,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.0),
                        ),
                      ),
                      Container(
                        width: 180,
                        margin: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 5.0),
                        child: Text(
                          "Package Price: " + item.package_price.toString() !=
                                  null
                              ? "Ask from Enquery for Price"
                              : item.package_price.toString(),
                          maxLines: 1,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0),
                        ),
                      ),
                    ],
                  )),
                );
              },
            );
          }),
    );
  }

  Widget BuildPhototList() {
    return Container(
      height: 250.0,
      child: FutureBuilder<bool>(
          future: fetchPhotographer(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: CircularProgressIndicator(
                color: GetColor.appPrimaryColors,
              ));
            }
            return _allPhotographerData.isNotEmpty ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _allPhotographerData.length >= 5 ? 5 : _allPhotographerData.length,
              itemBuilder: (context, index) {
                final item = _allPhotographerData[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => vendor_details(url: API.CATEGORY_DETAILS_IMAGE1 + item.profilepic,
                              vendor_id: item.email)),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              API.CATEGORY_DETAILS_IMAGE1 + item.profilepic,
                              width: 220,
                              height: 160,
                              fit: BoxFit.cover,
                            )),
                      ),
                      Container(
                        width: 180,
                        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Text(
                          item.vendor_name.toString(),
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        width: 180,
                        margin: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 5.0),
                        child: Text(
                          item.localarea,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.0),
                        ),
                      ),
                      Container(
                        width: 180,
                        margin: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 5.0),
                        child: Text(
                          "Package Price: " + item.package_price.toString() !=
                                  null
                              ? "Ask from Enquery for Price"
                              : item.package_price.toString(),
                          maxLines: 1,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ):const Center(
              child: Text("Data not available")
            );
          }),
    );
  }

  void getCityDetails() async {
    shared_pref sF = shared_pref();
    String? CityId = await sF.getCity();
    setState(() {
      if (var_city_select != null) {
        var_city_select = CityId!;
      } else {

      }
    });
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
     // log(json.encode(response.data), name: "Get Comment List API Data");
      cityListData = CityListData.fromJson(jsonDecode(response.data));
      _allUsers = cityListData.data;
      _foundUsers = _allUsers;

      return true;
    } catch (e) {
      log(e.toString(), name: "Get Comment List API Exception");
      //MyApp.sMKey.currentState!.showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }

  Widget CityListWidget() {
    return Container(
      child: FutureBuilder<bool>(
        future: getCityList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator(color: GetColor.appPrimaryColors,));
          }
          return _foundUsers.isNotEmpty
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) =>  index<5 ?  Column(
                    children: [
                      InkWell(
                         onTap: () {
                          shared_pref sF = shared_pref();
                          sF.setCityDetails(_foundUsers.elementAt(index).city.toString());
                          Navigator.pushReplacement<void, void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  DashboardPage(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: GetColor.appPrimaryColors
                                      .withOpacity(0.1),
                                  image:  DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(arr[index])
                                  )),
                              height: 60.0,
                              width: 60.0,
                            ),
                            Container(
                                margin:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _foundUsers
                                          .elementAt(index)
                                          .city
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                    ))),
                          ],
                        ),
                      ),
                    ],
                  ):Column(
                    children: [

                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  SelectCityPage()),
                          );

                        },
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: GetColor.appPrimaryColors
                                      .withOpacity(0.1),
                              ),
                              height: 60.0,
                              width: 60.0,
                              child: Icon(Icons.read_more_rounded,color: Colors.black,),
                            ),
                            Container(
                                margin:
                                EdgeInsets.only(left: 10.0, right: 10.0),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("More City",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ))),
                          ],
                        ),
                      ),
                    ],
                  )
                )
              : const Center(
                  child: Text(
                    'No results found',
                    style: TextStyle(fontSize: 12),
                  ),
                );
        },
      ),
    );
  }


  fetchLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location_user.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location_user.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location_user.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location_user.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location_user.getLocation();
    location_user.onLocationChanged.listen((LocationData currentLocation) async {


      setState(() async {
        _currentPosition = currentLocation;
        List<Placemark> placemarks = await placemarkFromCoordinates(_currentPosition .latitude!, _currentPosition.longitude!);
        var first= placemarks.first;
        var city_name=first.locality;
        var country=first.country;

        setState(() {
          cityLoading=false;
        });

        shared_pref sF = shared_pref();
        sF.setCityDetails(city_name.toString());
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                DashboardPage(),
          ),
        );


        /*getAddress(_currentPosition.latitude, _currentPosition.longitude)
            .then((value) {
          setState(() {
            _address = "${value.first.addressLine}";
          });
        });*/
      });
    });
  }

 /* String getImageName(profilepic) {
    if(profilepic!=null){
      return profilepic;
    }else{
      return "";
    }
  }*/






}
