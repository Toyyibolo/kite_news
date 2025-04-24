import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class CategoryNotifier extends StateNotifier<List<String>> {
  static const _boxName = 'enabledCategoriesBox';
  static const _key = 'categories';

  late final Box box;

  CategoryNotifier() : super(['sport']) {
    _init();
  }

  Future<void> _init() async {
    box = Hive.box(_boxName); 
    final saved = box.get(_key, defaultValue: ['world', 'business', 'science']);
    state = List<String>.from(saved);
  }

  void _persist() {
    box.put(_key, state);
  }

  void add(String category) {
    if (!state.contains(category)) {
      state = [...state, category];
      _persist();
    }
  }

  void remove(String category) {
    state = state.where((e) => e != category).toList();
    _persist();
  }

  void reorder(int oldIndex, int newIndex) {
    final items = [...state];
    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    state = items;
    _persist();
  }
}

final enabledCategoriesProvider =
    StateNotifierProvider<CategoryNotifier, List<String>>(
  (ref) => CategoryNotifier(),
);




class SelectedCategoryNotifier extends StateNotifier<String> {
  SelectedCategoryNotifier(Ref ref) : super('');

  void select(String category) {
    if (state == category) {
      state = '';
      Future.microtask(() => state = category);
    } else {
      state = category;
    }
  }
}

final SelectedCategoriesProvider = StateNotifierProvider<SelectedCategoryNotifier, String>((ref) {
  return SelectedCategoryNotifier(ref);
});



// final selectedProvider = StateProvider((ref){
//   return false;
// });