import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:recipe_app/favorite_change_notifier.dart';
import 'favorite_widget.dart';
import 'recipe.dart';
import 'package:provider/provider.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          recipe.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
                    Container(
                        child: Text(
                      recipe.user,
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                    )),
                  ],
                ),
              ),
              const FavoriteIconWidget(),
              FavoriteTextWidget()
            ],
          ),
        )
      ],
    );

    Widget buttonSection = Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(Colors.blue, Icons.comment, "COMMENT"),
          _buildButtonColumn(Colors.blue, Icons.share, "SHARE")
        ],
      ),
    );

    Widget descriptionSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        recipe.description,
        softWrap: true,
      ),
    );

    return ChangeNotifierProvider(
      create: (context) => FavoriteChangeNotifier(recipe),
      child: Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: const Text("Mes recettes"),
          ),
          body: ListView(
            children: [
              Stack(
                children: [
                  // Container(
                  //   width: 600,
                  //   height: 240,
                  //   child: const Center(
                  //     child: CircularProgressIndicator(),
                  //   ),
                  // ),
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
                      width: 600,
                      height: 240,
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      File(recipe.imageUrl),
                      width: 600,
                      height: 240,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              titleSection,
              buttonSection,
              descriptionSection
            ],
          )
          // This trailing comma makes auto-formatting nicer for build methods.
          ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: Icon(icon, color: color)),
        Text(
          label,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, color: color),
        )
      ],
    );
  }
}
