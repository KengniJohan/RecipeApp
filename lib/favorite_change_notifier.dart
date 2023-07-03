import 'package:flutter/foundation.dart';
import 'package:recipe_app/recipe.dart';
import 'package:recipe_app/recipe_box.dart';

class FavoriteChangeNotifier with ChangeNotifier {
  FavoriteChangeNotifier(this.recipe);

  Recipe recipe;

  bool get isFavorited => recipe.isFavorited;
  int get favoriteCount => recipe.favoriteCount + (recipe.isFavorited? 1 : 0);  

  set isFavorited(bool isFavorited) {
    recipe.isFavorited = isFavorited;
    RecipeBox.box?.put(recipe.key(), recipe);
    // RecipeDatabase.instance.updateRecipe(recipe);
    notifyListeners();
  }
}