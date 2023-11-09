// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/view/screens/login_screen.dart';

void main() {
  testWidgets('Cek tombol login', (WidgetTester tester) async {
    // final SemanticsHandle handle = tester.ensureSemantics();

    await tester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    // Mengecek tombol login
    final loginButton = find.widgetWithText(ElevatedButton,
        'Login'); // Gantilah RaisedButton dengan jenis tombol yang Anda gunakan dan 'Login' dengan teks tombol And
    expect(loginButton, findsOneWidget);

    // Mengecek apakah gambar login.jpg ada di dalam widget Image
    final imageFinder = find.byWidgetPredicate((widget) {
      if (widget is Image && widget.image is AssetImage) {
        final assetImage = widget.image as AssetImage;
        return assetImage.assetName == 'assets/images/login.jpg';
      }
      return false;
    });

    // Mengecek apakah gambar login.jpg ada di dalam widget LoginScreen
    expect(imageFinder, findsOneWidget);

    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    // // Build our app and trigger a frame.
    // handle.dispose();
    // await tester.pumpWidget(MyApp());

    // // Verify that our counter starts at 0.
    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);

    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}
