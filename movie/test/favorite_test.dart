import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/view/screens/fav_screen.dart';

void main() {
  testWidgets('Test if "Favorite Movies" text is present on FavoriteScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: FavoriteScreen()));

    // Find the "Favorite Movies" text
    final favoriteMoviesText = find.text('Favorite Movies');

    // Expect to find the "Favorite Movies" text
    expect(favoriteMoviesText, findsOneWidget);
  });
}
