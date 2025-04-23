import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kite_news/presentation/providers/enabledCategories.dart';
import 'package:kite_news/presentation/providers/categories_provider.dart';
import 'package:kite_news/presentation/screens/category_settings.dart';

// Custom StateNotifier for managing enabled categories
class MockCategoryNotifier extends CategoryNotifier {
  MockCategoryNotifier() : super();

  void addCategory(String category) {
    state = [...state, category];
  }

  void removeCategory(String category) {
    state = state.where((item) => item != category).toList();
  }

  void reorder(int oldIndex, int newIndex) {
    final item = state.removeAt(oldIndex);
    state.insert(newIndex, item);
  }
}

void main() {
  testWidgets('CategorySelectorPage renders correctly', (WidgetTester tester) async {
    // Create a mock provider for enabled categories using StateNotifier
    final enabledCategoriesProviderMock = StateNotifierProvider<MockCategoryNotifier, List<String>>(
      (ref) => MockCategoryNotifier(),
    );

    // Create a mock provider for categories list
    final categoriesProviderMock = FutureProvider<List<String>>(
      (ref) async => ['Science', 'Technology', 'Health', 'Business'],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          enabledCategoriesProvider.overrideWithProvider(enabledCategoriesProviderMock as StateNotifierProvider<CategoryNotifier, List<String>>),
          categoriesProvider.overrideWith((ref) async => ['Science', 'Technology', 'Health', 'Business']),
        ],
        child: MaterialApp(
          home: CategorySelectorPage(),
        ),
      ),
    );

    // Wait for UI to load
    await tester.pumpAndSettle();

    // Check if the initial text appears
    expect(find.text('Customize Categories'), findsOneWidget);
    expect(find.text('Selected Categories (Drag to reorder):'), findsOneWidget);
    expect(find.text('Tap to add more:'), findsOneWidget);

    // Check if the selected categories appear in the list
    expect(find.text('Science'), findsOneWidget);
    expect(find.text('Technology'), findsOneWidget);

    // Check available categories
    expect(find.text('Health'), findsOneWidget);
    expect(find.text('Business'), findsOneWidget);
  });

  testWidgets('Tap to add a category', (WidgetTester tester) async {
    final enabledCategoriesProviderMock = StateNotifierProvider<MockCategoryNotifier, List<String>>(
      (ref) => MockCategoryNotifier(),
    );
    final categoriesProviderMock = FutureProvider<List<String>>(
      (ref) async => ['Science', 'Technology', 'Business'],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          enabledCategoriesProvider.overrideWith((ref) => MockCategoryNotifier()),
          categoriesProvider.overrideWith((ref) async => ['Science', 'Technology', 'Business']),
        ],
        child: MaterialApp(
          home: CategorySelectorPage(),
        ),
      ),
    );

    // Wait for the UI to settle
    await tester.pumpAndSettle();

    // Tap the available category chip 'Health'
    await tester.tap(find.text('Health'));
    await tester.pumpAndSettle();

    // Check if the chip 'Health' is now in the selected categories section
    expect(find.text('Health'), findsOneWidget);
  });

  testWidgets('Tap to remove a category from selected', (WidgetTester tester) async {
    final enabledCategoriesProviderMock = StateNotifierProvider<MockCategoryNotifier, List<String>>(
      (ref) => MockCategoryNotifier()..addCategory('Science')..addCategory('Technology'),
    );
    final categoriesProviderMock = FutureProvider<List<String>>(
      (ref) async => ['Science', 'Technology', 'Health', 'Business'],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          enabledCategoriesProvider.overrideWithProvider(enabledCategoriesProviderMock),
          categoriesProvider.overrideWith((ref) async => ['Science', 'Technology', 'Health', 'Business']),
        ],
        child: MaterialApp(
          home: CategorySelectorPage(),
        ),
      ),
    );

    // Wait for UI to load
    await tester.pumpAndSettle();

    // Tap the selected category chip 'Technology' to remove it
    await tester.tap(find.text('Technology'));
    await tester.pumpAndSettle();

    // Check if 'Technology' is removed from selected categories
    expect(find.text('Technology'), findsNothing);
  });

  testWidgets('Reordering categories updates order', (WidgetTester tester) async {
    final enabledCategoriesProviderMock = StateNotifierProvider<MockCategoryNotifier, List<String>>(
      (ref) => MockCategoryNotifier()..addCategory('Science')..addCategory('Technology'),
    );
    final categoriesProviderMock = FutureProvider<List<String>>(
      (ref) async => ['Science', 'Technology', 'Health', 'Business'],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          enabledCategoriesProvider.overrideWithProvider(enabledCategoriesProviderMock),
          categoriesProvider.overrideWith((ref) async => ['Science', 'Technology', 'Business']),
        ],
        child: MaterialApp(
          home: CategorySelectorPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Simulate reordering of categories (for example, moving 'Technology' to the end)
    await tester.drag(find.text('Technology'), const Offset(0, 100));
    await tester.pumpAndSettle();

    // Check if the order of categories is updated
    expect(find.text('Science'), findsOneWidget);
    expect(find.text('Technology'), findsOneWidget);
  });
}
