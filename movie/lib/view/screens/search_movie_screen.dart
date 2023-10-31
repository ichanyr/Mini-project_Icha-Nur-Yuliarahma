import 'package:flutter/material.dart';
import 'package:movie/viewmodel/providers/movie_search_provider.dart';
import 'package:provider/provider.dart';

class SearchMovieScreen extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // fungsi untuk mengambil data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (query.isNotEmpty) {
        context.read<MovieSearchProvider>().search(context, query: query);
      }
      print(query);
    });

    return Consumer<MovieSearchProvider>(builder: (_, provider, __) {
      if (query.isEmpty) {
        return Center(
          child: Text(
            ('Search Movies'),
          ),
        );
      }
      if (provider.isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (provider.searchMovie.isEmpty) {
        return Center(
          child: Text('Movies Not Found'),
        );
      }
      if (provider.searchMovie.isNotEmpty) {
        return ListView.separated(
          itemBuilder: (_, index) => Text(provider.searchMovie[index].title),
          itemCount: provider.searchMovie.length,
          separatorBuilder: (_, index) => SizedBox(),
        );
      }
      return Center(
        child: Text('Another error on search movies'),
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SizedBox();
  }
}
