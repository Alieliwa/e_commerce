class DealsModel {
  bool? success;
  int? code;
  String? locale;
  String? message;
  Data? data;

  DealsModel({this.success, this.code, this.locale, this.message, this.data});

  DealsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    locale = json['locale'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<DealsItems>? items;

  Data({this.items});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <DealsItems>[];
      json['items'].forEach((v) {
        items!.add(new DealsItems.fromJson(v));
      });
    }
  }
}

class DealsItems {
  int? id;
  int? brandId;
  int? categoryId;
  int? subcategoryId;
  int? subsubcategoryId;
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
  int? hotDeals;
  int? featured;
  int? specialOffer;
  int? specialDeals;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? adminsId;
  double? rate;

  DealsItems(
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

  DealsItems.fromJson(Map<String, dynamic> json) {
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
    rate =  double.parse(json['rate'].toString());
  }
}
