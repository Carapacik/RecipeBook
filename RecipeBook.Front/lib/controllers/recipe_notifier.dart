import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:recipebook/models/recipe_item.dart';

class RecipeNotifier extends ChangeNotifier {
  List<RecipeItem> _recipeList = [];

  UnmodifiableListView<RecipeItem> get recipeList => UnmodifiableListView(_recipeList);

  addInitialRecipes(List<dynamic> data) {
    _recipeList.clear();
    for (final item in data) {
      _recipeList.add(RecipeItem.fromJson(item as Map<String, dynamic>));
    }
    notifyListeners();
  }

  addRecipes(List<dynamic> data) {
    for (final item in data) {
      _recipeList.add(RecipeItem.fromJson(item as Map<String, dynamic>));
    }
    notifyListeners();
  }

  removeItem(int recipeId) {
    _recipeList.removeWhere((item) => item.recipeId == recipeId);
    notifyListeners();
  }
}