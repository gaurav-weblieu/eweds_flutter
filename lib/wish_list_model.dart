class WishListData {
  String? type;
  String? message;
  List<Data>? data;

  WishListData({required this.type, required this.message,  required this.data});


  factory WishListData.fromJson(Map<String, dynamic> json) {
    return WishListData(
      type: json["type"],
      message: json["message"],
      data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );
  }
}

class Data {

  Data({
    required this.id,
    required this.wishlist_id,
    required this.email,
    required this.category_id,
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
    required this.description,
    required this.specialmember,
    required this.profilepic,
    required this.bigimage,
    required this.city,
    required this.area_name,
    required this.vendor_details
  });

  var  id;
  var  wishlist_id;
  var  email;
  var  vendor_name;
  var  category_id;
  var  address;
  var  localarea;
  var  pincode;
  var  country;
  var  website;
  var  vendor_email;
  var  contactno;
  var  landline_code;
  var  landline_no;
  var  description;
  var  specialmember;
  var  profilepic;
  var  bigimage;
  var  city;
  var  area_name;
  var  vendor_details;


  factory Data.fromJson(Map<String, dynamic> json) { return  Data(
    id : json['id'],
    wishlist_id : json['wishlist_id'],
    email : json['email'],
    vendor_name: json['vendor_name'],
    category_id: json['category_id'],
    address: json['address'],
    localarea: json['localarea'],
    pincode: json['pincode'],
    country: json['country'],
    website: json['website'],
    vendor_email: json['vendor_email'],
    contactno: json['contactno'],
    landline_code: json['landline_code'],
    landline_no: json['landline_no'],
    description: json['description'],
    specialmember: json['specialmember'],
    profilepic: json['profilepic'],
    bigimage: json['bigimage'],
    city: json['city'],
    area_name: json['area_name'],
    vendor_details: json['vendor_details'],
  );}

}