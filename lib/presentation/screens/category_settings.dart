import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kite_news/core/extensions/captalization_extension.dart';
import 'package:kite_news/presentation/providers/categories_provider.dart';
import 'package:kite_news/presentation/providers/enabledCategories.dart';
import 'package:kite_news/presentation/widgets/translatorText.dart';
import 'package:reorderables/reorderables.dart';

class CategorySelectorPage extends ConsumerStatefulWidget {
  const CategorySelectorPage({super.key});

  @override 
  ConsumerState<CategorySelectorPage> createState() => _CategorySelectorPageState();
}

class _CategorySelectorPageState extends ConsumerState<CategorySelectorPage> {
  List<String> enabledCategories = [];
  List<String> allCategories = [];
  List<String> availableCategories = [];

  @override
  void initState() {
    super.initState();
    final allCategoriesList = ref.read(categoriesProvider);
    allCategories = allCategoriesList.when(
      data: (data) => data.map((e) => e.replaceAll('.json', '')).toList(),
      error: (error, stackTrace) => [],
      loading: () => []); 
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    enabledCategories = ref.watch(enabledCategoriesProvider);
    availableCategories = allCategories.where((e) => !enabledCategories.contains(e)).toList();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const TranslatableText('Customize Categories'),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TranslatableText(
              "Selected Categories (Drag to reorder):",
              style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ReorderableWrap(
              spacing: 8,
              runSpacing: 8,
              needsLongPressDraggable: false,
              onReorder: (oldIndex, newIndex) {
                ref.read(enabledCategoriesProvider.notifier).reorder(oldIndex, newIndex);
              },
              children: enabledCategories
                  .map((e) => _buildChip(context, e.capitalize(), enabled: true))
                  .toList(),
            ),
            const SizedBox(height: 30),
            TranslatableText(
              "Tap to add more:",
              style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: availableCategories
                  .map((e) => _buildChip(context, e.capitalize(), enabled: false))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(BuildContext context, String label, {required bool enabled}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        setState(() {
          if (enabled) {
            ref.read(enabledCategoriesProvider.notifier).remove(label);
          } else {
            ref.read(enabledCategoriesProvider.notifier).add(label);
          }
        });
      },
      child: Chip(
        label: TranslatableText(label),
        backgroundColor: enabled
            ? theme.colorScheme.primary
            : isDark
                ? Colors.grey.shade700
                : Colors.grey.shade300,
        labelStyle: TextStyle(
          color: enabled
              ? Colors.white
              : isDark
                  ? Colors.white
                  : Colors.black,
          fontWeight: FontWeight.w500,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
    );
  }
}
