class SliderModel {
  bool? success;
  int? code;
  String? locale;
  String? message;
  Data? data;

  SliderModel({this.success, this.code, this.locale, this.message, this.data});

  SliderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    locale = json['locale'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<Items>? items;

  Data({this.items});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }
}

class Items {
  int? id;
  String? sliderImg;
  String? title;
  String? description;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? adminsId;

  Items(
      {this.id,
      this.sliderImg,
      this.title,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.adminsId});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sliderImg = json['slider_img'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    adminsId = json['admins_id'];
  }
}
