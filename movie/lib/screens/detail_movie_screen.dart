import 'dart:math';
import 'package:flutter/material.dart';
import 'package:movie/injector.dart';
import 'package:movie/providers/movie_get_detail_provider.dart';
import 'package:provider/provider.dart';

class DetailMovieScreen extends StatelessWidget {
  const DetailMovieScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => serviceLocator<GetMovieDetailProvider>()
          ..getDetail(context, id: id),
        builder: (_, __) => Scaffold(body: SingleChildScrollView(child:
                Consumer<GetMovieDetailProvider>(builder: (_, provider, __) {
              if (provider.movie != null) {
                print(provider.movie.toString());
              }
              return AppBar(
                title: Text(
                  provider.movie == null ? '' : provider.movie!.title,
                ),
                backgroundColor: Colors.red,
              );
            }))));
  }
}

// register provider terdapat di classnya sendiri karena akan dipakai ketika detail dipanggil
