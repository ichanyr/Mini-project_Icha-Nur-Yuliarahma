import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/view/screens/detail_movie_screen.dart';

void main() {
  testWidgets('DetailMovieScreen contains "Discover Movies"',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: DetailMovieScreen(id: 1),
    ));

    expect(find.text('Discover Movies'), findsOneWidget);
  });
}
