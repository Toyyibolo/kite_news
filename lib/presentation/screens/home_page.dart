import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Ensure this import is correct
import 'package:kite_news/presentation/providers/categories_provider.dart';
import 'package:kite_news/presentation/providers/kite_news_provider.dart';


class KiteHomePage extends ConsumerWidget {
  const KiteHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(categoriesProvider);
    final AsyncValue<List<AsyncValue>> kiteNews = category.when(
      data: (data) => AsyncValue.data(data.map((category) => ref.watch(kiteNewsProvider(category)).whenData((kiteNews) => [kiteNews])).toList()),
      error: (error, stack) => AsyncValue.error(error, stack),
      loading: () => const AsyncValue.loading(),
    );
    
    debugPrint('Kite categories: $category');
    return Scaffold(
      
      body: category.when(
        data: (data) {
          return DefaultTabController(
            length:   category.value!.length ,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Kite News'),
                bottom: TabBar(
                  tabs: [
                    ...data.map((category) => Tab(text: category)),
                  ],
                ),
              ),
              body: TabBarView(
                children: data.map((category) {
                  return kiteNews.when(
                    data: (kiteNewsList) {
                      final kiteNewsbyCategory = kiteNewsList[data.indexOf(category)];
                      return kiteNewsbyCategory.when(
                        data: (articles) {
                          return ListView.builder(
                            itemCount: articles[0].clusters.length,
                            itemBuilder: (context, index) {
                              final article = articles[0].clusters[index];
                              return ListTile(
                                title: Text(article.title),
                                subtitle: Text(article.category),
                                onTap: () {
                                  // Handle article tap
                                },
                              );
                            },
                          );
                        },
                        error: (error, stack) => Center(child: SelectableText('Error: $error')),
                        loading: () => const Center(child: CircularProgressIndicator()),
                      );
                    },
                    error: (error, stack) => Center(child: Text('Error: $error + tabbarview')),
                    loading: () => const Center(child: CircularProgressIndicator()),
                  );
                }).toList(),
              ),
            ),
          );
        }, error: (Object error, StackTrace stackTrace) { 
          return Text(' $stackTrace');
         },
         loading: () {  
          return const Center(child: CircularProgressIndicator());
         }));
       

  }
  }


  

