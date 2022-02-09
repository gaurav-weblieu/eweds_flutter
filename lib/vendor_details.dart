import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_project/send_message.dart';

class vendor_details extends StatefulWidget {
  const vendor_details({Key? key}) : super(key: key);

  @override
  _vendor_detailsState createState() => _vendor_detailsState();
}

class _vendor_detailsState extends State<vendor_details> {

  List<String> titles = ['Sun'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.blue, //change your color here
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              "Ruaj Tent ,Delhi",
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
            Text(
              'Delhi, Ncr near ....',
              style: TextStyle(color: Colors.grey, fontSize: 12.0
                  , fontWeight: FontWeight.w300),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10.0,),
            child: const Icon(
              Icons.shortcut,
              size: 25,
              color: Colors.blue,
            ),
          ),

          Container(
            margin: EdgeInsets.all(15.0),
            child: const Icon(
              Icons.bookmark_border_rounded,
              size: 25,
              color: Colors.blue,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        color: Colors.white,
                        child: Image.asset(
                          "images/imagetwo.jpg",
                          height: 230,
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 210),
                        width: double.infinity,
                        child: Card(
                          elevation: 0.0,
                          margin: const EdgeInsets.all(0.0),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topLeft: Radius
                                .circular(15), topRight: Radius.circular(15),),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: const Text(
                                        "Saya Grand Club & Spa Resort",
                                        style: TextStyle(color: Colors.black54,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      margin: EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                    ),
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.location_on_rounded,
                                          size: 15,
                                          color: Colors.black54,
                                        ),
                                        Text(
                                          "Mumbai ",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 5.0),
                                      child: const Text(
                                        "Anuj Village , Beroj Junction,Thane ,Maharasthra 42152",
                                        style: TextStyle(color: Colors.grey,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),

                                    Container(
                                      margin: const EdgeInsets.only(top: 10.0),
                                      child: const Text(
                                        "Veg Price",
                                        style: TextStyle(color: Colors.grey,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 5.0),
                                          child: const Text(
                                            "Rs ",
                                            style: TextStyle(color: Colors.blue,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 5.0),
                                          child: const Text(
                                            "1800",
                                            style: TextStyle(color: Colors.blue,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 5.0),
                                          child: const Text(
                                            " per plate",
                                            style: TextStyle(
                                                color: Colors.black45,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      child: const Text(
                                        "Price info",
                                        style: TextStyle(
                                            decoration: TextDecoration
                                                .underline,
                                            color: Colors.grey,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),


                                    InkWell(
                                      onTap: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>  profilePage()),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 10.0,bottom: 10.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                width: double.infinity,
                                                color: Colors.white,
                                                child: FlatButton(
                                                  onPressed: null,
                                                  child: const Text('Send Message', style: TextStyle(
                                                      color: Colors.blue
                                                  ),
                                                  ),
                                                  textColor: Colors.white,
                                                  shape: RoundedRectangleBorder(side: const BorderSide(
                                                      color: Colors.blue,
                                                      width: 1,
                                                      style: BorderStyle.solid
                                                  ), borderRadius: BorderRadius.circular(12)),
                                                ),
                                              ),
                                            ),

                                             Container(
                                               margin: const EdgeInsets.only(left: 10.0),
                                               child: const Icon(
                                                Icons.call_rounded,
                                                size: 35,
                                                color: Colors.green,
                                            ),
                                             ),

                                          ],
                                        ),
                                      ),
                                    ),


                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              top: 15.0, bottom: 5.0),

                                          child: Text(
                                            'Albums (1)',
                                            style: TextStyle(
                                                color: Colors.grey.shade700,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0),
                                          ),
                                        )),
                                    SizedBox(
                                      height: 180,
                                      child: Expanded(child: _myListView1()),
                                    ),

                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 70.0, right: 70.0),
                                      child: FlatButton(
                                        onPressed: null,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: const [
                                            Text(
                                              'See All Album', style: TextStyle(
                                                color: Colors.blue
                                            ),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 15,
                                              color: Colors.blue,
                                            ),
                                          ],
                                        ),
                                        textColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: Colors.blue,
                                                width: 1,
                                                style: BorderStyle.solid
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                12)),
                                      ),
                                    ),


                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 15.0, bottom: 5.0),
                                      child: Text(
                                        'About Sya Grand Club & Spa Resort',
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5.0),
                                      child: Text(
                                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.0),
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 15.0, bottom: 5.0),
                                      child: Text(
                                        'Been on Eweds Since',
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.0),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5.0),
                                      child: Text(
                                        "3 year 1 month",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.0),
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 15.0, bottom: 5.0),
                                      child: Text(
                                        'Outside Alchol perimitted',
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.0),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5.0),
                                      child: Text(
                                        "Outside Alchool is not perimitted ",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.0),
                                      ),
                                    ),

                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: 15.0, bottom: 5.0),

                                          child: Text(
                                            'Review (1)',
                                            style: TextStyle(
                                                color: Colors.grey.shade700,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0),
                                          ),
                                        )),

                                    Row(
                                      children: [

                                        Container(
                                          margin: const EdgeInsets.only(
                                            right: 10.0,),
                                          child: const Icon(
                                            Icons.person_pin,
                                            size: 70,
                                            color: Colors.grey,
                                          ),
                                        ),

                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: [
                                            Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 5.0),
                                                  child: const Text(
                                                    'Yanish Nagar',
                                                    style: TextStyle(
                                                        color: Colors.black45,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: 16.0),
                                                  ),
                                                )),
                                            Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 5.0),
                                                  child: Text(
                                                    'Lorem Ipsum is simply dummy text of the \n'
                                                        ' printing and  typesetting industry.',
                                                    style: TextStyle(
                                                        color: Colors.grey
                                                            .shade400,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: 12.0),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ],),

                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 5.0, bottom: 5.0),
                                      width: double.infinity,
                                      height: 2.0,
                                      color: Colors.grey.shade300,
                                    ),

                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                right: 10.0),
                                            child: FlatButton(
                                              onPressed: null,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .center,
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center,
                                                children: const [
                                                  Text('See All Album',
                                                    style: TextStyle(
                                                        color: Colors.blue
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    size: 15,
                                                    color: Colors.blue,
                                                  ),
                                                ],
                                              ),
                                              textColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: Colors.blue,
                                                      width: 1,
                                                      style: BorderStyle.solid
                                                  ),
                                                  borderRadius: BorderRadius
                                                      .circular(12)),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(left: 10.0),

                                            child: FlatButton(
                                              onPressed: null,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .center,
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center,
                                                children: const [
                                                  Text('See All Album',
                                                    style: TextStyle(
                                                        color: Colors.blue
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    size: 15,
                                                    color: Colors.blue,
                                                  ),
                                                ],
                                              ),
                                              textColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: Colors.blue,
                                                      width: 1,
                                                      style: BorderStyle.solid
                                                  ),
                                                  borderRadius: BorderRadius
                                                      .circular(12)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),


                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 10.0, top: 10.0),
                                    child: Text(
                                      'Browse similar Vendors',
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                    ),
                                  )),
                              Container(
                                height: 250,
                                child: Expanded(child: _myListView2()),
                              ),
                            ],),),
                      ),
                    ],),
                ],),




            ]
        ),
      ),
    );
  }


  Widget _myListView2() {
    return ListView.builder(
      itemCount: titles.length,
      itemBuilder: (context, index) {
        final item = titles[index];
        return GestureDetector(
          onTap: () {
            /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => JobDetailsPage()),
            );*/
          },
          child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          "images/imageone.jpg",
                          width: 180,
                          height: 160,
                          fit: BoxFit.cover,
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0,),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 5.0,),
                          child: Text(
                            'Saya Grand club & \n and Spa..',
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5.0, top: 5),
                          child: Text(
                            'Bhiwadi',
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5.0, top: 10.0),
                          child: const Text(
                            '1,800 per plate',
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              )),
        );
      },
    );
  }

  Widget _myListView1() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: titles.length,
      itemBuilder: (context, index) {
        final item = titles[index];
        return GestureDetector(
          onTap: () {
            /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => JobDetailsPage()),
            );*/
          },
          child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          "images/imageone.jpg",
                          width: 220,
                          height: 160,
                          fit: BoxFit.cover,
                        )),
                  ),

                ],
              )),
        );
      },
    );
  }
}
