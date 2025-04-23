import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kite_news/core/extensions/spacing_extensions.dart';
import 'package:kite_news/data/models/article_model.dart';
import 'package:kite_news/data/models/cluster_model.dart';
import 'package:kite_news/data/models/perspective_model.dart';
import 'package:hive/hive.dart';
import 'package:kite_news/presentation/widgets/video_player.dart';

class NewsDetailPage extends StatelessWidget {
  final Cluster cluster;
  NewsDetailPage({super.key, required this.cluster});

  //String videoUrl = "https://media-hosting.imagekit.io/56587fe5ee8b45f9/Red and White General News Breaking News Video.mp4?Expires=1839767960&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=KMP1gLMJprYImmnOX7rVg2enVpzsY8L75rgnSs~OPKLjwV5-kuO3oY1ARiwOnz5F4JJHCcl0EHMIlH4Op-xAjCFuVfjsUESI7f4bgyz6ocotRX2XaWneKfP6b8Xd5B43TmKs~dNgEkJZAeUlykiI3EZ3Qz8kL0TRRTdJPEHsNhlmiCPPtf8y9nEb2lNNYMInphIqDLWfqf0~xK4fipDUd6Yul6gewgNrg-6Nn6ER9NJ3xpsTmBvliA1m5soBr-Zu8HcI0sZxGsCUTOdjTgoz2udFtiWWKScdk-ID2AAUqHEec6yVKcU0No4gzUGKrgZo3gfE5enhfBqvfzZtjCXcvA__ ";

  void _saveToHistory(BuildContext context) async {
    final box = Hive.box<Cluster>('historyBox');
    await box.put(cluster.clusterNumber.toString(), cluster);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Saved to history')), 
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      //backgroundColor: const Color(0xff1e1e1e),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _saveToHistory(context),
        child: const Icon(Icons.bookmark_add_outlined),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 220,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(cluster.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white),),
              background: Image.network(
                cluster.articles.firstOrNull?.image ?? '',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: Colors.grey[800]),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    children: [
                      Chip(label: Text(cluster.category)),
                      Chip(label: Text(cluster.location)),
                      Chip(label: Text('${cluster.uniqueDomains} Sources')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(cluster.shortSummary, style: theme.textTheme.bodyLarge),
                  const SizedBox(height: 24),

                  Text("💡 Did You Know", style: theme.textTheme.titleMedium),
                  const SizedBox(height: 6),
                  Text(cluster.didYouKnow, style: theme.textTheme.bodyMedium),

                  const SizedBox(height: 24),
                  if (cluster.talkingPoints.isNotEmpty) ...[
                    Text("🧠 Talking Points", style: theme.textTheme.titleMedium),
                    const SizedBox(height: 6),
                    ...cluster.talkingPoints.map((point) => ListTile(
                          leading: const Icon(Icons.bubble_chart),
                          title: Text(point),
                        )),
                  ],

                  const SizedBox(height: 24),
                  if (cluster.quote.isNotEmpty) ...[
                    Text('🗣️ Quote of the Day', style: theme.textTheme.titleMedium),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text('“${cluster.quote}”', style: theme.textTheme.bodyLarge),
                    ),
                    Text('- ${cluster.quoteAuthor}', style: theme.textTheme.bodySmall),
                  ],

                  24.hb,
                  Text('🎥 Watch Video', style: theme.textTheme.titleMedium),
                  8.hb,
                  SizedBox(
                      child: VideoPlayerScreen()),
                  10.hb,
                  if (cluster.perspectives.isNotEmpty) ...[
                    Text('🧭 Perspectives', style: theme.textTheme.titleMedium),
                   8.hb,
                    ...cluster.perspectives.map((p) => PerspectiveTile(perspective: p)),
                  ],

                  const SizedBox(height: 24),
                  if (cluster.articles.isNotEmpty) ...[
                    Text('📰 Articles', style: theme.textTheme.titleMedium),
                    const SizedBox(height: 8),
                    ...cluster.articles.map((article) => ArticleTile(article: article)),
                  ],

                  40.hb,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PerspectiveTile extends StatelessWidget {
  final Perspective perspective;
  const PerspectiveTile({super.key, required this.perspective});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(perspective.text, style: Theme.of(context).textTheme.bodyLarge),
            8.hb,
            Wrap(
              spacing: 8,
              children: perspective.sources
                  .map((s) => Chip(label: Text(s.name, style: const TextStyle(fontSize: 12))))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}

class ArticleTile extends StatelessWidget {
  final Article article;
  const ArticleTile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (article.image.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(article.image, height: 160, width: double.infinity, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(height: 160, color: Colors.grey[200])),
                ),
              const SizedBox(height: 8),
              Text(article.title, style: Theme.of(context).textTheme.titleSmall),
              Text(article.domain, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
              Text(DateFormat.yMMMd().format(article.date), style: Theme.of(context).textTheme.bodySmall),
              if (article.imageCaption.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(article.imageCaption, style: Theme.of(context).textTheme.bodySmall),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

// class VideoCard extends StatelessWidget {
//   final String videoUrl;
//   const VideoCard({super.key, required this.videoUrl});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: VideoPlayerScreen(url: videoUrl)
//       ),
//     );
//   }
// }