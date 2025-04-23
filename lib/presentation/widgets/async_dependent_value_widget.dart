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

class KiteNewsListWidget extends ConsumerWidget {
  KiteNewsListWidget({

    super.key,
    this.loading,
    this.error,
  });
  // final BuildContext? parentContext;
  final Widget? loading;
  final Widget? error;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(SelectedCategoriesProvider);
   // final enabledCat = ref.watch(enabledCategoriesProvider);
    //List<String> categories = enabledCat.map((e) => e+('.json')).toList();
    final AsyncValue<KiteNews> kiteNews = ref.watch(kiteNewsProvider(selectedCategory));
    //final AsyncValue<List<AsyncValue>> kiteNews = ref.watch(kiteNewsProvider('category'));
    return Column(
      children: [
        kiteNews.when(
          data: (KiteNewsdata) {
                          final clusters = KiteNewsdata.clusters;
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: clusters.length,
                            itemBuilder: (context, index) {
                              final clusterr = clusters[index];
                              return Builder(
                                builder: (context) {
                                  return ClusterListTile(
                                   cluster: clusterr,
                                    onTap: (){
                                      //print('Tapped on cluster: ${cluster.title}');
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => NewsDetailPage(cluster: clusterr)));
                                    }
                                    );
                                }
                              );
                            },
                          );
                        },
                        loading: () => loading ?? SizedBox(),
                        error: (e, st) => error ??
                            SnackBar(content: TranslatableText('Error: $e')),
                      ),
      ],
    );
                }
               
  }

