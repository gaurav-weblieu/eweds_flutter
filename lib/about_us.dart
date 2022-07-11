import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_vendor_project/colors.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us",style: TextStyle(fontSize: 16.0),),

        backgroundColor: GetColor.appPrimaryColors,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 250.0,
              width: double.infinity,
              child:Image.asset("images/about__us_image.png")),
          Container(
            margin: EdgeInsets.all(15.0),
            child: Text("eWeds is India's most loving Wedding Vendor Portal! You can search here for interesting vendors like wedding"
                " planners, photographers, Choreographers, Venues, Decorators, Dress and attire, Beauty and care, cakes, Caterers, DJ and music, Invitations, Astrologers, Guest accomodations, Honeymoon, Gifts, Fireworks, Sweet shops, Fruit Baskets, Jewellery and Palki. We have a vendor for all your needs!And for your comfort, you can find profile details and photos for all of these wedding vendors. For all your inspirations and ideas, we have a gallery of never ending photos that will keep you busy.",
            style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.w200),),
          ),
        ],
      ),
    );
  }
}
