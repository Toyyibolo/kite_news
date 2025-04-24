import 'dart:io';

import 'package:dio/io.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:kite_news/data/models/kite_category_model.dart';
import 'package:dio/dio.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  // Optional: Accept self-signed certs (DEV ONLY)
  // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
  //   client.badCertificateCallback = (cert, host, port) => true;
  //   return client;
  // };

  return dio;
});

final categoryBoxProvider = Provider<Box<Category>>((ref) {
  return Hive.box<Category>('categoryBox');
});

final categoriesProvider = FutureProvider<List<String>>((ref) async {
  final box = ref.read(categoryBoxProvider);
  final cachedCategories = box.values.toList();

  if (cachedCategories.isNotEmpty) {
    return cachedCategories
        .map((category) => category.file.replaceAll('.json', '').replaceAll(' ', ''))
        .toList();
  }

 final dio = createUnsafeDio();

  try {
    final response = await dio.get("https://kite.kagi.com/kite.json");

    if (response.statusCode == 200 && response.data != null) {
      final data = response.data;
      final categoryObject = (data['categories'] as List)
          .map((e) => Category.fromJson(e))
          .toList();

      for (final category in categoryObject) {
        await box.put(category.name, category);
      }

      return categoryObject
          .map((category) => category.file.replaceAll('.json', '').replaceAll(' ', ''))
          .toList();
    } else {
      throw Exception("Failed to load categories. Status: ${response.statusCode}");
    }
  } on DioException catch (e) {
    throw Exception("Network error: ${e.message}");
  } catch (e) {
    throw Exception("Unexpected error: $e");
  }
});


Dio createUnsafeDio() {
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  // Bypass SSL verification (ONLY for development)
  (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
    final client = HttpClient();
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  };

  return dio;
}