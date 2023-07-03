import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe_app/recipe.dart';

class RecipeBox {
  static final RecipeBox instance = RecipeBox();
  static Box? box;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    print("#############################execution#################################");
    Hive.registerAdapter(RecipeAdapter());
    box = await Hive.openBox("recipeBox");
    var values = box?.values;
    if (values == null || values.isEmpty) {
      RecipeBox.box?.putAll(
          { for (var e in recipes) e.key() : e });
    }
  }

  static final List<Recipe> recipes = [
    Recipe(
        "pizza facile 1",
        "Par Johan Kengni",
        "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGl6emF8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60",
        "lkddddsssssssssssssssssjjjjjjjjjjjjjjjjjjjjjjjjeeeeeeeeeeeeeeeeeeekkkkkkkkk\n\n dddddddddddddddddddddddddkddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
        false,
        50),
    Recipe(
        "pizza facile 2",
        "Par Johan Kengni",
        "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGl6emF8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60",
        "lkddddsssssssssssssssssjjjjjjjjjjjjjjjjjjjjjjjjeeeeeeeeeeeeeeeeeeekkkkkkkkk\n\n dddddddddddddddddddddddddkddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
        false,
        50),
    Recipe(
        "pizza facile 3",
        "Par Johan Kengni",
        "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGl6emF8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60",
        "lkddddsssssssssssssssssjjjjjjjjjjjjjjjjjjjjjjjjeeeeeeeeeeeeeeeeeeekkkkkkkkk\n\n dddddddddddddddddddddddddkddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
        false,
        50),
    Recipe(
        "pizza facile 4",
        "Par Johan Kengni",
        "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGl6emF8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60",
        "lkddddsssssssssssssssssjjjjjjjjjjjjjjjjjjjjjjjjeeeeeeeeeeeeeeeeeeekkkkkkkkk\n\n dddddddddddddddddddddddddkddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
        false,
        50),
    Recipe(
        "pizza facile 5",
        "Par Johan Kengni",
        "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGl6emF8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60",
        "lkddddsssssssssssssssssjjjjjjjjjjjjjjjjjjjjjjjjeeeeeeeeeeeeeeeeeeekkkkkkkkk\n\n dddddddddddddddddddddddddkddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
        false,
        50),
    Recipe(
        "pizza facile 6",
        "Par Johan Kengni",
        "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGl6emF8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60",
        "lkddddsssssssssssssssssjjjjjjjjjjjjjjjjjjjjjjjjeeeeeeeeeeeeeeeeeeekkkkkkkkk\n\n dddddddddddddddddddddddddkddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
        false,
        50),
    Recipe(
        "pizza facile 7",
        "Par Johan Kengni",
        "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGl6emF8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60",
        "lkddddsssssssssssssssssjjjjjjjjjjjjjjjjjjjjjjjjeeeeeeeeeeeeeeeeeeekkkkkkkkk\n\n dddddddddddddddddddddddddkddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
        false,
        50),
    Recipe(
        "pizza facile 8",
        "Par Johan Kengni",
        "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGl6emF8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60",
        "lkddddsssssssssssssssssjjjjjjjjjjjjjjjjjjjjjjjjeeeeeeeeeeeeeeeeeeekkkkkkkkk\n\n dddddddddddddddddddddddddkddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
        false,
        50),
    Recipe(
        "pizza facile 9",
        "Par Johan Kengni",
        "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGl6emF8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60",
        "lkddddsssssssssssssssssjjjjjjjjjjjjjjjjjjjjjjjjeeeeeeeeeeeeeeeeeeekkkkkkkkk\n\n dddddddddddddddddddddddddkddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
        false,
        50),
    Recipe(
        "pizza facile 10",
        "Par Johan Kengni",
        "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGl6emF8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60",
        "lkddddsssssssssssssssssjjjjjjjjjjjjjjjjjjjjjjjjeeeeeeeeeeeeeeeeeeekkkkkkkkk\n\n dddddddddddddddddddddddddkddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
        false,
        50),
  ];
}









// import 'package:flutter/cupertino.dart';
// import 'package:path/path.dart';
// import 'package:recipe_app/recipe.dart';
// import 'package:sqflite/sqflite.dart';

// class RecipeDatabase {
//   RecipeDatabase._();

//   static final RecipeDatabase instance = RecipeDatabase._();
//   static Database? _database;

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await initDB();
//     return _database!;
//   }

//   initDB() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     return await openDatabase(
//       join(await getDatabasesPath(), 'recipe_database.db'),
//       onCreate: (db, version) {
//         return db.execute(
//             "CREATE TABLE recipe(title TEXT PRIMARY KEY, user TEXT, imageUrl TEXT, description TEXT, isFavorited INTEGER, favoriteCount INT)");
//       },
//       version: 1,
//     );
//   }

//   void insertRecipe(Recipe recipe) async {
//     final Database db = await database;

//     await db.insert('recipe', recipe.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   void updateRecipe(Recipe recipe) async {
//     final Database db = await database;

//     await db.update("recipe", recipe.toMap(),
//         where: "title = ?", whereArgs: [recipe.title]);
//   }

//   void deleteRecipe(String title) async {
//     final Database db = await database;
//     db.delete("recipe", where: "title = ?", whereArgs: [title]);
//   }

//   Future<List<Recipe>> recipes() async {
//     final Database db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('recipe');
//     List<Recipe> recipes =
//         List.generate(maps.length, (index) => Recipe.fromMap(maps[index]));

//     if (recipes.isEmpty) {
//       for (Recipe recipe in defaultRecipes) {
//         insertRecipe(recipe);
//       }
//       recipes = defaultRecipes;
//     }

//     return recipes;
//   }

//   final List<Recipe> defaultRecipes = [
//     Recipe(
//         "pizza facile 1",
//         "Par Johan Kengni",
//         "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGl6emF8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60",
//         "lkddddsssssssssssssssssjjjjjjjjjjjjjjjjjjjjjjjjeeeeeeeeeeeeeeeeeeekkkkkkkkk\n\n dddddddddddddddddddddddddkddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
//         false,
//         50),
//     Recipe(
//         "pizza facile 2",
//         "Par Johan Kengni",
//         "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGl6emF8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60",
//         "lkddddsssssssssssssssssjjjjjjjjjjjjjjjjjjjjjjjjeeeeeeeeeeeeeeeeeeekkkkkkkkk\n\n dddddddddddddddddddddddddkddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
//         false,
//         50),
//     Recipe(
//         "pizza facile 3",
//         "Par Johan Kengni",
//         "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGl6emF8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60",
//         "lkddddsssssssssssssssssjjjjjjjjjjjjjjjjjjjjjjjjeeeeeeeeeeeeeeeeeeekkkkkkkkk\n\n dddddddddddddddddddddddddkddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
//         false,
//         50),
//     Recipe(
//         "pizza facile 4",
//         "Par Johan Kengni",
//         "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGl6emF8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60",
//         "lkddddsssssssssssssssssjjjjjjjjjjjjjjjjjjjjjjjjeeeeeeeeeeeeeeeeeeekkkkkkkkk\n\n dddddddddddddddddddddddddkddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
//         false,
//         50),
//     Recipe(
//         "pizza facile 5",
//         "Par Johan Kengni",
//         "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGl6emF8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60",
//         "lkddddsssssssssssssssssjjjjjjjjjjjjjjjjjjjjjjjjeeeeeeeeeeeeeeeeeeekkkkkkkkk\n\n dddddddddddddddddddddddddkddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
//         false,
//         50),
//     Recipe(
//         "pizza facile 6",
//         "Par Johan Kengni",
//         "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGl6emF8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60",
//         "lkddddsssssssssssssssssjjjjjjjjjjjjjjjjjjjjjjjjeeeeeeeeeeeeeeeeeeekkkkkkkkk\n\n dddddddddddddddddddddddddkddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
//         false,
//         50),
//     Recipe(
//         "pizza facile 7",
//         "Par Johan Kengni",
//         "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGl6emF8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60",
//         "lkddddsssssssssssssssssjjjjjjjjjjjjjjjjjjjjjjjjeeeeeeeeeeeeeeeeeeekkkkkkkkk\n\n dddddddddddddddddddddddddkddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
//         false,
//         50),
//     Recipe(
//         "pizza facile 8",
//         "Par Johan Kengni",
//         "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGl6emF8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60",
//         "lkddddsssssssssssssssssjjjjjjjjjjjjjjjjjjjjjjjjeeeeeeeeeeeeeeeeeeekkkkkkkkk\n\n dddddddddddddddddddddddddkddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
//         false,
//         50),
//     Recipe(
//         "pizza facile 9",
//         "Par Johan Kengni",
//         "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGl6emF8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60",
//         "lkddddsssssssssssssssssjjjjjjjjjjjjjjjjjjjjjjjjeeeeeeeeeeeeeeeeeeekkkkkkkkk\n\n dddddddddddddddddddddddddkddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
//         false,
//         50),
//     Recipe(
//         "pizza facile 10",
//         "Par Johan Kengni",
//         "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGl6emF8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60",
//         "lkddddsssssssssssssssssjjjjjjjjjjjjjjjjjjjjjjjjeeeeeeeeeeeeeeeeeeekkkkkkkkk\n\n dddddddddddddddddddddddddkddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
//         false,
//         50),
//   ];
// }
