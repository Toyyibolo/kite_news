import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:kite_news/data/models/kite_news_model.dart';
import 'package:kite_news/data/reposittories/kite_news_repository.dart';

class KiteNewsRepositoryImpl implements KiteNewsRepository {
  final Dio dio;
  final String categoryName;
  late final Box<KiteNews> kiteNewsBox;

  KiteNewsRepositoryImpl({
    required this.dio,
    required this.categoryName,
  }) {
    _initializeBox();
  }

  // Initialize the Hive box
  Future<void> _initializeBox() async {
    kiteNewsBox = await Hive.openBox<KiteNews>('kiteNewsBox');
  }

  @override
  Future<KiteNews> fetchKiteNews() async {
    final cacheKey = '$categoryName.json';
    final cachedData = kiteNewsBox.get(cacheKey);
    if (cachedData != null) return cachedData;

    final url = 'https://kite.kagi.com/$cacheKey';
    assert(Uri.tryParse(url)?.hasAbsolutePath ?? false);

    try {
      debugPrint('Fetching: $url');

      final response = await dio.get(
        url,
        options: Options(
          receiveTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
        ),
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final percent = (received / total * 100).toStringAsFixed(0);
            debugPrint('Downloading $cacheKey: $percent%');
          }
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final fetchedData = KiteNews.fromJson(response.data);
        await kiteNewsBox.put(cacheKey, fetchedData);
        return fetchedData;
      } else {
        throw Exception('Failed to load news. Status code: ${response.statusCode}');
      }

    } on DioException catch (e) {
      debugPrint('Dio Error Message: ${e.message}');
      debugPrint('Dio Error Type: ${e.type}');
      debugPrint('Dio Response: ${e.response}');
      debugPrint('Dio Stacktrace: ${e.stackTrace}');

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Connection timed out while fetching news.');
      } else if (e.type == DioExceptionType.unknown) {
        throw Exception('DNS lookup failed or no internet connection.');
      } else {
        throw Exception('Unexpected Dio error: ${e.message}');
      }

    } catch (e, stack) {
      debugPrint('General fetch error: $e');
      debugPrint('Stacktrace: $stack');
      throw Exception('Failed to fetch Kite News: $e');
    }
  }

  Future<void> clearCache() async {
    await kiteNewsBox.clear();
  }
}



