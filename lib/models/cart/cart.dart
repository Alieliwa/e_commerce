class getCartModel {
  bool? success;
  int? code;
  String? locale;
  String? message;
  Data? data;

  getCartModel({this.success, this.code, this.locale, this.message, this.data});

  getCartModel.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  var id;
  var productId;
  var userId;
  var quantity;
  var createdAt;
  var updatedAt;
  Product? product;

  Items(
      {this.id,
      this.productId,
      this.userId,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.product});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    userId = json['user_id'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['user_id'] = this.userId;
    data['quantity'] = this.quantity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  var id;
  var brandId;
  var categoryId;
  var subcategoryId;
  var subsubcategoryId;
  String? productNameEn;
  String? productNameAr;
  String? productSlugEn;
  String? productSlugAr;
  String? productCode;
  String? productQty;
  List<String>? productTagsEn;
  List<String>? productTagsAr;
  List<String>? productSizeEn;
  List<String>? productSizeAr;
  List<String>? productColorEn;
  List<String>? productColorAr;
  String? sellingPrice;
  String? discountPrice;
  String? shortDescpEn;
  String? shortDescpAr;
  String? longDescpEn;
  String? longDescpAr;
  String? productThambnail;
  var hotDeals;
  var featured;
  var specialOffer;
  var specialDeals;
  var status;
  String? createdAt;
  String? updatedAt;
  var adminsId;
  var rate;

  Product(
      {this.id,
      this.brandId,
      this.categoryId,
      this.subcategoryId,
      this.subsubcategoryId,
      this.productNameEn,
      this.productNameAr,
      this.productSlugEn,
      this.productSlugAr,
      this.productCode,
      this.productQty,
      this.productTagsEn,
      this.productTagsAr,
      this.productSizeEn,
      this.productSizeAr,
      this.productColorEn,
      this.productColorAr,
      this.sellingPrice,
      this.discountPrice,
      this.shortDescpEn,
      this.shortDescpAr,
      this.longDescpEn,
      this.longDescpAr,
      this.productThambnail,
      this.hotDeals,
      this.featured,
      this.specialOffer,
      this.specialDeals,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.adminsId,
      this.rate});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandId = json['brand_id'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    subsubcategoryId = json['subsubcategory_id'];
    productNameEn = json['product_name_en'];
    productNameAr = json['product_name_ar'];
    productSlugEn = json['product_slug_en'];
    productSlugAr = json['product_slug_ar'];
    productCode = json['product_code'];
    productQty = json['product_qty'];
    productTagsEn = json['product_tags_en'].cast<String>();
    productTagsAr = json['product_tags_ar'].cast<String>();
    productSizeEn = json['product_size_en'].cast<String>();
    productSizeAr = json['product_size_ar'].cast<String>();
    productColorEn = json['product_color_en'].cast<String>();
    productColorAr = json['product_color_ar'].cast<String>();
    sellingPrice = json['selling_price'];
    discountPrice = json['discount_price'];
    shortDescpEn = json['short_descp_en'];
    shortDescpAr = json['short_descp_ar'];
    longDescpEn = json['long_descp_en'];
    longDescpAr = json['long_descp_ar'];
    productThambnail = json['product_thambnail'];
    hotDeals = json['hot_deals'];
    featured = json['featured'];
    specialOffer = json['special_offer'];
    specialDeals = json['special_deals'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    adminsId = json['admins_id'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brand_id'] = this.brandId;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['subsubcategory_id'] = this.subsubcategoryId;
    data['product_name_en'] = this.productNameEn;
    data['product_name_ar'] = this.productNameAr;
    data['product_slug_en'] = this.productSlugEn;
    data['product_slug_ar'] = this.productSlugAr;
    data['product_code'] = this.productCode;
    data['product_qty'] = this.productQty;
    data['product_tags_en'] = this.productTagsEn;
    data['product_tags_ar'] = this.productTagsAr;
    data['product_size_en'] = this.productSizeEn;
    data['product_size_ar'] = this.productSizeAr;
    data['product_color_en'] = this.productColorEn;
    data['product_color_ar'] = this.productColorAr;
    data['selling_price'] = this.sellingPrice;
    data['discount_price'] = this.discountPrice;
    data['short_descp_en'] = this.shortDescpEn;
    data['short_descp_ar'] = this.shortDescpAr;
    data['long_descp_en'] = this.longDescpEn;
    data['long_descp_ar'] = this.longDescpAr;
    data['product_thambnail'] = this.productThambnail;
    data['hot_deals'] = this.hotDeals;
    data['featured'] = this.featured;
    data['special_offer'] = this.specialOffer;
    data['special_deals'] = this.specialDeals;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['admins_id'] = this.adminsId;
    data['rate'] = this.rate;
    return data;
  }
}
