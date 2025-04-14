import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kite_news/presentation/providers/kite_news_provider.dart';


class KiteHomePage extends ConsumerWidget {


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kiteNews = ref.watch(kiteNewsProvider);

    return Scaffold(
        body: kiteNews.when(
            data: (data) => data.clusters.isNotEmpty
                ? ListView.builder(
                    itemCount: data.clusters.length,
                    itemBuilder: (context, index) {
                      final article = data.clusters[index];
                      return ListTile(
                        title: Text(article.title),
                        subtitle: Text(article.location),
                      );
                    },
                  )
                : Center(child: Text('No Data')),
            error: (error, stack) => Center(child: SelectableText('Error: $error , Stack: $stack')),
            loading: () => Center(child: Text('Loading...')),
        ),
    );
  }
}