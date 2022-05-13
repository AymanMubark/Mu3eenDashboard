import 'admin.dart';

class AdminLoginResponse {
  Admin? user;
  String? token;
  String? role;

  AdminLoginResponse({this.user, this.token, this.role});

  AdminLoginResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? Admin.fromJson(json['user']) : null;
    token = json['token'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    data['role'] = role;
    return data;
  }
}
