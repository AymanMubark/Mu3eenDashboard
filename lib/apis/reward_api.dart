import 'package:mu3een_dashboard/models/reward.dart';
import '../models/search_reward_request.dart';
import 'package:http/http.dart' as http;
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
}
