class Brand {
  int? id;
  String? brandNameEn;
  String? brandNameAr;
  String? brandSlugEn;
  String? brandSlugAr;
  String? brandImage;
  String? createdAt;
  String? updatedAt;
  int? adminsId;

  Brand(
      {this.id,
      this.brandNameEn,
      this.brandNameAr,
      this.brandSlugEn,
      this.brandSlugAr,
      this.brandImage,
      this.createdAt,
      this.updatedAt,
      this.adminsId});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandNameEn = json['brand_name_en'];
    brandNameAr = json['brand_name_ar'];
    brandSlugEn = json['brand_slug_en'];
    brandSlugAr = json['brand_slug_ar'];
    brandImage = json['brand_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    adminsId = json['admins_id'];
  }
}
