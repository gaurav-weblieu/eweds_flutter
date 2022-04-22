class SearchListData {
  String? type;
  String? message;
  int? page_length;
  List<DataVendorList>? data;

  SearchListData({required this.type, required this.message, required this.page_length, required this.data});

  factory SearchListData.fromJson(Map<String, dynamic> json) {
    return SearchListData(
      type: json["type"],
      message: json["message"],
      page_length: json["page_length"],
      data: List<DataVendorList>.from(json["data"].map((x) => DataVendorList.fromJson(x))),
    );
  }


 /* Map<String, dynamic> toJson() => {
    "type": type,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };*/

}

class DataVendorList {

  DataVendorList({
    required this.id,
    required this.email,
    required this.category_id,
    required this.city_id,
    required this.vendor_name,
    required this.address,
    required this.localarea,
    required this.pincode,
    required this.country,
    required this.website,
    required this.vendor_email,
    required this.contactno,
    required this.landline_code,
    required this.landline_no,
    required this.specialmember,
    required this.profilepic,
    required this.bigimage,
    required this.city,
    required this.area_name,
    required this.review_rating,
    required this.package_price,
    required this.package_price_detail,
    required this.full_profile_pic

  });

  var  id;
 var  email;
 var  category_id;
 var  city_id;
 var  vendor_name;
 var  address;
 var  localarea;
 var  pincode;
 var  country;
 var  website;
 var  vendor_email;
 var  contactno;
 var  landline_code;
 var  landline_no;
 var  specialmember;
 var  profilepic;
 var  bigimage;
 var  city;
 var  area_name;
 var  review_rating;
 var  package_price;
 var  package_price_detail;
 var  full_profile_pic;




  factory DataVendorList.fromJson(Map<String, dynamic> json) { return  DataVendorList(
      id : json['id'],
      email : json['email'],
      category_id: json['category_id'],
      city_id: json['city_id'],
      vendor_name: json['vendor_name'],
      address: json['address'],
      localarea: json['localarea'],
      pincode: json['pincode'],
      country: json['country'],
      website: json['website'],
      vendor_email: json['vendor_email'],
      contactno: json['contactno'],
      landline_code: json['landline_code'],
      landline_no: json['landline_no'],
      specialmember: json['specialmember'],
      profilepic: json['profilepic'],
      bigimage: json['bigimage'],
      city: json['city'],
      area_name: json['area_name'],
      review_rating: json['review_rating'],
      package_price: json['package_price'],
      package_price_detail: json['package_price_detail'],
      full_profile_pic: json['full_profile_pic'],
  );}

  /*Map<String, dynamic> toJson() => {
    'id': id,
    'city': city,
    'city_alias': city_alias,
    'state':state,
    'country': country,
    'country': country,
    'country': country,
    'country': country,
    'country': country,
    'country': country,
    'country': country,
    'country': country,
    'country': country,
    'country': country,
    'country': country,
    'country': country,
    'country': country,
    'country': country,
    'country': country,
    'country': country,
    'country': country,
    'country': country,
    'country': country,
    'country': country,
  };*/


}