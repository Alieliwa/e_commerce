class Category {
  int? id;
  String? categoryNameEn;
  String? categoryNameAr;
  String? categorySlugEn;
  String? categorySlugAr;
  String? categoryIcon;
  String? createdAt;
  String? updatedAt;
  int? adminsId;

  Category(
      {this.id,
      this.categoryNameEn,
      this.categoryNameAr,
      this.categorySlugEn,
      this.categorySlugAr,
      this.categoryIcon,
      this.createdAt,
      this.updatedAt,
      this.adminsId});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryNameEn = json['category_name_en'];
    categoryNameAr = json['category_name_ar'];
    categorySlugEn = json['category_slug_en'];
    categorySlugAr = json['category_slug_ar'];
    categoryIcon = json['category_icon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    adminsId = json['admins_id'];
  }
}
