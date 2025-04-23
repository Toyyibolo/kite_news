import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:kite_news/data/models/kite_category_model.dart'; // Ensure correct import
import 'dart:convert';
import 'package:http/http.dart' as http;

final categoryBoxProvider = Provider<Box<Category>>((ref) {
  // Provide access to the Category box in Hive
  return Hive.box<Category>('categoryBox');
});

final categoriesProvider = FutureProvider<List<String>>((ref) async {
  final box = ref.read(categoryBoxProvider);
  final cachedCategories = box.values.toList();

  // If categories are cached, return them
  if (cachedCategories.isNotEmpty) {
    return cachedCategories.map((category) => category.file).toList();
  } else {
    // If no categories are cached, fetch from the API
    final response = await http.get(Uri.parse("https://kite.kagi.com/kite.json"));
    final data = jsonDecode(response.body);
    List<Category> categoryObject = (data['categories'] as List)
        .map((e) => Category.fromJson(e))
        .toList();

    // Cache the categories in Hive
    for (var category in categoryObject) {
      await box.put(category.name, category);
    }

    return categoryObject.map((category) => category.file.replaceAll('.json', '')..replaceAll(' ', '')).toList();
  }
});
