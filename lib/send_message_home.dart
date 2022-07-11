import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:multi_vendor_project/shared_pref_temp.dart';
import 'package:multi_vendor_project/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'api.dart';
import 'colors.dart';
import 'complete_request_screen.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;


class SendEnqueryHome extends StatefulWidget {

   SendEnqueryHome({Key? key}) : super(key: key);

  @override
  _SendEnqueryHomeState createState() => _SendEnqueryHomeState();
}

class _SendEnqueryHomeState extends State<SendEnqueryHome> {

  late String no_of_guest="Please Select No Of Guest";


  String _selectedDate = 'Please Select Date';




  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  SharedPrefTemp share_pre_temp= SharedPrefTemp();

  bool value = false;

  bool is_complete_request=false;




  Color colors_container_no_of_gust = Colors.grey ;
  Color colors_container_date = Colors.grey ;



  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  late var _items;

  var _selectedAnimals2 = [];

  Color colors_container_cate = Colors.grey ;


  List<CategoryListModel> _allCatListData = [];
  late Future<List<CategoryListModel>> AllcategoryListModel;

  var golbal_id="";


  @override
  void initState() {
    setTempDate();
    getlisst();

    _items = _allCatListData.map((cat_list_data) => MultiSelectItem<CategoryListModel>(
        cat_list_data, cat_list_data.category_name))
        .toList();
  }

  Future<List<CategoryListModel>> getlisst() async {
    AllcategoryListModel = fetchCategory();
    _allCatListData = await AllcategoryListModel;
    setState(() {
      _items = _allCatListData
          .map((cat_list_data) => MultiSelectItem<CategoryListModel>(
          cat_list_data, cat_list_data.category_name))
          .toList();
    });
    return _allCatListData;
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

  final _formKey = GlobalKey<FormState>();


  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
        // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
      //  _selectedDate = args.value.toString();
        _selectedDate = DateFormat('dd/MM/yyyy').format(args.value);
        Navigator.pop(context);
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        elevation: 2.0,
        backgroundColor: GetColor.appPrimaryColors,
        title: const Text("Send Enquiry",style: TextStyle(color: Colors.white,fontSize: 16),),

      ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 10.0,top: 10.0),
                  child: Column(
                    children: [
                     /* Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        child:  Align(
                          child: Text("Hiii , "+var_res["data"][0]["vendor_name"],
                              style: const TextStyle(
                                  color: Colors.black45, fontSize: 21.0,fontWeight: FontWeight.bold)),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
*/
                     /* Container(
                        margin: const EdgeInsets.only(top: 5.0,bottom: 10.0),
                        color: GetColor.appPrimaryColors,
                        width: double.infinity,
                        height: 2.0,
                      ),*/

                      Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        child: const Align(
                          child: Text("Full Name",
                              style:
                                  TextStyle(fontSize: 12.0, color: Colors.grey)),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      Container(
                        child:  TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter name';
                            }
                            return null;
                          },
                          controller: name,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'Please enter name'),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 25.0),
                        child: const Align(
                          child: Text("Mobile No",
                              style:
                                  TextStyle(fontSize: 12.0, color: Colors.grey)),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      Container(
                        child:  TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter mobile no.';
                            }
                            return null;
                          },
                          controller: phone,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'Please enter mobile no'),
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 25.0),
                        child: const Align(
                          child: Text("Email Address",
                              style:
                                  TextStyle(fontSize: 12.0, color: Colors.grey)),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Email Address';
                            }
                            return null;
                          },
                          controller: email,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'Please enter Email Address'),
                          keyboardType: TextInputType.text,
                        ),
                      ),


                      Container(
                        margin: const EdgeInsets.only(top: 25.0),
                        child: const Align(
                          child: Text("Select Date",
                              style:
                              TextStyle(fontSize: 12.0, color: Colors.grey)),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      GestureDetector(
                        onTap: showBottomDate,
                        child: Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          child:  Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _selectedDate,
                              style:
                              const TextStyle(color: Colors.black, fontSize: 16.0,),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                        color: colors_container_date,
                        width: double.infinity,
                        height: 1.0,
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.white,
                          border: Border.all(
                            color: colors_container_cate,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            MultiSelectBottomSheetField(
                              initialChildSize: 0.4,
                              listType: MultiSelectListType.CHIP,
                              searchable: true,
                              buttonText: const Text("Select Categories"),
                              title: const Text("Categories"),
                              items: _items,
                              onConfirm: (values) {
                                _selectedAnimals2 = values;
                              },
                              chipDisplay: MultiSelectChipDisplay(
                                onTap: (value) {
                                  setState(() {
                                    _selectedAnimals2.remove(value);
                                  });
                                },
                              ),
                            ),
                            _selectedAnimals2.isEmpty
                                ? Container(
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "None selected",
                                  style: TextStyle(color: Colors.black54),
                                ))
                                : Container(),
                          ],
                        ),
                      ),


                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: GetColor.appPrimaryColors,
                              value: this.value,
                              onChanged: (bool? value) {
                                setState(() {
                                  this.value = value!;
                                });
                              },
                            ),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Send me details on WhatsApp",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,),),
                                ],
                              ),
                            ),




                          ],
                        ),
                      ),

                      /*Container(
                        margin: const EdgeInsets.only(top: 15.0),
                        child: const Align(
                          child: Text("Function Type",
                              style: TextStyle(color: Colors.grey)),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ToggleSwitch(
                            minWidth: 100.0,
                            minHeight: 30.0,
                            fontSize: 12.0,
                            borderWidth: 2.0,
                            borderColor: [GetColor.appPrimaryColors],
                            initialLabelIndex: 1,
                            activeBgColor: [GetColor.appPrimaryColors],
                            activeFgColor: Colors.white,
                            inactiveBgColor: Colors.white,
                            inactiveFgColor: Colors.grey[900],
                            totalSwitches: 2,
                            labels: ['Evening', 'Day'],
                            onToggle: (index) {
                              print('switched to: $index');
                            },
                          ),
                        ),
                      ),*/
                      /*Container(
                        margin: const EdgeInsets.only(top: 15.0),
                        child: const Align(
                          child: Text("Function Time",
                              style: TextStyle(color: Colors.grey)),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ToggleSwitch(
                            minWidth: 100.0,
                            minHeight: 30.0,
                            fontSize: 12.0,
                            borderWidth: 2.0,
                            borderColor: [GetColor.appPrimaryColors],
                            initialLabelIndex: 1,
                            activeBgColor: [GetColor.appPrimaryColors],
                            activeFgColor: Colors.white,
                            inactiveBgColor: Colors.white,
                            inactiveFgColor: Colors.grey[900],
                            totalSwitches: 2,
                            labels: ['Pre-wedding', 'Wedding'],
                            onToggle: (index) {
                              print('switched to: $index');
                            },
                          ),
                        ),
                      ),*/


                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 40.0,
                          margin: const EdgeInsets.only(top: 50.0),
                          child: ElevatedButton(
                            onPressed: () {
                              setEnqueryDetails();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: GetColor.appPrimaryColors, // Background color
                              onPrimary: Colors.white, // Text Color (Foreground color)
                              minimumSize: const Size.fromHeight(50),

                            ),
                            child: const Text('Send Enquiry'),
                          ),
                        ),
                      ),


                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: const EdgeInsets.only(top: 15.0, bottom: 50.0),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("By Clicking Send Message you are agree on our ",
                                  style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 12.0),),
                                Text("Term & Condition",
                                  style: TextStyle(color: GetColor.appPrimaryColors,fontWeight: FontWeight.w400,fontSize: 12.0),),
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  late int selectedValue;

  showBottomSheet() {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius:BorderRadius.circular(10.0)
        ),
        builder: (BuildContext bc) {
          return Wrap(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                  setState(() {
                                    no_of_guest = 'Please select no of guest';
                                  });
                                  },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )),
                      ),
                      Expanded(
                        child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: const EdgeInsets.all(10.0),
                              child: const Text(
                                'No of People',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                      Expanded(
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                  setState(() {
                                    no_of_guest;
                                  });
                                },
                                child: const Text(
                                  'Save',
                                  style: TextStyle(
                                    color: GetColor.appPrimaryColors,
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 250.0,
                          child: CupertinoPicker(
                            backgroundColor: Colors.white,
                            useMagnifier: true,
                            magnification: 1.2,
                            onSelectedItemChanged: (value) {
                              setState(() {
                                selectedValue = value;
                                switch(value){
                                  case 0:
                                    no_of_guest = '10-20';
                                    break;

                                  case 1:
                                    no_of_guest = "20-30";
                                    break;

                                  case 2:
                                    no_of_guest = "30-40";
                                    break;
                                  case 3:
                                    no_of_guest = "40-50";
                                    break;

                                }
                              });
                            },
                            itemExtent: 32.0,
                            children: const [
                              Text('10-20'),
                              Text('20-30'),
                              Text('30-40'),
                              Text('40-50'),
                              Text('50-60'),
                              Text('60-100'),
                              Text('100-150'),
                              Text('150-200'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          );
        });
  }




  showBottomDate() {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(10.0)
        ),
        builder: (BuildContext bc) {
          return Container(
            height: 350,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                                setState(() {
                                  _selectedDate = 'Please Select Date';
                                });
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )),
                    ),
                    Expanded(
                      child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: const EdgeInsets.all(10.0),
                            child: const Text(
                              'Select Date',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                  color: GetColor.appPrimaryColors,
                                ),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
                Container(
                  height: 300,
                  child: SfDateRangePicker(
                    onSelectionChanged: _onSelectionChanged,
                    selectionMode: DateRangePickerSelectionMode.single,
                    /*initialSelectedRange: PickerDateRange(
                        DateTime.now().subtract(const Duration(days: 4)),
                        DateTime.now().add(const Duration(days: 3))),*/
                  ),
                ),
              ],
            ),
          );
        });
  }

  void exitScreen(){
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }


  showBottomDateStatus() {

    exitScreen();

    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(10.0)
        ),
    builder: (context) {
    return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
    return Container(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 22.0),
                      child: Center(child: Lottie.asset('images/complete_req.json',height: 250.0,width: 250.0))),
                  Container(
                    margin: EdgeInsets.only(top: 35.0),
                    child: const Center(child: Text("Enquiry submitted Successfully",style: TextStyle(fontSize: 21.0,
                        color: Colors.black,fontWeight: FontWeight.bold),)),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: const Center(child: Text("Vendor will contact you soon",style: TextStyle(fontSize: 16.0,color: Colors.black
                        ,fontWeight: FontWeight.bold),)),
                  )
                ],
              )
            ),
          );});
        });
  }

  Future<bool> setEnqueryDetails() async {

    setState(() {
      colors_container_no_of_gust=Colors.grey;
      colors_container_date=Colors.grey;
    });

    if(_formKey.currentState!.validate()) {

      if (_selectedDate != "Please Select Date") {

        List<CategoryListModel>? _allCatListData = _selectedAnimals2.cast<
            CategoryListModel>();

        if (_allCatListData.isNotEmpty) {

          for (int i = 0; i < _allCatListData.length; i++) {
            String cat_id = _allCatListData.elementAt(i).id;
            golbal_id = golbal_id + "," + cat_id;
          }


        Response response;
        try {
          response = await Dio().post(
            API.save_home_enquiry,
            data: {
              "name": name.text,
              "email": email.text,
              "phone": "91",
              "category": golbal_id,
              "remark": "",
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
                SnackBar(content: Text("Network not available")));
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
                SnackBar(content: Text("Network not available")));
          } else {
            log(e.response!.data.toString(),
                name: "Get Comment List API Error");
            MyApp.sMKey.currentState!
                .showSnackBar(SnackBar(content: Text("Network not available")));
          }
          return false;
        }

        try {
         // log(json.encode(jsonDecode(response.data)), name: "Get Comment List API Data");

          //var data = jsonDecode(response.data);
          /*var check = data["type"];

          if (check == "success") {

            if (await share_pre_temp.setTempData(name.text, email.text, phone.text)) {
             // MyApp.sMKey.currentState!.showSnackBar(const SnackBar(content: Text("Enquery Send Successfully!!!")));
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CompleteRequestPage()),
              );

              showBottomDateStatus();

            }

          } else {
            MyApp.sMKey.currentState!.showSnackBar(const SnackBar(content: Text("Enquery Failed!!!")));
          }*/



          if (await share_pre_temp.setTempData(name.text, email.text, phone.text)) {
            // MyApp.sMKey.currentState!.showSnackBar(const SnackBar(content: Text("Enquery Send Successfully!!!")));
            showBottomDateStatus();

          }

          return true;
        } catch (e) {
          log(e.toString(), name: "Get Comment List API Exception");
          MyApp.sMKey.currentState!.showSnackBar(
              SnackBar(content: Text(e.toString())));
          return false;
        }
      }else{
          MyApp.sMKey.currentState!.showSnackBar(const SnackBar(content: Text("Please Select Categories")));
          setState(() {
            colors_container_date=Colors.red;
          });
          return false;
        }
      }else{
        MyApp.sMKey.currentState!.showSnackBar(const SnackBar(content: Text("Please Select Event Date")));
        setState(() {
          colors_container_date=Colors.red;
        });
        return false;
      }

    }
    else{
      return false;
    }
  }

  Future<void> setTempDate() async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    name.text=pref.getString("fullNameTemp")!;
    email.text=pref.getString("emailTemp")!;
    phone.text=pref.getString("mobileTemp")!;

  }






}
