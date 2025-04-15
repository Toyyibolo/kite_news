import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kite_news/data/models/kite_category_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final response = await http.get(Uri.parse("https://kite.kagi.com/kite.json"));
  final data = jsonDecode(response.body);
  return (data['categories'] as List).map((e) => Category.fromJson(e)).toList();
});
