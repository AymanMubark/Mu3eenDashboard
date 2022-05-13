import 'dart:convert';
import 'package:http/http.dart';
import '../models/fetch_error.dart';

class Api {
  static String baseUrl = "https://ayman.nittaq.com";
  static String apiUrl = "$baseUrl/api";
  static String? userToken;

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  String handelResponse(Response response) {
    print(response.statusCode.toString() +
        " " +
        response.request!.url.toString());
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      if (response.body.isNotEmpty) {
        if (response.body.contains("message")) {
          throw FetchError.fromJson(jsonDecode(response.body));
        }
      }
      throw FetchError(message: response.reasonPhrase ?? "error");
    }
  }
}

Future<String> handelStreamResponse(StreamedResponse response) async {
  String body = await response.stream.bytesToString();
  print(
      response.statusCode.toString() + " " + response.request!.url.toString());
  print(body);
  if (response.statusCode == 200 || response.statusCode == 201) {
    return body;
  } else {
    if (body.isNotEmpty) {
      if (body.contains("message")) {
        throw FetchError.fromJson(jsonDecode(body));
      }
    }
    throw FetchError(message: response.reasonPhrase ?? "error");
  }
}
