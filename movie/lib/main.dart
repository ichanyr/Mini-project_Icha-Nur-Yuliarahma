import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movie/api_constant.dart';
import 'package:movie/navigation_screen.dart';
import 'package:movie/providers/moviegetdiscover_viewmodel.dart';
import 'package:movie/repositories/movie_repository.dart';
import 'package:movie/repositories/movie_repository_implement.dart';
import 'package:movie/screens/home_screen.dart';
import 'package:movie/screens/search_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final dioOptions = BaseOptions(
    baseUrl: APIConstant.base_url,
    queryParameters: {'api_key': APIConstant.apiKey},
  );

  final Dio dio = Dio(dioOptions);
  final MovieRepository movieRepository = MovieRepositoryImplements(dio);

  runApp(MyApp(
    movieRepository: movieRepository,
  ));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.movieRepository});

  final MovieRepository movieRepository;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => MovieGetDiscover(movieRepository)),
        ],
        child: MaterialApp(
          routes: {
            '/home': (context) => HomeScreen(),
            '/search': (context) => SearchScreen(),
          },
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            useMaterial3: true,
          ),
          home: NavigationScreen(),
        ));
  }
}
