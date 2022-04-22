
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_vendor_project/shared_pref.dart';
import 'package:multi_vendor_project/shared_pref_temp.dart';
import 'package:multi_vendor_project/sharedpre_provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'LoadingOverlay.dart';
import 'api.dart';
import 'colors.dart';
import 'login_copy.dart';
import 'login_with_otp_screen.dart';
import 'main.dart';
import 'dart:io' as i; //"i" also can be another char or word, is just an example

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  late String month="";
  late String year="";

  late String textHolder = '10';

   late i.File? imageFile;
  bool _load = false;



  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  var image_url="";

  var _var_gen=0;

  SharedPerWithProvider share_pre_pro= new SharedPerWithProvider();

  String? _uid;

  var loading=false;


   ImagePicker picker = ImagePicker();
  late Future<PickedFile?> pickedFile = Future.value(null);


  @override
  void initState() {
    getUserID();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsIconTheme:const IconThemeData(
          color: Colors.white
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        elevation: 2.0,
        backgroundColor: GetColor.appPrimaryColors,
        title: const Text("Add Profile",style: TextStyle(color: Colors.white,fontSize: 16),),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0))),
                      title: const Text('Are you sure ?'),
                      content: const Text('Do you want to logout ?'),
                      actions: [
                        FlatButton(
                          textColor: Colors.black,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('NO'),
                        ),
                        FlatButton(
                          textColor: Colors.black,
                          onPressed: () async {
                            shared_pref sF = shared_pref();
                            bool? logout = await sF.clearPreferences();
                            if (logout) {
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                  const LoginWithOtp()), (Route<dynamic> route) => false);
                              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginWithOtp()));
                            }
                          },
                          child: const Text('YES'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Row(
                children: const [
                  Text("Logout",style: TextStyle(color: Colors.white,fontSize: 16),),
                  Icon(Icons.login_rounded, color: Colors.white,)
                ],
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: LoadingOverlay(
          isLoading: loading,
          child : Column(
            children: [
              /*Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 10.0,),
                child: Center(
                  child: Stack(
                    children:[
                      Container(
                        height: 150.0,
                        width: 150.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(90.0),
                          child: _load ? imageFile!=null ?  Image.file(imageFile!, fit: BoxFit.cover,) : Image.network(image_url) :
                          Card(color: Colors.white, shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(90),
                          ),),
                        ),
                      ),
                      Positioned(
                        bottom: 10.0,
                        left: 110.0,
                        child: GestureDetector(
                          onTap: (){
                            _getFromGallery();
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: GetColor.appPrimaryColors
                            ),
                            child:   const Icon(
                              Icons.add_a_photo_rounded,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                    ]
                  ),
                ),
              ),*/


              Container(
                margin: EdgeInsets.only(top: 15.0),
                child: Card(
                  elevation: 0.0,
                  margin: EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Column(
                              children: [

                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(top: 10.0),
                                              child:  const Align(
                                                child: Text("First Name", style: TextStyle(fontSize: 12.0, color: Colors.grey)),
                                                alignment: Alignment.centerLeft,
                                              ),
                                            ),
                                            TextFormField(
                                              controller: fname,
                                              decoration: const InputDecoration(
                                                  border: UnderlineInputBorder(),
                                                  hintText: '',),
                                              keyboardType: TextInputType.text,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(top: 10.0),
                                              child:  const Align(
                                                child: Text("Last Name", style: TextStyle(fontSize: 12.0, color: Colors.grey)),
                                                alignment: Alignment.centerLeft,
                                              ),
                                            ),
                                            Container(
                                              child:  TextFormField(
                                                controller: lname,
                                                decoration: const InputDecoration(
                                                  border: UnderlineInputBorder(),
                                                  hintText: '',),
                                                keyboardType: TextInputType.text,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),


                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
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
                                              child: TextFormField(
                                                controller: phone,
                                                decoration: const InputDecoration(
                                                    border: UnderlineInputBorder(),
                                                    hintText: ''),
                                                keyboardType: TextInputType.phone,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
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
                                              child:  TextFormField(
                                                controller: email,
                                                decoration: const InputDecoration(
                                                    border: UnderlineInputBorder(),
                                                    hintText: ''),
                                                keyboardType: TextInputType.text,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),





                                Container(
                                  margin: const EdgeInsets.only(top: 25.0),
                                  child: const Align(
                                    child: Text("Gender",
                                        style: TextStyle(color: Colors.grey)),
                                    alignment: Alignment.centerLeft,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 15.0,bottom: 15.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: ToggleSwitch(
                                      minWidth: 100.0,
                                      minHeight: 30.0,
                                      fontSize: 12.0,
                                      borderWidth: 2.0,
                                      borderColor: [GetColor.appPrimaryColors],
                                      initialLabelIndex: _var_gen,
                                      activeBgColor: [GetColor.appPrimaryColors],
                                      activeFgColor: Colors.white,
                                      inactiveBgColor: Colors.white,
                                      inactiveFgColor: Colors.grey[900],
                                      totalSwitches: 2,
                                      labels: ['Female', 'Male'],
                                      onToggle: (index) {
                                       setState(() {
                                         _var_gen=index!;
                                       });
                                      },
                                    ),
                                  ),
                                ),



                                InkWell(
                                  onTap: () {
                                    updateUserDetails(_uid!);
                                    updateUserProfilePic(_uid!);
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: GetColor.appPrimaryColors,
                                        borderRadius: BorderRadius.all(Radius.circular(18.0))
                                    ),
                                    height: 35.0,
                                    margin: const EdgeInsets.only( top: 25.0,bottom: 10.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Save',
                                          style: TextStyle(color:Colors.white,fontSize: 12.0),
                                        ),
                                       /* Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 12,
                                          color: Colors.white,
                                        ),*/
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  Future<String?> getUserID() async {
    shared_pref sF= new shared_pref();
    _uid = await sF.getUid();
    VendorDetails(_uid!);
    return _uid;
  }


  Future<bool> VendorDetails(String? id) async {
    Response response;
    try {
      response = await Dio().post(
        API.user_profile_details,
        data: {
          "id": id,
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
            .showSnackBar(const SnackBar(content: Text("Network not available")));
      }
      return false;
    }

    try {
      log(json.encode(jsonDecode(response.data)), name: "Get Comment List API Data");

      var pofleData=jsonDecode(response.data);


      String  varFname=pofleData["data"][0]["fname"];
      String varLname=pofleData["data"][0]["lname"];
      String varEmail=pofleData["data"][0]["email"];
      String varGender=pofleData["data"][0]["gender"];

      String varMobileno=pofleData["data"][0]["mobileno"];
      String varNewPofileImage=pofleData["data"][0]["profile_image"];


      if (await share_pre_pro.setTempDataProfileProv(varFname,varEmail,varNewPofileImage)) {
      }


      setState(() {
        fname.text=varFname;
        lname.text=varLname;
        email.text=varEmail;
        phone.text=varMobileno;
        image_url=varNewPofileImage;

        if(varGender=="Male"){

            _var_gen=1;
        }else{
            _var_gen=0;
        }
      });


      return true;
    } catch (e) {
      log(e.toString(), name: "Get Comment List API Exception");
     // MyApp.sMKey.currentState!.showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }



  Future<bool> updateUserDetails(String vendorId) async {

    setState(() {
      loading=true;
    });

    var varGender="Female";
    if( _var_gen==1){
       varGender="Male";
    }else{
       varGender="Female";
    }
    Response response;
          try {
            response = await Dio().post(
              API.update_user_profile,
              data: {
                "id":    vendorId,
                "fname":    fname .text,
                "lname":    lname .text,
                "mobileno": phone .text,
                "gender":  varGender,
                "email":    email.text,
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
            setState(() {
              loading=false;
            });
            return false;
          }

          try {
            var data = jsonDecode(response.data);
            var check = data["status"];

            var Message = data["messege"];
            MyApp.sMKey.currentState!.showSnackBar( SnackBar(content: Text(Message)));

            VendorDetails(_uid);

            setState(() {
              loading=false;
            });
            return true;
          } catch (e) {
            setState(() {
              loading=false;
            });
            log(e.toString(), name: "Get Comment List API Exception");
           // MyApp.sMKey.currentState!.showSnackBar(SnackBar(content: Text(e.toString())));
            return false;
          }

  }


  Future<bool> updateUserProfilePic(String vendorId) async {

    setState(() {
      loading=true;
    });

    Response response;
    try {
      response = await Dio().post(
        API.update_user_profile_pic,
        data: {
          "id":    vendorId,
          "fname":    fname .text,
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
      setState(() {
        loading=false;
      });
      return false;
    }

    try {
      var data = jsonDecode(response.data);
      var check = data["status"];
      var Message = data["messege"];
      MyApp.sMKey.currentState!.showSnackBar( SnackBar(content: Text(Message)));

      VendorDetails(_uid);

      setState(() {
        loading=false;
      });
      return true;
    } catch (e) {
      setState(() {
        loading=false;
      });
      log(e.toString(), name: "Get Comment List API Exception");
      // MyApp.sMKey.currentState!.showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }

  }


  _getFromGallery() async {
    PickedFile? pickedFile = await   picker.getImage(source: ImageSource.gallery,).whenComplete(() => {});
    if (pickedFile != null) {
      setState(() {
        _load=true;
        imageFile = File(pickedFile.path);
      });
    }
  }


}
