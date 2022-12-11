class CategoriesModel {
  bool? success;
  int? code;
  String? locale;
  String? message;
  Data? data;

  CategoriesModel(
      {this.success, this.code, this.locale, this.message, this.data});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    locale = json['locale'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['code'] = this.code;
    data['locale'] = this.locale;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<CategoryItems>? items;

  Data({this.items});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <CategoryItems>[];
      json['items'].forEach((v) {
        items!.add(new CategoryItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryItems {
  int? id;
  String? categoryNameEn;
  String? categoryNameAr;
  String? categorySlugEn;
  String? categorySlugAr;
  String? categoryIcon;
  String? createdAt;
  String? updatedAt;
  int? adminsId;
  List<Subcategory>? subcategory;

  CategoryItems(
      {this.id,
        this.categoryNameEn,
        this.categoryNameAr,
        this.categorySlugEn,
        this.categorySlugAr,
        this.categoryIcon,
        this.createdAt,
        this.updatedAt,
        this.adminsId,
        this.subcategory});

  CategoryItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryNameEn = json['category_name_en'];
    categoryNameAr = json['category_name_ar'];
    categorySlugEn = json['category_slug_en'];
    categorySlugAr = json['category_slug_ar'];
    categoryIcon = json['category_icon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    adminsId = json['admins_id'];
    if (json['subcategory'] != null) {
      subcategory = <Subcategory>[];
      json['subcategory'].forEach((v) {
        subcategory!.add(new Subcategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name_en'] = this.categoryNameEn;
    data['category_name_ar'] = this.categoryNameAr;
    data['category_slug_en'] = this.categorySlugEn;
    data['category_slug_ar'] = this.categorySlugAr;
    data['category_icon'] = this.categoryIcon;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['admins_id'] = this.adminsId;
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcategory {
  int? id;
  int? categoryId;
  String? subcategoryNameEn;
  String? subcategoryNameAr;
  String? subcategorySlugEn;
  String? subcategorySlugAr;
  String? createdAt;
  String? updatedAt;
  int? adminsId;
  List<Subsubcategory>? subsubcategory;

  Subcategory(
      {this.id,
        this.categoryId,
        this.subcategoryNameEn,
        this.subcategoryNameAr,
        this.subcategorySlugEn,
        this.subcategorySlugAr,
        this.createdAt,
        this.updatedAt,
        this.adminsId,
        this.subsubcategory});

  Subcategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subcategoryNameEn = json['subcategory_name_en'];
    subcategoryNameAr = json['subcategory_name_ar'];
    subcategorySlugEn = json['subcategory_slug_en'];
    subcategorySlugAr = json['subcategory_slug_ar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    adminsId = json['admins_id'];
    if (json['subsubcategory'] != null) {
      subsubcategory = <Subsubcategory>[];
      json['subsubcategory'].forEach((v) {
        subsubcategory!.add(new Subsubcategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['subcategory_name_en'] = this.subcategoryNameEn;
    data['subcategory_name_ar'] = this.subcategoryNameAr;
    data['subcategory_slug_en'] = this.subcategorySlugEn;
    data['subcategory_slug_ar'] = this.subcategorySlugAr;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['admins_id'] = this.adminsId;
    if (this.subsubcategory != null) {
      data['subsubcategory'] =
          this.subsubcategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subsubcategory {
  int? id;
  int? categoryId;
  int? subcategoryId;
  String? subsubcategoryNameEn;
  String? subsubcategoryNameAr;
  String? subsubcategorySlugEn;
  String? subsubcategorySlugAr;
  String? createdAt;
  String? updatedAt;
  int? adminsId;

  Subsubcategory(
      {this.id,
        this.categoryId,
        this.subcategoryId,
        this.subsubcategoryNameEn,
        this.subsubcategoryNameAr,
        this.subsubcategorySlugEn,
        this.subsubcategorySlugAr,
        this.createdAt,
        this.updatedAt,
        this.adminsId});

  Subsubcategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    subsubcategoryNameEn = json['subsubcategory_name_en'];
    subsubcategoryNameAr = json['subsubcategory_name_ar'];
    subsubcategorySlugEn = json['subsubcategory_slug_en'];
    subsubcategorySlugAr = json['subsubcategory_slug_ar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    adminsId = json['admins_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['subsubcategory_name_en'] = this.subsubcategoryNameEn;
    data['subsubcategory_name_ar'] = this.subsubcategoryNameAr;
    data['subsubcategory_slug_en'] = this.subsubcategorySlugEn;
    data['subsubcategory_slug_ar'] = this.subsubcategorySlugAr;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['admins_id'] = this.adminsId;
    return data;
  }
}
