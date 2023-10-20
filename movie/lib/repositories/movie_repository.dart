import 'package:dartz/dartz.dart';
import 'package:movie/models/movie_model.dart';

abstract class MovieRepository {
  // get discover movies
  Future<Either<String, MovieResponseModel>> getDiscover({int page = 1});
}
