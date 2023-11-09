import 'package:flutter/material.dart';
import 'package:movie/api_constant.dart';
import 'package:movie/viewmodel/providers/fav_list_provider.dart';
import 'package:provider/provider.dart';

class MovieFavItemWidget extends StatefulWidget {
  final dynamic movie;

  MovieFavItemWidget({required this.movie});

  @override
  State<MovieFavItemWidget> createState() => _MovieFavItemWidgetState();
}

class _MovieFavItemWidgetState extends State<MovieFavItemWidget> {
  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context,
        listen: true); // Dapatkan akses ke FavoriteProvider
    print('ini data baru');
    print(widget.movie);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      // height: 300,

      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Expanded(
              child: Image.network(
                '${APIConstant.imageUrlOriginal}${widget.movie.backdropPath}',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 100,
              ),
            ),
            Positioned(
              left: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie.title,
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
                        '${widget.movie.voteAverage.toString()}  (${widget.movie.voteCount})',
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
              right: 16,
              bottom: 24,
              child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 32,
                  ),
                  onPressed: () async {
                    await favoriteProvider.removeFavorite(widget.movie);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
