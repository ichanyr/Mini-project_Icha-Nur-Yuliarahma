import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie/models/movie_model.dart';
import 'package:movie/repositories/movie_repository.dart';

class MovieRepositoryImplements implements MovieRepository {
  final Dio _dio;

  MovieRepositoryImplements(this._dio); // constructor
  @override
  // method getDiscover
  Future<Either<String, MovieResponseModel>> getDiscover({int page = 3}) async {
    try {
      // menunggu hasil permintaan HTTP selesai
      final result = await _dio.get(
        '/discover/movie',
        queryParameters: {'page': page},
      );
      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromJson(result.data);
        return Right(model);
      }
      //   throw 'Error get Discover movies';
      // } catch (e) {
      //   throw e.toString();
      // }
      return Left('Error get Discover movies');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return Left('Another error on get discover movies');
    }
  }
}

/// terdapat method getDiscover yang akan mengirim req berupa http client yang berupa method get ke server MTDB 
/// jika berhasil akan mengembalikan rawjson yang terdapat pada result.data yang dikonversi ke kelas MovieResponseModel
/// dan dikembalikan MovieResponseModel jika sudah berhasil
/// jika gagal akan mengembalikan message gagal
/// jika 401 dan 404 akan mengeksekusi dioerror