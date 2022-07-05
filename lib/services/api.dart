import 'dart:convert';

import 'package:http/http.dart' as http;

String token = "a96c349be0b18e2ec5d5a2d721d23fd5b2f6ff0b";

getDictionary(String word) async {
  String url = "https://owlbot.info/api/v4/dictionary/$word";
  var response = await http
      .get(Uri.parse(url), headers: {"Authorization": "Token $token"});
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    return data;
  }
  return null;
}
