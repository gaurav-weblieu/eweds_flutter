import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_project/shared_pref.dart';
import 'package:multi_vendor_project/user.model.dart';
import 'package:multi_vendor_project/vendor_details.dart';
import 'package:http/http.dart' as http;
import 'book_mark_page.dart';
import 'api.dart';
import 'city_list_models.dart';
import 'colors.dart';
import 'main.dart';
import 'search_list_models.dart';

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


  late List<CityData> _allUsers = [];
  List<CityData> _foundUsers = [];
  List<CityData> results = [];

  late Future<List<CategoryListModel>> AllcategoryListModel;

  List<CategoryListModel> _allCatListData = [];
  List<CategoryListModel> _foundCategories = [];
  List<CategoryListModel> CatgeriesResults = [];

  late CityListData cityListData;

  String _var_cat_id = "45";
  String _var_city_id = "Delhi";

  late SearchListData searchListData;
  late List<DataVendorList> _allSearchData = [];

  String? _user_id;

  String Select_City = "Select City";

  String Select_category = "Select Category";

  bool firstTime= true;



  @override
  initState() {
    getUserID().then((value) {
      _user_id = value;
    });
    super.initState();
  }

  Future<String?> getUserID() async {
    shared_pref s_f = new shared_pref();
    String? _uid = await s_f.getUid();
    return _uid;
  }

  void _runFilter(String enteredKeyword, StateSetter setState) {
    if (enteredKeyword.isEmpty) {
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user.city!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundUsers = results;
    });
  }

  void _runCateFilter(String enteredKeyword, StateSetter setState) {
    if (enteredKeyword.isEmpty) {
      CatgeriesResults = _allCatListData;
    } else {
      CatgeriesResults = _allCatListData
          .where((user) => user.category_name
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundCategories = CatgeriesResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: GetColor.appPrimaryColors, //change your color here
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text(
          "Search Vendors",
          style: TextStyle(color: GetColor.appPrimaryColors, fontSize: 16),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(
              right: 10.0,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => book_mark_page(
                              user_id: _user_id,
                            )));
              },
              child: const Icon(
                Icons.bookmarks_rounded,
                size: 25,
                color: GetColor.appPrimaryColors,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
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
                    margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: FlatButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                contentPadding:
                                    const EdgeInsets.only(top: 10.0),
                                title: const Text('City List'),
                                content: StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
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
                                              _runFilter(value, setState);
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
                        children: [
                          Container(
                            child: Text(
                              Select_City,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: GetColor.appPrimaryColors,fontSize: 12.0),
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 25,
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
                                contentPadding:
                                    const EdgeInsets.only(top: 10.0),
                                title: const Text('Category List'),
                                content: StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
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
                                              _runCateFilter(value, setState);
                                              setState(() {
                                                _foundCategories =
                                                    CatgeriesResults;
                                              });
                                            },
                                            decoration: const InputDecoration(
                                                labelText: 'Search',
                                                suffixIcon: Icon(Icons.search)),
                                          ),
                                        ),
                                        CategoriesDataListDialog(),
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
                        children: [
                          SizedBox(
                            child: Text(
                              Select_category,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: const TextStyle(
                                  color: GetColor.appPrimaryColors,fontSize: 12.0),
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 25,
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
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        getSearchVendorList();
                      });
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                          // The child of a round Card should be in round shape
                          shape: BoxShape.circle,
                          color: GetColor.appPrimaryColors),
                      child: const Icon(
                        Icons.search,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(child: firstTime ?  Center(child: Container(
            margin: EdgeInsets.all(15.0),
            child: Text("Please Select City and Category to see vendors in your area",
            style: TextStyle(fontSize: 21.0,fontWeight: FontWeight.bold),),
          ),)
              : getSearchVendorList()),
        ],
      ),
    );
  }

  Widget setupAlertDialoadContainer() {
    return Container(
      height: 250.0, // Change as per your requirement
      width: 300.0, //
      child: FutureBuilder<bool>(
        future: getCityList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());
          return _foundUsers.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundUsers.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Select_City =
                                _foundUsers.elementAt(index).city.toString();
                          });

                          _var_city_id =
                              _foundUsers.elementAt(index).city.toString();
                          Navigator.pop(context);
                        },
                        child: Container(
                            margin: EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(_foundUsers
                                    .elementAt(index)
                                    .city
                                    .toString()))),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
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
                );
        },
      ),
    );
  }

  Widget CategoriesDataListDialog() {
    return Container(
      height: 250.0, // Change as per your requirement
      width: 300.0, //
      child: FutureBuilder<List<CategoryListModel>>(
        future: getlisst(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return _foundCategories.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundCategories.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Select_category = _foundCategories
                                .elementAt(index)
                                .category_name
                                .toString();
                          });

                          _var_cat_id =
                              (_foundCategories.elementAt(index).id.toString());
                          Navigator.pop(context);
                        },
                        child: Container(
                            margin: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(_foundCategories
                                    .elementAt(index)
                                    .category_name
                                    .toString()))),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
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
                );
        },
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
        log(response.statusMessage.toString(),
            name: "Get Comment List API Failed");
        MyApp.sMKey.currentState!.showSnackBar(
            const SnackBar(content: Text("Network not available")));
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
        MyApp.sMKey.currentState!.showSnackBar(
            const SnackBar(content: Text("Network not available")));
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
      _allUsers = cityListData.data;
      _foundUsers = _allUsers;
      return true;
    } catch (e) {
      log(e.toString(), name: "Get Comment List API Exception");
      MyApp.sMKey.currentState!
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
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

  Future<List<CategoryListModel>> getlisst() async {
    AllcategoryListModel = fetchCategory();
    _allCatListData = await AllcategoryListModel;
    _foundCategories = _allCatListData;
    return _allCatListData;
  }

  Future<bool> getVendorList() async {
    Response response;
    try {
      response = await Dio().post(
        API.get_vendor_list,
        data: {
          "catid": _var_cat_id,
          "cityid": _var_city_id,
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
        MyApp.sMKey.currentState!.showSnackBar(
            const SnackBar(content: Text("Network not available")));
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

      searchListData = SearchListData.fromJson(jsonDecode(response.data));
      setState(() {
        firstTime=false;
        _allSearchData = searchListData.data!;
      });
      return true;
    } catch (e) {
      log(e.toString(), name: "Get Comment List API Exception");
      /* MyApp.sMKey.currentState!
          .showSnackBar(SnackBar(content: Text(e.toString())));*/
      return false;
    }
  }

  Widget getSearchVendorList() {
    return FutureBuilder<bool>(
        future: getVendorList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: _allSearchData.length,
            itemBuilder: (context, index) {
              final item = _allSearchData[index];
              final Image noImage = Image.asset("images/placeholder.png", height: 200,
                  width: double.infinity,
                  fit: BoxFit.fill);
              return GestureDetector(
                onTap: () {
                  String url = API.CATEGORY_DETAILS_IMAGE1 + item.profilepic;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            vendor_details(url: url, vendor_id: item.email,id: item.id)),
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
                              margin: const EdgeInsets.all(10.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: (item.profilepic != null)
                                      ? Image.network(
                                          API.CATEGORY_DETAILS_IMAGE1 +item.profilepic,
                                      height: 200,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    loadingBuilder: (context, child, loadingProgress) => (loadingProgress == null) ? child : const Center(child: CircularProgressIndicator(color: GetColor.appPrimaryColors,)),
                                          errorBuilder: (context, error, stackTrace) => noImage,
                                        )
                                      : noImage),
                            ),
                            GestureDetector(
                              onTap: () {
                                AddWistLsitVendor(item.id, item.category_id);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(15.0),
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
                                margin: const EdgeInsets.only(
                                    left: 15.0, right: 10.0),
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
                                margin: const EdgeInsets.only(
                                    left: 15.0, right: 15.0, top: 5.0),
                                child: Text(
                                  "Package Price: " +
                                              item.package_price.toString() !=
                                          null
                                      ? "Ask from Enquery for Price"
                                      : item.package_price.toString(),
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
                                margin: EdgeInsets.only(
                                    left: 15.0, right: 10.0, top: 5.0),
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
                          margin: EdgeInsets.only(
                              left: 15.0, right: 10.0, top: 5.0),
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
        });
  }

  Future<bool> AddWistLsitVendor(String vendor_id, String cat_id) async {
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

      var name = jsonDecode(response.data);
      var check = name["type"];
      if (check == "success") {
        MyApp.sMKey.currentState!
            .showSnackBar(SnackBar(content: Text("Added to Bookmark List!!!")));
      } else {
        MyApp.sMKey.currentState!.showSnackBar(
            SnackBar(content: Text("Alrady Added to Bookmark List!!!")));
      }
      return true;
    } catch (e) {
      log(e.toString(), name: "Get Comment List API Exception");
      MyApp.sMKey.currentState!
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }
}
