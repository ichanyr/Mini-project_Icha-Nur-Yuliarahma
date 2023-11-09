import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movie/injector.dart';
import 'package:movie/viewmodel/providers/fav_list_provider.dart';
import 'package:movie/viewmodel/providers/movie_get_discover_provider.dart';
import 'package:movie/viewmodel/providers/movie_search_provider.dart';
import 'package:movie/view/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  setup();

  runApp(MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => serviceLocator<MovieGetDiscoverProvider>(),
          ),
          ChangeNotifierProvider(
            create: (_) => serviceLocator<MovieSearchProvider>(),
          ),
          ChangeNotifierProvider(
            create: (_) => FavoriteProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            useMaterial3: true,
          ),
          // home: NavigationScreen(),
          home: LoginScreen(),
          // routes: {
          //   '/login': (context) => LoginScreen(),
          //   '/register': (context) => RegisterScreen(),
          // },
        ));
  }
}
