  class UserLoginData {
    String type;
    String message;
    List<Data> data;

    UserLoginData({required this.type, required this.message, required this.data});

    factory UserLoginData.fromJson(Map<String, dynamic> json) {
        return UserLoginData(
            type: json["type"],
            message: json["message"],
            data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        );
    }


    Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };

}

class Data {

    Data({required this.id,
      required this.fname,
      required this.lname,
      required this.email,
      required this.mobileno});

    String id;
    String fname;
    String lname;
    String email;
    String mobileno;




    factory Data.fromJson(Map<String, dynamic> json) { return  Data(
        id : json['id'],
        fname : json['fname'],
        lname : json['lname'],
        email : json['email'],
        mobileno : json['mobileno'],

    );}


    Map<String, dynamic> toJson() => {
        'id': id,
        'fname': fname,
        'lname': lname,
        'lname':email,
        'mobileno': mobileno,
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