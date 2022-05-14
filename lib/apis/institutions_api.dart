import '../models/search_institutions_request.dart';
import 'package:http/http.dart' as http;
import '../models/institution.dart';
import 'dart:convert';
import 'api.dart';

class InstitutionApi extends Api {
  Future<List<Institution>> all(
      {SearchInstitutionRequest? model, int page = 1}) async {
    model ??= SearchInstitutionRequest();
    var response = await http.get(
        Uri.parse("${Api.apiUrl}/Institutions")
            .replace(queryParameters: model.toJson()),
        headers: headers);
    var body = handelResponse(response);
    var result = jsonDecode(body);
    return (result as List)
        .map((e) => Institution.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
