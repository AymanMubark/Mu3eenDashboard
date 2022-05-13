class SearchSocialEventRequest {
  String? key;
  String? address;
  String? socialEventTypeId;

  SearchSocialEventRequest({this.key, this.address, this.socialEventTypeId});

  SearchSocialEventRequest.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    address = json['address'];
    socialEventTypeId = json['socialEventTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['address'] = address;
    data['socialEventTypeId'] = socialEventTypeId;
    return data;
  }
}
