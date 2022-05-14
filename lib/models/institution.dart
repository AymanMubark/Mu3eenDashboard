class Institution {
  String? id;
  String? name;
  String? phone;
  String? email;
  String? imageUrl;
  String? createdAt;

  Institution({this.id, this.name, this.phone, this.email, this.imageUrl});

  Institution.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    imageUrl = json['imageUrl'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['createdAt'] = createdAt;
    data['phone'] = phone;
    data['email'] = email;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
