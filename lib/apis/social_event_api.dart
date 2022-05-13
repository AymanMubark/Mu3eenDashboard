import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/search_social_event_request.dart';
import '../models/social_event.dart';
import 'api.dart';

class SocialEventApi extends Api {
  Future<List<SocialEvent>> all(
      {SearchSocialEventRequest? model, int page = 1}) async {
    model ??= SearchSocialEventRequest();
    var response = await http.get(
        Uri.parse("${Api.apiUrl}/SocialEvents")
            .replace(queryParameters: model.toJson()),
        headers: headers);
    var body = handelResponse(response);
    var result = jsonDecode(body);
    return (result as List)
        .map((e) => SocialEvent.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
