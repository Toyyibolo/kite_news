import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kite_news/data/models/kite_news_model.dart';
import 'package:kite_news/data/reposittories/kite_news_repository.dart';


class KiteNewsRepositoryImpl implements KiteNewsRepository {
  final http.Client client;
  final String categoryName;

  KiteNewsRepositoryImpl({required this.client, required this.categoryName});

  @override
  Future<KiteNews> fetchKiteNews() async {
    final response = await client.get(Uri.parse('https://kite.kagi.com/$categoryName'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return KiteNews.fromJson(jsonData);
    } else {
      throw Exception('Failed to load news');
    }
  }
}
