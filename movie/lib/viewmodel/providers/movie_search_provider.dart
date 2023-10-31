import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/movie_model.dart';
import 'package:movie/viewmodel/repositories/movie_repository.dart';

class MovieSearchProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieSearchProvider(this._movieRepository);

  final List<MovieModel> _searchMovie = [];
  List<MovieModel> get searchMovie => _searchMovie;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;

  void search(BuildContext context, {required String query}) async {
    _isLoading = true;
    _searchMovie.clear();

    notifyListeners();
    final result = await _movieRepository.getDiscoverMovie();
    print(result.length());
    result.fold((left) {
      // Handle error (left side of Either)
      print("Error: $left");
    }, (right) {
      // Handle valid result (right side of Either)
      print(right.totalResults);
      final moviesResult = right.results;
      print(moviesResult);
      print(moviesResult.length);
      final filterMovie =
          moviesResult.where((movie) => movie.title.contains(query)).toList();
      _searchMovie.addAll(filterMovie);
      print('ini data');
      print(searchMovie);
      _isLoading = false;
      notifyListeners();
    });
    _isLoading = false;

    // final result = await _movieRepository.search(query: query);
    print(query);
    print(movies);
    // print(result);
//     result.fold((l) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(l),
//         ),
//       );
//       _isLoading = false;
//       notifyListeners();

//       return;
//     }, (r) {
//       _movies.clear();
//       _movies.addAll(r.results);

//       _isLoading = false;
//       notifyListeners();
//     });
  }
}
