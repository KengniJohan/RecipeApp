import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/favorite_change_notifier.dart';

class FavoriteIconWidget extends StatefulWidget {
  const FavoriteIconWidget(
      {super.key});

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {

  late bool _isFavorited;

  void _toggleFavorite(FavoriteChangeNotifier _notifier) {
    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
      } else {
        _isFavorited = true;
      }

      _notifier.isFavorited = _isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    FavoriteChangeNotifier _notifier = Provider.of<FavoriteChangeNotifier>(context);
    _isFavorited = _notifier.isFavorited;
    return IconButton(
          onPressed: () => _toggleFavorite(_notifier),
          icon: _isFavorited
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border),
          color: Colors.red,
        );
  }
}

class FavoriteTextWidget extends StatefulWidget {

  @override
  State<FavoriteTextWidget> createState() => _FavoriteTextWidgetState();
}

class _FavoriteTextWidgetState extends State<FavoriteTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteChangeNotifier>(
      builder: (context, notifier, _) => Text("${notifier.favoriteCount}")
    );
  }
}

