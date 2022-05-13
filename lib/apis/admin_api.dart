import 'package:mu3een_dashboard/models/admin_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api.dart';

class AdminApi extends Api {
  Future<AdminLoginResponse> login(
      {required String username, required String password}) async {
    print(
      {
        "username": username,
        "password": password,
      },
    );
    var response = await http.post(Uri.parse("${Api.apiUrl}/Admins/Login"),
        body: jsonEncode(
          {
            "username": username,
            "password": password,
          },
        ),
        headers: headers);
    var body = jsonDecode(handelResponse(response));
    return AdminLoginResponse.fromJson(body);
  }
}
