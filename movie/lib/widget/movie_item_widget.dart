import 'package:flutter/material.dart';
import 'package:movie/api_constant.dart';
import 'package:movie/models/movie_detail_model.dart';

class MovieItemWidget extends StatelessWidget {
  final MovieDetailModel movie;

  MovieItemWidget({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 300,
      margin: EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Expanded(
              child: Image.network(
                '${APIConstant.imageUrlOriginal}${movie.backdropPath}',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 400,
              ),
            ),
            Positioned(
              left: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        '${movie.voteAverage.toString()}  (${movie.voteCount})',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              child: Icon(
                Icons.public,
                color: Colors.white,
                size: 32,
              ),
              right: 16,
              top: 50,
            )
          ],
        ),
      ),
    );
  }
}
