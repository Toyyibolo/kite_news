import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kite_news/data/models/article_model.dart';
import 'package:kite_news/data/models/cluster_model.dart';
import 'package:kite_news/data/models/kite_news_model.dart';
import 'package:kite_news/data/models/perspective_model.dart';
import 'package:kite_news/presentation/widgets/cluster_historytile.dart';
import 'package:kite_news/presentation/widgets/translatorText.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium?.color ?? Colors.black;

    return FutureBuilder(
      future: _initHive(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        final historyBox = Hive.box<Cluster>('historyBox');

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: theme.appBarTheme.backgroundColor ?? theme.scaffoldBackgroundColor,
            title: TranslatableText(
              'History',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            iconTheme: IconThemeData(color: theme.colorScheme.onBackground),
            elevation: 2,
          ),
          body: ValueListenableBuilder(
            valueListenable: historyBox.listenable(),
            builder: (context, Box<Cluster> box, _) {
              if (box.isEmpty) {
                return Center(
                  child: TranslatableText(
                    'No history yet',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onBackground.withOpacity(0.6),
                    ),
                  ),
                );
              }

              final items = box.values.toList().reversed.toList();

              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 16),
                itemCount: 1, // Only one column
                itemBuilder: (context, index) {
                  return Column(
                    children: List.generate(items.length, (i) {
                      return ClusterHistoryTile(
                        cluster: items[i],
                        onTap: () {
                          // Navigate to detail page if needed
                        },
                      );
                    }),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _initHive() async {
    if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(KiteNewsAdapter());
    if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(ClusterAdapter());
    if (!Hive.isAdapterRegistered(2)) Hive.registerAdapter(ArticleAdapter());
    if (!Hive.isAdapterRegistered(3)) Hive.registerAdapter(PerspectiveAdapter());

    if (!Hive.isBoxOpen('historyBox')) {
      await Hive.openBox<Cluster>('historyBox');
    }
  }
}
