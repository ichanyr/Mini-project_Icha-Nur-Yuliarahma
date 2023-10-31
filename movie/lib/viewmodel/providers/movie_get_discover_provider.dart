import 'package:flutter/material.dart';
import 'package:movie/models/movie_model.dart';
import 'package:movie/viewmodel/repositories/movie_repository.dart';

class MovieGetDiscoverProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieGetDiscoverProvider(this._movieRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieModel> _movie = [];
  List<MovieModel> get movie => _movie;

  void getDiscoverMovie(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    final result = await _movieRepository.getDiscoverMovie();

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
      _movie.clear();
      _movie.addAll(r.results);

      _isLoading = false;
      notifyListeners();
      return null;
    });
  }

  // void getDiscover(
  //   BuildContext context, {
  //   required int page,
  //   required PagingController pagingController,
  // }) async {
  //   // _isLoading = true;
  //   // notifyListeners();
  //   // final result = await _movieRepository.getDiscover();
  //   final result = await _movieRepository.getDiscover(page: page);

  //   result.fold((l) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(l),
  //       ),
  //     );
  //     // _isLoading = false;
  //     // notifyListeners();

  //     return;
  //   }, (r) {
  //     if (r.results.length < 20) {
  //       pagingController.appendLastPage(r.results);
  //     } else {
  //       pagingController.appendPage(r.results, page++);
  //     }
  //     // _movies.clear();
  //     // _movies.addAll(r.results);

  //     // _isLoading = false;
  //     // notifyListeners();
  //     // return null;_movies.clear();
  //     // _movies.addAll(r.results);

  //     // _isLoading = false;
  //     // notifyListeners();
  //     return null;
  //   });
}
