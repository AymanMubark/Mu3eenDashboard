class Admin {
  String? id;
  String? name;
  String? adminName;
  String? phone;
  String? email;
  String? imageUrl;

  Admin(
      {this.id,
      this.name,
      this.adminName,
      this.phone,
      this.email,
      this.imageUrl});

  Admin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    adminName = json['AdminName'];
    phone = json['phone'];
    email = json['email'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['AdminName'] = adminName;
    data['phone'] = phone;
    data['email'] = email;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
