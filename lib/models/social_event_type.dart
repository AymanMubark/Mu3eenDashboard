class SocialEventType {
  String? id;
  String? name;
  String? nameAr;

  SocialEventType({this.id, this.name, this.nameAr});

  SocialEventType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['nameAr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['nameAr'] = nameAr;
    return data;
  }
}
