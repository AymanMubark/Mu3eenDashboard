import '../models/social_event_type.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api.dart';

class SocialEventTypeApi extends Api {
  Future<List<SocialEventType>> all({int page = 1}) async {
    var response = await http.get(Uri.parse("${Api.apiUrl}/SocialEventTypes"),
        headers: headers);
    var body = handelResponse(response);
    var result = jsonDecode(body);
    return (result as List)
        .map((e) => SocialEventType.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
