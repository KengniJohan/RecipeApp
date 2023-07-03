import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/recipe_box.dart';
import 'recipe.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return RecipeListScreenState();
  }
}

class RecipeListScreenState extends State<RecipeListScreen> {
  Future<bool?> _deleteConfirmation(recipe, keys, index) async {
    bool? canDelete;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Delete recipe",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            content: Text(
                "Do you really want to delete the recipe \"${recipe.title}\" ?"),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    canDelete = false;
                  },
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      RecipeBox.box?.delete(keys[index]);
                      // RecipeDatabase.instance.deleteRecipe(recipe.title);
                    });
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${recipe.title} supprimé")));
                    canDelete = true;
                  },
                  icon: const Icon(
                    Icons.check,
                    color: Colors.green,
                  ))
            ],
          );
        });
    return canDelete;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes recettes"),
      ),
      body: /*FutureBuilder<List<Recipe>>*/ ValueListenableBuilder(
          builder: (context, items, _) {
            List<String> keys = items.keys.cast<String>().toList();
            return ListView.builder(
              itemCount: keys.length,
              itemBuilder: (context, index) {
                final recipe = items.get(keys[index]);
                return Dismissible(
                    key: ValueKey(recipe.title),
                    confirmDismiss: (direction) {
                      return _deleteConfirmation(recipe, keys, index);
                    },
                    background: Container(color: Colors.red),
                    child: RecipeItemWidget(recipe: recipe));
              },
            );
          },
          /*future: RecipeDatabase.instance.recipes()*/ valueListenable:
              RecipeBox.box!.listenable()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/newRecipe');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class RecipeItemWidget extends StatelessWidget {
  const RecipeItemWidget({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Navigator.pushNamed(context, '/updateRecipe', arguments: recipe);
      },
      onTap: () {
        Navigator.pushNamed(context, '/recipe', arguments: recipe);
      },
      child: Card(
        margin: const EdgeInsets.all(8.0),
        elevation: 8.0,
        child: Row(
          children: [
            Hero(
              tag: "imageRecipe${recipe.title}",
              child: recipe.imageUrl.startsWith("https://") ||
                      recipe.imageUrl.startsWith("http://")
                  ? CachedNetworkImage(
                      imageUrl: recipe.imageUrl,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      File(recipe.imageUrl),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      recipe.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Text(
                    recipe.user,
                    style: TextStyle(color: Colors.grey[500], fontSize: 16),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
