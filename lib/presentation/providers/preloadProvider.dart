import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kite_news/presentation/providers/categories_provider.dart';
import 'package:kite_news/presentation/providers/enabledCategories.dart';
import 'package:kite_news/presentation/providers/kite_news_provider.dart';

final preloadProvider = FutureProvider<void>((ref) async {
  try {
    
    final enabledCategories = ref.read(enabledCategoriesProvider);
    final categories = await ref.read(categoriesProvider.future);

    
    await Future.wait(
      categories.map(
        (cat) => ref.read(kiteNewsProvider(cat).future),
      ),
    );
  } catch (error, stackTrace) {
    // Log or handle the error appropriately
    debugPrint('Error during preload: $error');
    debugPrintStack(stackTrace: stackTrace);
  }
});
