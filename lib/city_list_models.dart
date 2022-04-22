class CityListData {
  String type;
  String message;
  List<CityData> data;

  CityListData({required this.type, required this.message, required this.data});

  factory CityListData.fromJson(Map<String, dynamic> json) {
    return CityListData(
      type: json["type"],
      message: json["message"],
      data: List<CityData>.from(json["data"].map((x) => CityData.fromJson(x))),
    );
  }


  Map<String, dynamic> toJson() => {
    "type": type,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

}

class CityData {

  CityData({required this.id,
    required this.city,
    required this.city_alias,
    required this.state,
    required this.country});

  String? id;
  String? city;
  String? city_alias;
  String? state;
  String? country;




  factory CityData.fromJson(Map<String, dynamic> json) { return  CityData(
    id : json['id'],
    city : json['city'],
    city_alias : json['city_alias'],
    state : json['state'],
    country : json['country'],

  );}


  Map<String, dynamic> toJson() => {
    'id': id,
    'city': city,
    'city_alias': city_alias,
    'state':state,
    'country': country,
  };


}