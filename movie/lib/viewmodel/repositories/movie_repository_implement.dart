import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie/api_constant.dart';
import 'package:movie/models/movie_detail_model.dart';
import 'package:movie/models/movie_model.dart';
import 'package:movie/viewmodel/repositories/movie_repository.dart';

class MovieRepositoryImplements implements MovieRepository {
  final Dio _dio;

  MovieRepositoryImplements(this._dio); // constructor
  @override
  // method getDiscover
  Future<Either<String, MovieResponseModel>> getDiscoverMovie(
      {int page = 1}) async {
    try {
      final Dio dio = Dio(
        BaseOptions(
          baseUrl: APIConstant.base_url,
          queryParameters: {'api_key': APIConstant.apiKey},
        ),
      );
      print('test');
      // menunggu hasil permintaan HTTP selesai
      final result = await dio.get(
        '/discover/movie/',
        queryParameters: {'page': page},
      );
      print('response = ${result.statusCode}');
      print('response = ${result.data}');
      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromJson(result.data);
        return Right(model);
      }
      //   throw 'Error get Discover movies';
      // } catch (e) {
      //   throw e.toString();
      // }
      return Left('Error get Discover movies');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return Left('Another error on get discover movies');
    }
  }

  @override
  Future<Either<String, MovieDetailModel>> getDetailMovie(
      {required int id}) async {
    try {
      // menunggu hasil permintaan HTTP selesai
      final result = await _dio.get(
        '/movie/$id',
      );
      if (result.statusCode == 200 && result.data != null) {
        final model = MovieDetailModel.fromJson(result.data);
        return Right(model);
      }
      //   throw 'Error get Discover movies';
      // } catch (e) {
      //   throw e.toString();
      // }
      return Left('Error get detail movies');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return Left('Another error on get detail movies');
    }
  }

  @override
  Future<Either<String, MovieResponseModel>> search({
    required String query,
  }) async {
    try {
      // menunggu hasil permintaan HTTP selesai
      final result = await _dio.get(
        '/search/movie',
        queryParameters: {'query': query},
      );
      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromJson(result.data);
        return Right(model);
      }
      //   throw 'Error get Discover movies';
      // } catch (e) {
      //   throw e.toString();
      // }
      return Left('Error search movie');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return Left('Another error on get detail movies');
    }
  }
}

/// terdapat method getDiscover yang akan mengirim req berupa http client yang berupa method get ke server MTDB 
/// jika berhasil akan mengembalikan rawjson yang terdapat pada result.data yang dikonversi ke kelas MovieResponseModel
/// dan dikembalikan MovieResponseModel jika sudah berhasil
/// jika gagal akan mengembalikan message gagal
/// jika 401 dan 404 akan mengeksekusi dioerror
