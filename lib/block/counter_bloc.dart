import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:multi_vendor_project/wish_list_model.dart';

import '../api.dart';


enum NewsAction {
  Fetch,
  Delete
}

class NewsBloc{

  late  List<Data> _allwishListdata = [];

  late WishListData wishListdata;


  final _stateStreamController= StreamController<List<Data>>.broadcast();

  var user_id;
  StreamSink<List<Data>> get newsSink => _stateStreamController.sink;
  Stream<List<Data>> get newsStream => _stateStreamController.stream;

  final _eventStreamController= StreamController<NewsAction>();
  StreamSink<NewsAction> get eventSink => _eventStreamController.sink;
  Stream<NewsAction> get evenStream => _eventStreamController.stream;

  NewsBloc(this.user_id){
    evenStream.listen((event) async {
      if(event == NewsAction.Fetch) {
       try {
         var list_wish= await getWishList();
         newsSink.add(list_wish);
       } on Exception catch (e) {
         newsSink.addError("Something went wrong");
       }
      } else if(event==NewsAction.Delete) {
        await deleteListItem(user_id);
      }
    });
  }

  void dispose(){
    _stateStreamController.close();
    _eventStreamController.close();
  }


  Future<List<Data>> getWishList( ) async {
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
        return _allwishListdata;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        log(e.message.toString(), name: "Get Comment List API Error");
      } else {
        log(e.response!.data.toString(), name: "Get Comment List API Error");

      }
      return _allwishListdata;
    }

    try {
      log(json.encode(jsonDecode(response.data)), name: "Get Comment List API Data");

      wishListdata = WishListData.fromJson(jsonDecode(response.data));
      _allwishListdata=wishListdata.data!;

      return _allwishListdata;
    } catch (e) {
      log(e.toString(), name: "Get Comment List API Exception");
      _allwishListdata.clear();
      return _allwishListdata;
    }
  }


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
        return false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        log(e.message.toString(), name: "Get Comment List API Error");
      } else {
        log(e.response!.data.toString(), name: "Get Comment List API Error");

      }
      return false;
    }

    try {
      log(json.encode(jsonDecode(response.data)), name: "Get Comment List API Data");

      var data=jsonDecode(response.data);
      var check=data["type"];
      if(check=="success"){
        var list_wish= await getWishList();
        newsSink.add(list_wish);
      }else{
      }

      return true;
    } catch (e) {
      log(e.toString(), name: "Get Comment List API Exception");
      return false;
    }
  }


}