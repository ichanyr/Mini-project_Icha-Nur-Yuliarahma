import 'package:flutter/material.dart';
import 'package:movie/models/movie_detail_model.dart';
import 'package:movie/repositories/movie_repository.dart';

class GetMovieDetailProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  GetMovieDetailProvider(this._movieRepository);

  MovieDetailModel? _movie;
  MovieDetailModel? get movie => _movie;

  void getDetail(BuildContext context, {required int id}) async {
    _movie = null;
    notifyListeners();
    final result = await _movieRepository.getDetailMovie(id: id);
    result.fold(
      (l) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l),
          ),
        );
        _movie = null;
        notifyListeners();
        return;
      },
      (r) {
        _movie = r;
        notifyListeners();
        return;
      },
    );
  }
}
