class Reward {
  String? id;
  String? name;
  String? content;
  String? imageUrl;
  String? expiryDate;
  int? points;
  int? numbers;
  String? institutionId;
  String? createdAt;

  Reward(
      {this.id,
      this.name,
      this.content,
      this.imageUrl,
      this.points,
      this.expiryDate,
      this.numbers,
      this.institutionId,
      this.createdAt});

  Reward.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    content = json['content'];
    expiryDate = json['expiryDate'];
    imageUrl = json['imageUrl'];
    points = json['points'];
    numbers = json['numbers'];
    institutionId = json['institutionId'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['expiryDate'] = expiryDate;
    data['content'] = content;
    data['imageUrl'] = imageUrl;
    data['points'] = points;
    data['numbers'] = numbers;
    data['institutionId'] = institutionId;
    data['createdAt'] = createdAt;
    return data;
  }
}
