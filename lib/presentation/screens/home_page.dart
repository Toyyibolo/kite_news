import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kite_news/data/models/kite_news_model.dart';
import 'package:kite_news/presentation/providers/categories_provider.dart';
import 'package:kite_news/presentation/providers/kite_news_provider.dart';


class KiteHomePage extends ConsumerWidget {


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kiteNews = ref.watch(kiteNewsProvider);
    final category = ref.watch(categoriesProvider);
    debugPrint('Kite categories: $category');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kite News'),
      ),
      body: category.when(
        data: (data) {
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Kite News'),
                bottom: const TabBar(
                  tabs: [
                    Tab(text: 'Top Stories'),
                    Tab(text: 'Business'),
                    Tab(text: 'Technology'),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  Center(child: Text('Top Stories')),
                  Center(child: Text('Business')),
                  Center(child: Text('Technology')),



                  // _buildNewsList(data.topStories),
                  // _buildNewsList(data.business),
                  // _buildNewsList(data.technology),
                ],
              ),
            ),
          );
        },
        error: (error, stack) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
    


  }
  }

//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Kite News'),
//           bottom: const TabBar(
//             tabs: [
//               Tab(text: 'Top Stories'),
//               Tab(text: 'Business'),
//               Tab(text: 'Technology'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             // _buildNewsList(kiteNews.topStories),
//             // _buildNewsList(kiteNews.business),
//             // _buildNewsList(kiteNews.technology),
//           ],
//         ),
//       ),
//     );    
//   }
// }
  
  
    // Widget _buildNewsList(List<Cluster> clusters) {
    //   if (clusters.isEmpty) {
    //     return const Center(child: CircularProgressIndicator());
    //   }
  
    //   return ListView.builder(
    //     itemCount: clusters.length,
    //     itemBuilder: (context, index) {
    //       final article = clusters[index].articles;
    //       return ListTile(
    //         title: Text(article.title),
    //         subtitle: Text(article.description),
    //         onTap: () {
    //           // Handle article tap
    //         },
    //       );
    //     },
    //   );
    // }
  

