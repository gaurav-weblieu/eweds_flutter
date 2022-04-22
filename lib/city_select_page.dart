import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'api.dart';
import 'city_list_models.dart';
import 'colors.dart';
import 'dashboard.dart';
import 'main.dart';
import 'shared_pref.dart';

class SelectCityPage extends StatefulWidget {
  const SelectCityPage({Key? key}) : super(key: key);

  @override
  _SelectCityPageState createState() => _SelectCityPageState();
}

class _SelectCityPageState extends State<SelectCityPage> {
  late List<CityData> _allUsers = [];

  // This list holds the data for the list view
  List<CityData> _foundUsers = [];

  List<CityData> results = [];

  late CityListData cityListData;

  @override
  initState() {
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user.city!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundUsers.clear();
      _foundUsers = results;
    });
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
        title: const Text(
          "Select City ",
          style: TextStyle(color: GetColor.appPrimaryColors, fontSize: 16),
        ),
      ),
      body: Column(
        children: [

          Container(
            height: 40.0,
            margin: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: TextField(
              onChanged: (value) {
                _runFilter(value);
              },
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
          ),
          Flexible(
            child: setupAlertDialoadContainer(),
          ),
        ],
      ),
    );
  }

  Widget setupAlertDialoadContainer() {
    return SizedBox(
      height: double.infinity,
      child: FutureBuilder<bool>(
        future: getCityList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return _foundUsers.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundUsers.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      InkWell(
                        onTap: () {
                          shared_pref sF = shared_pref();
                          sF.setCityDetails(
                              _foundUsers.elementAt(index).city.toString());
                          Navigator.pushReplacement<void, void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  DashboardPage(),
                            ),
                          );
                        },
                        child: Container(
                            height: 40,
                            margin: EdgeInsets.all(10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  _foundUsers
                                      .elementAt(index)
                                      .city
                                      .toString(),
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold),
                                ))),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 10.0, right: 10.0),
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
}
