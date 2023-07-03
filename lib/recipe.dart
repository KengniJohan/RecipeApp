import 'package:hive/hive.dart';

part 'recipe.g.dart';

@HiveType(typeId: 0)
class Recipe {

  @HiveField(0)
  String title;
  
  @HiveField(1)
  String user;

  @HiveField(2)
  String imageUrl;

  @HiveField(3)
  String description;

  @HiveField(4)
  bool isFavorited;

  @HiveField(5)
  int favoriteCount;

  Recipe(
    this.title,
    this.user,
    this.imageUrl,
    this.description,
    this.isFavorited,
    this.favoriteCount
  );

  String key() => title.hashCode.toString();

  // Map<String, dynamic> toMap() {
  //   return {
  //     'title': title,
  //     'user': user,
  //     'imageUrl': imageUrl,
  //     'description': description,
  //     'isFavorited': isFavorited,
  //     'favoriteCount': favoriteCount
  //   };
  // }

  // factory Recipe.fromMap(Map<String, dynamic> map) => Recipe(
  //   map['title'],
  //   map['user'],
  //   map['imageUrl'],
  //   map['description'],
  //   map['isFavorited'] == 1,
  //   map['favoriteCount']
  // );

}