import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:kite_news/data/models/cluster_model.dart';
import 'package:kite_news/data/models/kite_news_model.dart';
import 'package:kite_news/presentation/providers/enabledCategories.dart';
import 'package:kite_news/presentation/providers/kite_news_provider.dart';
import 'package:kite_news/presentation/screens/newsPage.dart';
import 'package:kite_news/presentation/widgets/cluster_listtile.dart';
import 'package:kite_news/presentation/widgets/translatorText.dart';

class Summarytext extends StatelessWidget {
    Summarytext({
    
    super.key,
    required this.ref,
    required this.category,
    this.loading,
    this.error,
  });
  // final BuildContext? parentContext;
  final String category;
  final WidgetRef ref;
  final Widget? loading;
  final Widget? error;

  @override
  Widget build(BuildContext context) {
   // final enabledCat = ref.watch(enabledCategoriesProvider);
    //List<String> categories = enabledCat.map((e) => e+('.json')).toList();
    final AsyncValue<KiteNews> kiteNews = ref.watch(kiteNewsProvider(category));
    //final AsyncValue<List<AsyncValue>> kiteNews = ref.watch(kiteNewsProvider('category'));
    return kiteNews.when(
          data: (KiteNewsdata) {
                          final clusters = KiteNewsdata.clusters;
                          return TranslatableText(clusters.mapIndexed((index, cluster) => '${cluster.title}').join('. '));
                        },
                        loading: () => loading ?? SizedBox(),
                        error: (e, st) => error ??
                           TranslatableText(''),
                      );
      
                }
               
  }

