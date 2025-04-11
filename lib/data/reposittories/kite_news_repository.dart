import 'package:kite_news/data/models/kite_news_model.dart';

abstract class KiteNewsRepository {
  Future<KiteNews> fetchKiteNews();
}
