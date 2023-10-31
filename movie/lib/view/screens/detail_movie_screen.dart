import 'package:flutter/material.dart';
import 'package:movie/injector.dart';
import 'package:movie/viewmodel/providers/movie_get_detail_provider.dart';
import 'package:movie/widget/movie_item_widget.dart';
import 'package:provider/provider.dart';

class DetailMovieScreen extends StatelessWidget {
  const DetailMovieScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          serviceLocator<GetMovieDetailProvider>()..getDetail(context, id: id),
      builder: (_, __) => Scaffold(
        body: CustomScrollView(
          slivers: [
            _widgetAppBar(
              context: context,
            ),
            _WidgetSummary(),
          ],
        ),
      ),
    );
  }
}

class _widgetAppBar extends SliverAppBar {
  final BuildContext context;

  _widgetAppBar({required this.context});
  // @override
  // Color? get backgroundColor => Colors.amber;

  // @override
  // Color? get foregroundColor => Colors.amber;

  @override
  // TODO: implement leading
  Widget? get leading => Consumer<GetMovieDetailProvider>(
        builder: (_, provider, __) {
          final movie = provider.movie;
          if (movie != null) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
              ),
            );
          }

          return Container();
        },
      );

  @override
  double? get expandedHeight => 280;

  @override
  Widget? get flexibleSpace => Consumer<GetMovieDetailProvider>(
        builder: (_, provider, __) {
          final movie = provider.movie;
          if (movie != null) {
            return MovieItemWidget(movie: movie);
          }
          // Jika movie null, Anda bisa mengembalikan Widget lain atau null sesuai kebutuhan.
          return Container();
        },
      );
}

class _WidgetSummary extends SliverToBoxAdapter {
  Widget _content({required String title, required Widget body}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        body,
        SizedBox(
          height: 12,
        ),
      ],
    );
  }

  TableRow _tableContent({required String title, required String content}) =>
      TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(content),
          ),
        ],
      );

  @override
  // TODO: implement child
  Widget? get child => Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<GetMovieDetailProvider>(builder: (_, provider, __) {
          final movie = provider.movie;

          if (movie != null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _content(
                  title: 'Release Date',
                  body: Row(
                    children: [
                      Icon(
                        Icons.calendar_month_rounded,
                        size: 32,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        movie.releaseDate.toString().split(' ').first,
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                _content(
                  title: 'Genres',
                  body: Wrap(
                    spacing: 8,
                    children: (movie.genres)
                        .map(
                          (genre) => Chip(label: Text(genre.name)),
                        )
                        .toList(),
                  ),
                ),
                _content(
                  title: 'Overview',
                  body: Text(
                    movie.overview,
                  ),
                ),
                _content(
                  title: 'Summary',
                  body: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(2),
                    },
                    border: TableBorder.all(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    children: [
                      _tableContent(
                          title: 'Adult', content: movie.adult ? 'Yes' : 'No'),
                      _tableContent(
                          title: 'Popularity', content: '${movie.popularity}'),
                      _tableContent(title: 'Status', content: movie.status),
                      _tableContent(
                          title: 'Budget', content: '${movie.budget}'),
                      _tableContent(
                          title: 'Revenue', content: '${movie.revenue}'),
                      _tableContent(
                          title: 'TagLine', content: '${movie.tagline}'),
                    ],
                  ),
                ),
                _content(title: 'Trailer', body: Container())
              ],
            );
          }

          return Container();
        }),
      );
}
