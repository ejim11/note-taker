import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notetaker/data/categories.dart';

class CategoryNotifier extends StateNotifier<List<String>> {
  // setting the initial state data
  CategoryNotifier() : super(categories);

  void addCategory(String category) async {
    if (state.contains(category)) return;
    state = [...state, category];
  }
}

final categoryProvider = StateNotifierProvider<CategoryNotifier, List<String>>(
    (ref) => CategoryNotifier());
