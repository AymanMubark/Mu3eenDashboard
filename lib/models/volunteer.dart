class Volunteer {
  String? id;
  String? name;
  String? imageUrl;
  String? gender;
  String? phone;
  int? age;
  int? points;
  String? createdAt;

  Volunteer(
      {this.id,
      this.name,
      this.imageUrl,
      this.gender,
      this.age,
      this.points,
      this.createdAt});

  Volunteer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['createdAt'];
    phone = json['phone'];
    imageUrl = json['imageUrl'];
    gender = json['gender'];
    age = json['age'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['createdAt'] = createdAt;
    data['phone'] = phone;
    data['imageUrl'] = imageUrl;
    data['gender'] = gender;
    data['age'] = age;
    data['points'] = points;
    return data;
  }
}
