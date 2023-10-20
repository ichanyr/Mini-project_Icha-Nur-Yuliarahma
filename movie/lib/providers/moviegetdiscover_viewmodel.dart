import 'package:flutter/material.dart';
import 'package:movie/models/movie_model.dart';
import 'package:movie/repositories/movie_repository.dart';

class MovieGetDiscover with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieGetDiscover(this._movieRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieDetailModel> _movies = [];
  List<MovieDetailModel> get movies => _movies;

  void getDiscover(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    final result = await _movieRepository.getDiscover();

    result.fold((l) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l),
        ),
      );
      _isLoading = false;
      notifyListeners();

      return;
    }, (r) {
      _movies.clear();
      _movies.addAll(r.results);

      _isLoading = false;
      notifyListeners();
      return null;
    });
  }

  // void getDiscoverWithPaging(){}
}
