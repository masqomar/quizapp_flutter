class UserModel {
  int? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? role;
  String? createdAt;
  String? updatedAt;

  UserModel({
    this.id,
    this.userName,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['role'] = role;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    return data;
  }
}
