class PhotoModel {
  String status;
  String message;
  List<PhotoData> data;

  PhotoModel({required this.status, required this.message, required this.data});

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      status: json["status"],
      message: json["message"],
      data: List<PhotoData>.from(json["data"].map((x) => PhotoData.fromJson(x))),
    );
  }


  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

}

class PhotoData {

  PhotoData({required this.id,
    required this.vendorid,
    required this.cat_id,
    required this.pic_text,
    required this.pic_path,
    required this.flagvalue,

  });

  String id;
  String vendorid;
  String cat_id;
  String pic_text;
  String pic_path;
  String flagvalue;




  factory PhotoData.fromJson(Map<String, dynamic> json) { return  PhotoData(
    id : json['id'],
    vendorid : json['vendorid'],
    cat_id : json['cat_id'],
    pic_text : json['pic_text'],
    pic_path : json['pic_path'],
    flagvalue : json['flagvalue'],

  );}


  Map<String, dynamic> toJson() => {
    'id': id,
    'vendorid': vendorid,
    'cat_id': cat_id,
    'pic_text':pic_text,
    'pic_path': pic_path,
    'flagvalue': flagvalue,
  };


}

class SignupModel {
  String error;
  String message;

  SignupModel({ required this.error,  required this.message});

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      error: json["error"],
      message: json["message"],
    );
  }


  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
  };

}

class CategoryListModel {
  String id;
  String category_name;
  String app_cat_icon;
  String category_icon;
  String cat_big_img;
  String app_five_icon;

  CategoryListModel({ required this.id,  required this.category_name, required this.app_cat_icon,
    required this.category_icon,required this.cat_big_img,required this.app_five_icon});

  factory CategoryListModel.fromJson(Map<String, dynamic> json) {
    return CategoryListModel(
        id: json["id"],
        category_name: json["category_name"],
        app_cat_icon: json["app_cat_icon"],
        category_icon: json["category_icon"],
        cat_big_img: json["cat_big_img"],
        app_five_icon: json["app_five_icon"]
    );
  }


  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": category_name,
    "app_cat_icon": app_cat_icon,
    "category_icon": category_icon,
    "cat_big_img": cat_big_img,
    "app_five_icon": app_five_icon,
  };

}