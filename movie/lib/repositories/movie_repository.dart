import 'package:dartz/dartz.dart';
import 'package:movie/models/movie_detail_model.dart';
import 'package:movie/models/movie_model.dart';

abstract class MovieRepository {
  // get discover movies
  Future<Either<String, MovieResponseModel>> getDiscoverMovie({int page = 1});
  // get movie detail
  Future<Either<String, MovieDetailModel>> getDetailMovie({required int id});
}
