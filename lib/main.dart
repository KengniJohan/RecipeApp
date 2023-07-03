import 'package:flutter/material.dart';
import 'package:recipe_app/recipe_box.dart';
import 'package:recipe_app/recipe_form_screen.dart';
import 'package:recipe_app/recipe_screen.dart';
import 'package:recipe_app/recipe_update_form_screen.dart';
import 'recipe.dart';
import 'recipe_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RecipeBox.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (context) => const RecipeListScreen());

      case '/recipe':
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                RecipeScreen(recipe: settings.arguments as Recipe),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              // var begin = const Offset(0.0, 1.0);
              // var end = Offset.zero;
              // var curve = Curves.ease;
              // var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              // return SlideTransition(
              //   position: animation.drive(tween),
              //   child: child
              // );

              animation =
                  CurvedAnimation(parent: animation, curve: Curves.ease);
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            });

      case '/newRecipe':
        return MaterialPageRoute(
            builder: (context) => const RecipeFormScreen());

      case '/updateRecipe':
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                RecipeUpdateFormScreen(recipe: settings.arguments as Recipe),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              // var begin = const Offset(0.0, 1.0);
              // var end = Offset.zero;
              // var curve = Curves.ease;
              // var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              // return SlideTransition(
              //   position: animation.drive(tween),
              //   child: child
              // );

              animation =
                  CurvedAnimation(parent: animation, curve: Curves.ease);
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            });

      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: const Text("Error"),
                    centerTitle: true,
                  ),
                  body: const Center(child: Text("Page not found")),
                ));
    }
  }
}
