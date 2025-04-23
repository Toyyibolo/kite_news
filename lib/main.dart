import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kite_news/data/models/cluster_model.dart';
import 'package:kite_news/data/models/domain_model.dart';
import 'package:kite_news/data/models/kite_category_model.dart';
import 'package:kite_news/data/models/kite_news_model.dart';
import 'package:kite_news/data/models/article_model.dart'; 
import 'package:kite_news/data/models/perspective_model.dart';
import 'package:kite_news/data/models/source_model.dart';
import 'package:kite_news/presentation/providers/themeProvider.dart';
import 'package:kite_news/presentation/screens/splashRedirector.dart';
import 'package:kite_news/presentation/widgets/themes/darkTheme.dart';
import 'package:kite_news/presentation/widgets/themes/lightTheme.dart';
import 'package:kite_news/storage/category_model_adapter.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(KiteNewsAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(ClusterAdapter());
  Hive.registerAdapter(DomainAdapter());
  Hive.registerAdapter(ArticleAdapter());
  Hive.registerAdapter(PerspectiveAdapter());
  Hive.registerAdapter(SourceAdapter());

  await Hive.openBox<Category>('categoryBox'); 
  await Hive.openBox<KiteNews>('kiteNewsBox');
  await Hive.openBox('settingsBox');
  await Hive.openBox('enabledCategoriesBox');
  await Hive.openBox<Cluster>('historyBox');
  
  runApp( ProviderScope(child: KiteNewsApp()));
  }

class KiteNewsApp extends ConsumerStatefulWidget {
  const KiteNewsApp({super.key});

  @override
  ConsumerState<KiteNewsApp> createState() => _KiteNewsAppState();
}

class _KiteNewsAppState extends ConsumerState<KiteNewsApp> {
  @override
  void initState() {
    super.initState();

    //Automatically clear Hive data when internet is detected
    Connectivity().onConnectivityChanged.listen((results) {
      if (results.isNotEmpty && results.any((result) => result != ConnectivityResult.none)) {
        Hive.box<KiteNews>('kiteNewsBox').clear();
        Hive.box<Category>('categoryBox').clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeDataProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? kiteNewsDarkTheme : kiteNewsLightTheme,
      home: SplashRedirector()
    );
  }
}
