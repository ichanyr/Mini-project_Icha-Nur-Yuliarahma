import 'package:flutter/material.dart';
import 'package:movie/api_constant.dart';
import 'package:movie/providers/moviegetdiscover_viewmodel.dart';
import 'package:movie/screens/detail_movie_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final PagingController<int, MovieDetailModel> _pagingController =
  //     PagingController(firstPageKey: 1);
  // @override
  // void initState() {
  //   _pagingController.addPageRequestListener((pageKey) {
  //     context.read<MovieGetDiscover>().getDiscover(
  //           context,
  //           page: pageKey,
  //           pagingController: _pagingController,
  //         );
  //   });
  //   super.initState();
  // }

  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        context.read<MovieGetDiscover>().getDiscoverMovie(context);
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Discover Movies"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Consumer<MovieGetDiscover>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          // body: PagedListView.separated(pagingController: _pagingController, builderDelegate: PagedChildBuilderDelegate<MovieDetailModel>(itemBuilder: ((context, item, index) {

          // })), separatorBuilder: separatorBuilder),

          if (provider.movie.isNotEmpty)
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello Icha',
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Discover movies',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          prefixIcon: Icon(Icons.search)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 16),
                      shrinkWrap: true,
                      itemCount: provider.movie.length,
                      itemBuilder: (context, index) {
                        final movie = provider.movie[index];

                        return InkWell(
                          onTap: () {
                            // Navigasi ke halaman baru
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
                          child: Container(
                            margin: EdgeInsets.only(bottom: 16),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Stack(children: [
                                Image.network(
                                  '${APIConstant.imageUrlOriginal}${movie.backdropPath}',
                                  fit: BoxFit.fitWidth,
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
                                            color: Colors.white),
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
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 32,
                                  ),
                                  right: 16,
                                  top: 16,
                                )
                              ]),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            );

          return Center(
            child: Text('Not Found Discover Movies'),
          );
        },
      ),
    );
  }

  // @override
  // void dispose() {
  //   _pagingController.dispose();
  //   super.dispose();
  // }
}
