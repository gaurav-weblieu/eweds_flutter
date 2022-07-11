import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_project/search_list_models.dart';
import 'package:multi_vendor_project/shared_pref.dart';
import 'package:multi_vendor_project/vendor_details.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'book_mark_page.dart';
import 'api.dart';
import 'colors.dart';
import 'login_copy.dart';
import 'login_with_otp_screen.dart';
import 'main.dart';

class vendor_list_page extends StatefulWidget {
  var cat_id;

  var cat_name="";

   vendor_list_page({Key? key,required this.cat_id,required this.cat_name}) : super(key: key);

  @override
  _vendor_list_pageState createState() => _vendor_list_pageState(cat_id,cat_name);
}

class _vendor_list_pageState extends State<vendor_list_page> {
  List<String> titles = ['Sun', 'Moon', 'Star', 'Star', 'Star', 'Star', 'Star'];

  late SearchListData searchListData;
  late  List<DataVendorList> _allSearchData = [];

  var cat_id;
  var cat_name;
  String? _user_id;

     var index_on_click;


  _vendor_list_pageState(this.cat_id, this.cat_name);


  String var_city_select="Noida";

  @override
  void initState() {

    getCityDetails();

    getUserID().then((value) {
      _user_id=value;
    });
    super.initState();
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
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: GetColor.appPrimaryColors, //change your color here
        ),
        elevation: 2.0,
        backgroundColor: Colors.white,
        title: Text(cat_name+" : "+var_city_select,style: const TextStyle(color: GetColor.appPrimaryColors,fontSize: 16),),
        actions:  [
          Container(
            margin: const EdgeInsets.only(right: 10.0,),
            child: GestureDetector(
              onTap: (){
                checkLogin().then((value) {
                  if (value) {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => book_mark_page(user_id: _user_id)));
                  } else {
                    Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>  const LoginWithOtp(),
                      ),
                    );
                  }
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 8.0),
                child: const Icon(
                  Icons.bookmarks_rounded,
                  size: 22,
                  color: GetColor.appPrimaryColors,
                ),
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
    return FutureBuilder<bool>(
        future: getVendorList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          return  ListView.builder(
            itemCount: _allSearchData.length,
            itemBuilder: (context, index) {
              final item = _allSearchData[index];
              var image_url="https://www.askgalore.com/wp-content/uploads/2020/06/placeholder.png";
              if(item.profilepic!=null){
                var temp_image_url=item.profilepic;
                image_url = API.CATEGORY_DETAILS_IMAGE1+temp_image_url;
              }
              return GestureDetector(
                onTap: () {
                  String url=API.CATEGORY_DETAILS_IMAGE1+item.profilepic;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => vendor_details( url:url,vendor_id: item.email,id: item.id)),
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
                                  child: Image.network(
                                    image_url,
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                  )),
                            ),
                            GestureDetector(
                              onTap: (){

                                setState(() {
                                  index_on_click=index;
                                });
                                checkLogin().then((value) {
                                  if (value) {
                                    AddWistLsitVendor(item.id,item.category_id);
                                  } else {
                                    Navigator.pushReplacement<void, void>(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>  const LoginWithOtp(),
                                      ),
                                    );
                                  }
                                });

                              },
                              child: index_on_click==index ? Container(
                                margin: EdgeInsets.all(15.0),
                                child: const Icon(
                                  Icons.bookmark_add_rounded,
                                  size: 25,
                                  color: Colors.red,
                                ),
                              ) : Container(
                                margin: EdgeInsets.all(15.0),
                                child: const Icon(
                                  Icons.bookmark_border_rounded,
                                  size: 25,
                                  color: Colors.red,
                                ),
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
                                  item.vendor_name.toString(),
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
                                child:  Text(
                                  "Package Price: "+item.package_price.toString()!=null ? "Ask from Enquery for Price":item.package_price.toString(),
                                  maxLines: 1,
                                  style: const TextStyle(
                                      color: GetColor.appPrimaryColors,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0),
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
                                  item.city.toString(),
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
                            item.address.toString(),
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
          );});
  }


  Future<bool> getVendorList() async {
    Response response;
    try {
      response = await Dio().post(
        API.get_vendor_list,
        data: {
          "catid": cat_id,
          "cityid": var_city_select==null ? "Noida" : var_city_select,
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
      log(json.encode(jsonDecode(response.data)), name: "Get Comment List API Data");

      searchListData = SearchListData.fromJson(jsonDecode(response.data));
      _allSearchData=searchListData.data!;
      return true;
    } catch (e) {
      log(e.toString(), name: "Get Comment List API Exception");
      //MyApp.sMKey.currentState!.showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }


  Future<bool> AddWistLsitVendor(String vendor_id,String cat_id) async {
    Response response;
    try {
      response = await Dio().post(
        API.add_wishlist,
        data: {
          "userid": _user_id,
          "vendorid": vendor_id,
          "categoryid": cat_id,
        },
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
      log(json.encode(jsonDecode(response.data)), name: "Get Comment List API Data");

      var name=jsonDecode(response.data);
      var check=name["type"];
      if(check=="success"){
        MyApp.sMKey.currentState!.showSnackBar(SnackBar(content: Text("Added to Bookmark List!!!")));
      }else{
        MyApp.sMKey.currentState!.showSnackBar(SnackBar(content: Text("Alrady Added to Bookmark List!!!")));
      }
      return true;
    } catch (e) {
      log(e.toString(), name: "Get Comment List API Exception");
      MyApp.sMKey.currentState!.showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }


  Future<String?> getUserID() async {
    shared_pref s_f= new shared_pref();
    String? _uid = await s_f.getUid();
    return _uid;
  }


  void getCityDetails() async {
    shared_pref sF= shared_pref();
    String? CityId = await sF.getCity();
    setState(() {
      var_city_select=CityId!;
    });
  }

  Future<bool> checkLogin() async {
    bool isLogin;
    shared_pref s_f= new shared_pref();
    String? _uid = await s_f.getUid();
    if((_uid != null)) {
      isLogin = true;
    }
    else {
      isLogin = false;
    }
    return isLogin;
  }

}

