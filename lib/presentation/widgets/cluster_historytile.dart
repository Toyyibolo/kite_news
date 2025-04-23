import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kite_news/data/models/cluster_model.dart';
import 'package:kite_news/data/models/kite_news_model.dart';
import 'package:kite_news/presentation/widgets/translatorText.dart';

class ClusterHistoryTile extends StatelessWidget {
  final Cluster cluster;
  final VoidCallback onTap;

  const ClusterHistoryTile({
    super.key,
    required this.cluster,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryArticle =
        cluster.articles.isNotEmpty ? cluster.articles.first : null;
    final imageUrl = primaryArticle?.image;
    final sourceName = cluster.location ?? "Unknown location";

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Card(
        color: theme.cardColor, // Theme color for card background
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                //Thumbnail
                if (imageUrl != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: theme.colorScheme.secondary.withOpacity(0.3),
                          ),
                          child: const Icon(Icons.image, color: Colors.grey),
                        );
                      },
                    ),
                  )
                else
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: theme.colorScheme.secondary.withOpacity(0.3),
                    ),
                    child: Icon(Icons.image, color: theme.iconTheme.color),
                  ),
        
                const SizedBox(width: 14),
        
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Headline
                      TranslatableText(
                        cluster.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.textTheme.bodyMedium?.color, // Adjusts based on theme
                          fontWeight: FontWeight.bold,
                        ),
                      ),
        
                      const SizedBox(height: 6),
        
                      // Source and Date
                      Row(
                        children: [
                          Icon(Icons.public, color: theme.iconTheme.color, size: 16),
                          const SizedBox(width: 4),
                          TranslatableText(
                            sourceName.length > 25 ? '${sourceName.substring(0, 25)}...' : sourceName,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
        
                      const SizedBox(height: 6),
        
                      // Stats (Articles / Perspectives)
                      Row(
                        children: [
                          Icon(
                            Icons.article_outlined,
                            color: theme.primaryColor,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          TranslatableText(
                            '${cluster.articles.length} articles',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.primaryColor,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.bubble_chart,
                            color: theme.secondaryHeaderColor,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          TranslatableText(
                            '${cluster.perspectives.length} perspectives',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.secondaryHeaderColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
