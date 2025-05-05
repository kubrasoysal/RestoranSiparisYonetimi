import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gastrovia_v2/main.dart';

void main() {
  testWidgets('Ana sayfa kategori testi', (WidgetTester tester) async {
    // Uygulamayı başlat
    await tester.pumpWidget(const MyApp());

    // Giriş yaptıktan sonra ana sayfa veya menü görünmeli.
    // Menüde 'Ana Yemek' başlığı olup olmadığını kontrol et
    expect(find.text('Ana Yemek'), findsOneWidget);
  });
}
