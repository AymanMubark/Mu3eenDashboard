import 'dart:io';

import 'dart:typed_data';

class AdminUpdateRequest {
  String? name;
  String? userName;
  String? email;
  String? password;
  Uint8List? image;

  AdminUpdateRequest({this.name});

  AdminUpdateRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userName = json['userName'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['password'] = password;
    data['userName'] = userName;
    data['email'] = email;
    return data;
  }
}
