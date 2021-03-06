class Admin {
  String? id;
  String? name;
  String? userName;
  String? phone;
  String? email;
  String? imageUrl;
  String? createdAt;

  Admin(
      {this.id,
      this.name,
      this.userName,
      this.phone,
      this.email,
      this.createdAt,
      this.imageUrl});

  Admin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userName = json['userName'];
    createdAt = json['createdAt'];
    phone = json['phone'];
    email = json['email'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['createdAt'] = createdAt;
    data['userName'] = userName;
    data['phone'] = phone;
    data['email'] = email;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
