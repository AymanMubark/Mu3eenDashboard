import 'dart:io';

import 'package:mu3een_dashboard/models/admin_counts_report.dart';
import 'package:mu3een_dashboard/models/admin_response.dart';
import 'package:mu3een_dashboard/models/admin.dart';
import 'package:mu3een_dashboard/models/socail_events_report.dart';
import '../models/admin_update_request.dart';
import '../models/search_admin_request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api.dart';

class AdminApi extends Api {
  Future<List<Admin>> all({SearchAdminRequest? model, int page = 1}) async {
    model ??= SearchAdminRequest();
    var response = await http.get(
        Uri.parse("${Api.apiUrl}/Admins")
            .replace(queryParameters: model.toJson()),
        headers: headers);
    var body = handelResponse(response);
    var result = jsonDecode(body);
    return (result as List)
        .map((e) => Admin.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<AdminLoginResponse> login(
      {required String username, required String password}) async {
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

  Future<Admin> update(
      {required String id, required AdminUpdateRequest model}) async {
    var request =
        http.MultipartRequest('PUT', Uri.parse("${Api.apiUrl}/Admins/$id"));
    request.fields.addAll({
      'name': model.name ?? "",
      'email': model.email ?? "",
    });
    // headers.addAll({"Authorization": ApiService.userToken!});
    request.headers.addAll(headers);
    if (model.image != null) {
      List<int> list = model.image!.cast();
      request.files.add(
          http.MultipartFile.fromBytes('image', list, filename: 'myFile.png'));
    }
    http.StreamedResponse response = await request.send();
    var body = jsonDecode(await handelStreamResponse(response));
    return Admin.fromJson(body);
  }

  Future<Admin> add({required AdminUpdateRequest model}) async {
    var request =
        http.MultipartRequest('POST', Uri.parse("${Api.apiUrl}/Admins"));
    request.fields.addAll({
      'name': model.name ?? "",
      'email': model.email ?? "",
      'password': model.password ?? "",
      'userName': model.userName ?? "",
    });
    // headers.addAll({"Authorization": ApiService.userToken!});
    request.headers.addAll(headers);
    if (model.image != null) {
      List<int> list = model.image!.cast();
      request.files.add(
          http.MultipartFile.fromBytes('image', list, filename: 'myFile.png'));
    }
    http.StreamedResponse response = await request.send();
    var body = jsonDecode(await handelStreamResponse(response));
    return Admin.fromJson(body);
  }

  Future<AdminCountsReport> countsReport() async {
    var response = await http.get(
        Uri.parse("${Api.apiUrl}/Admins/AdminCountsReport"),
        headers: headers);
    var body = jsonDecode(handelResponse(response));
    return AdminCountsReport.fromJson(body);
  }

  Future<SocailEventsReport> socailEventsReport() async {
    var response = await http.get(
        Uri.parse("${Api.apiUrl}/Admins/SocailEventsReport"),
        headers: headers);
    var body = jsonDecode(handelResponse(response));
    return SocailEventsReport.fromJson(body);
  }
}
