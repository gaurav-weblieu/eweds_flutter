import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:multi_vendor_project/wish_list_model.dart';

import '../api.dart';


enum LoginAction {
  Fetch,
  Delete
}

class LoginBloc{


  final _stateStreamController= StreamController<bool>.broadcast();

  StreamSink<bool> get loginSink => _stateStreamController.sink;
  Stream<bool> get loginStream => _stateStreamController.stream;

/*
  final _eventStreamController= StreamController<LoginAction>();
  StreamSink<LoginAction> get eventSink => _eventStreamController.sink;
  Stream<LoginAction> get evenStream => _eventStreamController.stream;
*/

  /*LoginBloc(){
    evenStream.listen((event) async {
      if(event == LoginAction.Fetch) {
       try {
         var list_wish= await getWishList();
         loginSink.add(list_wish);
       } on Exception catch (e) {
         loginSink.addError("Something went wrong");
       }
      } else if(event==LoginAction.Delete) {
        await deleteListItem(user_id);
      }
    });
  }*/

  void dispose(){
    _stateStreamController.close();
  }




}