import 'package:flutter/material.dart';
import 'package:movie/api_constant.dart';

class MovieDetailWidget extends StatelessWidget {
  final dynamic movie;

  MovieDetailWidget({required this.movie});

  @override
  Widget build(BuildContext context) {
    print('ini dat baru');
    print(movie);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      // height: 300,

      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Expanded(
              child: Image.network(
                '${APIConstant.imageUrlOriginal}${movie.backdropPath}',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300,
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
            // Positioned(
            //   child: Icon(
            //     Icons.public,
            //     color: Colors.white,
            //     size: 32,
            //   ),
            //   right: 16,
            //   top: 50,
            // )
          ],
        ),
      ),
    );
  }
}
