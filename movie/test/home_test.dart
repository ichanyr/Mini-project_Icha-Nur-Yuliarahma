import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/view/screens/home_screen.dart';

void main() {
  testWidgets(
      'Mengecek apakah pada halaman homescreen terdapat iconbutton logout...',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Find the IconButton widget using its icon (Icons.logout)
    final logoutIconButton = find.byIcon(Icons.logout);

    // Expect to find the IconButton
    expect(logoutIconButton, findsOneWidget);
  });
}
