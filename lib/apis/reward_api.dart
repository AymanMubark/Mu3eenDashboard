import 'package:mu3een_dashboard/models/reward.dart';
import '../models/add_reward_request.dart';
import '../models/search_reward_request.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'api.dart';

class RewardApi extends Api {
  Future<List<Reward>> all({SearchRewardRequest? model, int page = 1}) async {
    model ??= SearchRewardRequest();
    var response = await http.get(
        Uri.parse("${Api.apiUrl}/Rewards")
            .replace(queryParameters: model.toJson()),
        headers: headers);
    var body = handelResponse(response);
    var result = jsonDecode(body);
    return (result as List)
        .map((e) => Reward.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future add({required AddRewardRequest model}) async {
    var request =
        http.MultipartRequest('POST', Uri.parse("${Api.apiUrl}/Rewards"));
    request.fields.addAll({
      'name': model.name ?? "",
      'description': model.content ?? "",
      'points': model.points.toString(),
      'numbers': model.numbers.toString(),
    });
    // headers.addAll({"Authorization": ApiService.userToken!});
    request.headers.addAll(headers);
    if (model.image != null) {
      List<int> list = model.image!.cast();
      request.files.add(http.MultipartFile.fromBytes('image', list,
          filename: 'image.jpg', contentType: MediaType('image', 'jpg')));
    }
    http.StreamedResponse response = await request.send();
    await handelStreamResponse(response);
  }

  Future delete(
    String id,
  ) async {
    var response = await http.delete(Uri.parse("${Api.apiUrl}/Rewards/$id"),
        headers: headers);
    handelResponse(response);
  }
}
