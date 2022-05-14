import 'package:mu3een_dashboard/models/search_volunteer_request.dart';
import 'package:mu3een_dashboard/models/volunteer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api.dart';

class VolunteerApi extends Api {
  Future<List<Volunteer>> all(
      {SearchVolunteerRequest? model, int page = 1}) async {
    model ??= SearchVolunteerRequest();
    var response = await http.get(
        Uri.parse("${Api.apiUrl}/Volunteers")
            .replace(queryParameters: model.toJson()),
        headers: headers);
    var body = handelResponse(response);
    var result = jsonDecode(body);
    return (result as List)
        .map((e) => Volunteer.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
