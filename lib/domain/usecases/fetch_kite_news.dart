import 'package:kite_news/data/models/kite_news_model.dart';
import 'package:kite_news/data/reposittories/kite_news_repository.dart';

class FetchKiteNews {
  final KiteNewsRepository repository;

  FetchKiteNews(this.repository);

  Future<KiteNews> call() {
    return repository.fetchKiteNews();
  }
}
