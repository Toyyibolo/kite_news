import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:kite_news/data/models/kite_news_model.dart';
import 'package:kite_news/domain/repositories/kite_news_repositories_impl.dart';
import 'package:kite_news/domain/usecases/fetch_kite_news.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Step 1: Provide the HTTP client
final dioProvider = Provider<Dio>((ref) => Dio());

// Step 2: Provide the repository implementation
final kiteNewsRepositoryProvider = FutureProvider.family<KiteNewsRepositoryImpl, String>((ref, categoryName) async {
  final dio = ref.read(dioProvider);
  return KiteNewsRepositoryImpl(dio: dio, categoryName: categoryName);
});

// Step 3: Provide the use case (now async)
final fetchKiteNewsUseCaseProvider = FutureProvider.family<FetchKiteNews, String>((ref, categoryName) async {
  final repository = await ref.watch(kiteNewsRepositoryProvider(categoryName).future);
  return FetchKiteNews(repository);
});

// Step 4: Provide the async KiteNews state
final kiteNewsProvider = FutureProvider.family<KiteNews, String>((ref, categoryName) async {
  final fetchKiteNews = await ref.watch(fetchKiteNewsUseCaseProvider(categoryName).future);
  return fetchKiteNews();
});
