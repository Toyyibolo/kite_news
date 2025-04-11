import 'package:http/http.dart' as http;
import 'package:kite_news/data/models/kite_news_model.dart';
import 'package:kite_news/domain/repositories/kite_news_repositories_impl.dart';
import 'package:riverpod/riverpod.dart';
import 'package:kite_news/domain/usecases/fetch_kite_news.dart';

// Step 1: Provide the HTTP client
final httpClientProvider = Provider<http.Client>((ref) => http.Client());

// Step 2: Provide the repository implementation
final kiteNewsRepositoryProvider = Provider<KiteNewsRepositoryImpl>((ref) {
  final client = ref.read(httpClientProvider);
  return KiteNewsRepositoryImpl(client: client);
});

// Step 3: Provide the use case
final fetchKiteNewsUseCaseProvider = Provider<FetchKiteNews>((ref) {
  final repository = ref.read(kiteNewsRepositoryProvider);
  return FetchKiteNews(repository);
});

// Step 4: Provide the async KiteNews state
final kiteNewsProvider = FutureProvider<KiteNews>((ref) async {
  final fetchKiteNews = ref.read(fetchKiteNewsUseCaseProvider);
  return fetchKiteNews();
});
