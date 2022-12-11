class LoginModel {
  bool? status;
  String? message;
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  User? user;

  LoginModel(
      {this.status,
      this.message,
      this.accessToken,
      this.tokenType,
      this.expiresIn,
      this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  Null? emailVerifiedAt;
  Null? currentTeamId;
  String? profilePhotoPath;
  String? createdAt;
  String? updatedAt;
  String? lastSeen;
  int? userType;
  String? profilePhotoUrl;

  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.emailVerifiedAt,
      this.currentTeamId,
      this.profilePhotoPath,
      this.createdAt,
      this.updatedAt,
      this.lastSeen,
      this.userType,
      this.profilePhotoUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    emailVerifiedAt = json['email_verified_at'];
    currentTeamId = json['current_team_id'];
    profilePhotoPath = json['profile_photo_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastSeen = json['last_seen'];
    userType = json['userType'];
    profilePhotoUrl = json['profile_photo_url'];
  }
}
