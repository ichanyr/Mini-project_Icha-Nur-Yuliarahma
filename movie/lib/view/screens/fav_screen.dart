import 'package:flutter/material.dart';
import 'package:movie/viewmodel/providers/fav_list_provider.dart';
import 'package:movie/widget/movie_fav_item_widget.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavoriteProvider>(context); //object
    print('ini adl favscreen');
    print(favProvider);
    print(favProvider.favoriteMovies.length);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Favorite Movies',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      //property: value berupa class
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: favProvider.favoriteMovies.length,
                //property : value
                // property itemBuilder memiliki 2 value yaitu context dan index
                itemBuilder: (context, index) {
                  final movie = favProvider.favoriteMovies[index];
                  return MovieFavItemWidget(movie: movie);
                })
          ],
        ),
      ),
      // body: Consumer<FavoriteProvider>(
      //   builder: (_, provider, __) {
      // final favoriteMovies = provider.favoriteMovies;
      // print(favoriteMovies);
      // return Container();
      // if (favoriteMovies.isEmpty) {
      //   return Center(
      //     child: Text('No favorite movies yet.'),
      //   );
      // }

      // return ListView.builder(
      //   itemCount: favoriteMovies.length,
      //   itemBuilder: (context, index) {
      //     final movie = favoriteMovies[index];

      //     return ListTile(
      //       leading: Image.network(
      //         '${APIConstant.imageUrlOriginal}${movie.posterPath}',
      //         width: 80,
      //       ),
      //       title: Text(movie.title),
      //       subtitle: Text(
      //         'Rating: ${movie.voteAverage.toString()} (${movie.voteCount})',
      //       ),
      //       trailing: IconButton(
      //         icon: Icon(Icons.favorite, color: Colors.red),
      //         onPressed: () {
      //           // Menghapus film dari daftar favorit
      //           provider.removeFavorite(movie);
      //         },
      //       ),
      //       onTap: () {
      //         // Navigasi ke halaman detail film
      //         Navigator.of(context).push(
      //           MaterialPageRoute(
      //             builder: (context) {
      //               // Gantilah dengan halaman detail film
      //               return DetailMovieScreen(id: movie.id);
      //             },
      //           ),
      //         );
      //       },
      //     );
      //   },
      // );
      //     },
      //   ),
    );
  }
}
