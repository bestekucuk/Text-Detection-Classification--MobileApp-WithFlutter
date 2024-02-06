import 'dart:convert';

import 'package:flutter_exam/utils/constants/api_constants.dart';
import 'package:flutter_exam/utils/models/api_models.dart';
import 'package:http/http.dart' as http;

class APIService {
  Future<List<TextModel>> getText() async {
    print("beste");
    final response = await http.get(Uri.parse(url));
    List<TextModel> text = [];
    List<dynamic> textList = jsonDecode(response.body);
    for (var i = 0; i < textList.length; i++) {
      text.add(TextModel.fromJson(textList[i]));
    }
    print("bitis");
    return text;
  }

  Future<http.Response> postText(TextModel model) async {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        model.toJson(),
      ),
    );
    return response;
  }

  String updateCategoryText(http.Response response) {
    // Assuming your response body is JSON
    Map<String, dynamic> responseBody = json.decode(response.body);

    // Assuming your category property is a string, update accordingly if it's different
    String category = responseBody['category'];

    // Update the Text widget
    return category;
  }
}
