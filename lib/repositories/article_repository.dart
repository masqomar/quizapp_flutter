import 'package:frontend/configs/app_helper.dart';
import 'package:frontend/configs/app_service.dart';
import 'package:frontend/models/article_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ArticleRepository {
  Future<List<ArticleModel>> getArticle(int page) async {
    try {
      final url = Uri.parse('${urlApi}artikel/get-data?page=$page');
      final token = await getToken();

      final response = await http.get(
        url,
        headers: {
          "Content-type": "application/json",
          'Authorization': 'Bearer $token'
        },
      );

      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        var objects = data['data']['data'] as List;

        var dataAticle = objects.map((e) => ArticleModel.fromJson(e)).toList();

        return dataAticle;
      } else {
        throw (data['message']);
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
