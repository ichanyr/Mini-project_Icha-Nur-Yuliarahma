import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movie/injector.dart';
import 'package:movie/navigation_screen.dart';
import 'package:movie/providers/moviegetdiscover_viewmodel.dart';
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
            create: (_) => serviceLocator<MovieGetDiscover>(),
          ),
        ],
        child: MaterialApp(
          // routes: {
          //   '/home': (context) => HomeScreen(),
          //   '/search': (context) => SearchScreen(),
          // },
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
