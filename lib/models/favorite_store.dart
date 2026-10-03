
import 'package:flutter/material.dart';

class FavoriteProperty {
  final String title;
  final String location;
  final int amount;
  final String imagePath;

  const FavoriteProperty({
    required this.title,
    required this.location,
    required this.amount,
    required this.imagePath,
  });
}

class FavoriteStore extends ChangeNotifier {
  FavoriteStore._();

  static final FavoriteStore instance = FavoriteStore._();

  final List<FavoriteProperty> _favorites = [];

  List<FavoriteProperty> get favorites =>
      List.unmodifiable(_favorites);

  bool isFavorite(String title) {
    return _favorites.any((item) => item.title == title);
  }

  void toggleFavorite(FavoriteProperty property) {
    if (isFavorite(property.title)) {
      _favorites.removeWhere(
            (item) => item.title == property.title,
      );
    } else {
      _favorites.add(property);
    }

    notifyListeners();
  }
}