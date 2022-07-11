import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:multi_vendor_project/shared_pref.dart';
import 'api.dart';
import 'block/counter_bloc.dart';
import 'colors.dart';
import 'main.dart';
import 'vendor_details.dart';
import 'wish_list_model.dart';

class book_mark_page extends StatefulWidget {
  var user_id;

   book_mark_page({Key? key,required this.user_id}) : super(key: key);

  @override
  _book_mark_pageState createState() => _book_mark_pageState(user_id);
}

class _book_mark_pageState extends State<book_mark_page> {

  _book_mark_pageState(this.user_id);
  var user_id;

  late WishListData wishListdata;

  late final newsBloc;

  @override
  void initState() {
     newsBloc= NewsBloc(user_id);
    newsBloc.eventSink.add(NewsAction.Fetch);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: GetColor.appPrimaryColors, //change your color here
        ),
        elevation: 2.0,
        backgroundColor: Colors.white,
        title: const Text("Bookmark List",style: TextStyle(color: GetColor.appPrimaryColors,fontSize: 16),),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(child: BuildBookmarkList()),

        ],
      ),
    );
  }


  Widget BuildBookmarkList() {
    return StreamBuilder< List<Data>>(
        stream : newsBloc.newsStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          return  ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              final item = snapshot.data?.elementAt(index);
              return GestureDetector(
                onTap: () {

                  String url=API.CATEGORY_DETAILS_IMAGE1+item?.profilepic;

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => vendor_details( url:url,vendor_id: item?.email,id: item?.id,)),
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
                              margin: const EdgeInsets.all(10.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    API.CATEGORY_DETAILS_IMAGE1+item?.profilepic,
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                  )),
                            ),
                            GestureDetector(
                              onTap: (){
                               /* newsBloc= NewsBloc(item?.wishlist_id);
                                newsBloc.eventSink.add(NewsAction.Delete);*/
                                deleteListItem(item?.wishlist_id);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(15.0),
                                child: const Icon(
                                  Icons.bookmarks_rounded,
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
                                  item!.vendor_name.toString(),
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
                                child:  const Text(
                                  "Package Price: Ask from Enquery for Price",
                                  maxLines: 1,
                                  style: TextStyle(
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
                                margin: const EdgeInsets.only(left: 15.0, right: 10.0, top: 5.0),
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
                          margin: const EdgeInsets.only(left: 15.0, right: 10.0, top: 5.0),
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
                          margin: const EdgeInsets.only(top: 10.0,bottom: 5.0),
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




/*  Widget BuildBookmarkList() {
    return FutureBuilder<bool>(
        future: getBookmarkList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          return  ListView.builder(
            itemCount: _allwishListdata.length,
            itemBuilder: (context, index) {
              final item = _allwishListdata[index];
              return GestureDetector(
                onTap: () {

                  String url=API.CATEGORY_DETAILS_IMAGE1+item.profilepic;

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => vendor_details( url:url,vendor_id: item.email)),
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
                              margin: const EdgeInsets.all(10.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    API.CATEGORY_DETAILS_IMAGE1+item.profilepic,
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                  )),
                            ),
                            GestureDetector(
                              onTap: (){
                                deleteListItem(item.wishlist_id);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(15.0),
                                child: const Icon(
                                  Icons.bookmarks_rounded,
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
                                child:  const Text(
                                  "Package Price: Ask from Enquery for Price",
                                  maxLines: 1,
                                  style: TextStyle(
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
                                margin: const EdgeInsets.only(left: 15.0, right: 10.0, top: 5.0),
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
                          margin: const EdgeInsets.only(left: 15.0, right: 10.0, top: 5.0),
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
                          margin: const EdgeInsets.only(top: 10.0,bottom: 5.0),
                          width: double.infinity,
                          height: 3.0,
                          color: Colors.grey.shade300,
                        )
                      ],
                    )),
              );
            },
          );});
  }*/


 /* Future<bool> getBookmarkList() async {
    Response response;
    try {
      response = await Dio().post(
        API.get_vendor_save_list,
        data: {
          "user_id": user_id,
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
        MyApp.sMKey.currentState!.showSnackBar(const SnackBar(content: Text("Network not available")));
        return false;
      }
      *//*  if (response.statusCode == 200 && response.data['error'] != 0) {
        log(response.statusMessage.toString(), name: "Get Comment List API Failed");
        MyApp.sMKey.currentState!.showSnackBar(SnackBar(content: Text(response.data["message"])));
        return false;
      }*//*
    } on DioError catch (e) {
      if (e.response == null) {
        log(e.message.toString(), name: "Get Comment List API Error");
        MyApp.sMKey.currentState!.showSnackBar(const SnackBar(content: Text("Network not available")));
      } else {
        log(e.response!.data.toString(), name: "Get Comment List API Error");
        MyApp.sMKey.currentState!
            .showSnackBar(const SnackBar(content: Text("Network not available")));
      }
      return false;
    }

    try {
      log(json.encode(jsonDecode(response.data)), name: "Get Comment List API Data");

      setState(() {
        wishListdata = WishListData.fromJson(jsonDecode(response.data));
        _allwishListdata=wishListdata.data!;
      });

      return true;
    } catch (e) {
      log(e.toString(), name: "Get Comment List API Exception");
    //  MyApp.sMKey.currentState!.showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }*/




  Future<bool> deleteListItem(String id) async {
    Response response;
    try {
      response = await Dio().post(
        API.delete_wishlist,
        data: {
          "id": id
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
        MyApp.sMKey.currentState!.showSnackBar(const SnackBar(content: Text("Network not available")));
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
        MyApp.sMKey.currentState!.showSnackBar(const SnackBar(content: Text("Network not available")));
      } else {
        log(e.response!.data.toString(), name: "Get Comment List API Error");
        MyApp.sMKey.currentState!
            .showSnackBar(const SnackBar(content: Text("Network not available")));
      }
      return false;
    }

    try {
      log(json.encode(jsonDecode(response.data)), name: "Get Comment List API Data");

      var data=jsonDecode(response.data);
      var check=data["type"];

      if(check=="success"){
        MyApp.sMKey.currentState!.showSnackBar(const SnackBar(content: Text("Deleted Successfully!!!")));
        newsBloc.eventSink.add(NewsAction.Fetch);
      }else{
        MyApp.sMKey.currentState!.showSnackBar(const SnackBar(content: Text("Failed!!!")));
      }

      return true;
    } catch (e) {
      log(e.toString(), name: "Get Comment List API Exception");
      MyApp.sMKey.currentState!.showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }

}
