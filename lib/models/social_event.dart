import 'social_event_type.dart';

class SocialEvent {
  String? id;
  String? name;
  String? description;
  String? institutionId;
  SocialEventType? socialEventType;
  String? expiryDate;
  int? volunteerRequried;
  int? points;
  String? address;
  double? latitude;
  double? longitude;
  String? createdAt;
  String? imageUrl;

  SocialEvent(
      {this.id,
      this.name,
      this.description,
      this.institutionId,
      this.socialEventType,
      this.expiryDate,
      this.volunteerRequried,
      this.points,
      this.address,
      this.latitude,
      this.longitude,
      this.imageUrl,
      this.createdAt});

  SocialEvent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    institutionId = json['institutionId'];
    socialEventType = json['socialEventType'] != null
        ? SocialEventType.fromJson(json['socialEventType'])
        : null;
    expiryDate = json['expiryDate'];
    volunteerRequried = json['volunteerRequried'];
    points = json['points'];
    address = json['address'];
    latitude = double.parse(json['latitude'].toString());
    longitude = double.parse(json['longitude'].toString());
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['description'] = description;
    data['institutionId'] = institutionId;
    if (socialEventType != null) {
      data['socialEventType'] = socialEventType!.toJson();
    }
    data['expiryDate'] = expiryDate;
    data['volunteerRequried'] = volunteerRequried;
    data['points'] = points;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['createdAt'] = createdAt;
    return data;
  }
}
