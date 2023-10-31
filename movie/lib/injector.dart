import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/api_constant.dart';
import 'package:movie/viewmodel/providers/fav_list_provider.dart';
import 'package:movie/viewmodel/providers/movie_get_detail_provider.dart';
import 'package:movie/viewmodel/providers/movie_get_discover_provider.dart';
import 'package:movie/viewmodel/providers/movie_search_provider.dart';
import 'package:movie/viewmodel/repositories/movie_repository.dart';
import 'package:movie/viewmodel/repositories/movie_repository_implement.dart';

final serviceLocator = GetIt.instance;

void setup() {
  // Register Provider
  serviceLocator.registerFactory<MovieGetDiscoverProvider>(
      () => MovieGetDiscoverProvider(serviceLocator()));
  serviceLocator.registerFactory<GetMovieDetailProvider>(
      () => GetMovieDetailProvider(serviceLocator()));
  serviceLocator.registerFactory<MovieSearchProvider>(
      () => MovieSearchProvider(serviceLocator()));
  serviceLocator.registerFactory<FavoriteProvider>(
      () => FavoriteProvider(serviceLocator()));

  // Register repository
  serviceLocator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImplements(
      serviceLocator(),
    ),
  );

  // Register Http Client (Dio)
  serviceLocator.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: APIConstant.base_url,
        queryParameters: {'api_key': APIConstant.apiKey},
      ),
    ),
  );
}

// karena variabel dio pada main.dart dibuat secara manual, otomatis semua repository yang membutuhkan dio akan diinjeksi secara manual juga. 
// memanfaatkan service locator untuk menginjeksi dio ke dalam repository yang membutuhkan dio
