import 'package:flutter/material.dart';
import 'package:movie/models/movie_model.dart';

class FavoriteProvider with ChangeNotifier {
  List<MovieModel> _favoriteMovies = [];

  FavoriteProvider(Object object);

  List<MovieModel> get favoriteMovies => _favoriteMovies;

  void addFavorite(MovieModel movie) {
    _favoriteMovies.add(movie);
    notifyListeners();
  }

  void removeFavorite(MovieModel movie) {
    _favoriteMovies.remove(movie);
    notifyListeners();
  }
}
