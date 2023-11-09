import 'package:flutter/material.dart';
import 'package:movie/api_constant.dart';
import 'package:movie/viewmodel/providers/fav_list_provider.dart';
import 'package:movie/viewmodel/providers/movie_get_discover_provider.dart';
import 'package:movie/view/screens/detail_movie_screen.dart';
import 'package:movie/view/screens/login_screen.dart';
import 'package:movie/view/screens/search_movie_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variabel untuk menyimpan SharedPreferences dan username
  late SharedPreferences loginData;
  String username = "";

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      username = loginData.getString('username')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavoriteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              loginData.setBool('login', true);
              loginData.remove('username');
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
        title: Text(
          "Discover Movies",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Consumer<MovieGetDiscoverProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.movie.isNotEmpty) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Hello $username',
                          style: TextStyle(fontSize: 24),
                        ),
                        Expanded(child: SizedBox()),
                        IconButton(
                          onPressed: () => showSearch(
                            context: context,
                            delegate: SearchMovieScreen(),
                          ),
                          icon: Icon(Icons.search),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 16),
                      shrinkWrap: true,
                      itemCount: provider.movie.length,
                      itemBuilder: (context, index) {
                        final movie = provider.movie[index];

                        return Container(
                          margin: EdgeInsets.only(bottom: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return DetailMovieScreen(
                                            id: movie.id,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Image.network(
                                    '${APIConstant.imageUrlOriginal}${movie.backdropPath}',
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                Positioned(
                                  left: 16,
                                  bottom: 16,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          SizedBox(width: 8),
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
                                  child: IconButton(
                                    onPressed: () {
                                      favProvider.addFavorite(movie);
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      movie.isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: 32,
                                      color: movie.isFavorite
                                          ? Colors.red
                                          : Colors.white,
                                    ),
                                  ),
                                  right: 16,
                                  top: 16,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          return Center(
            child: Text('Not Found Discover Movies'),
          );
        },
      ),
    );
  }
}
