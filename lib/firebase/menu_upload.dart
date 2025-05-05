import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> menuVerileriniFirestoreaYukle() async {
  final firestore = FirebaseFirestore.instance;

  final List<Map<String, dynamic>> kategoriler = [
    {
      "name": "Ana Yemek",
      "products": [
        {"name": "Et Döner", "price": 535},
        {"name": "Döner Beyti Sarma", "price": 545},
        {"name": "Tereyağlı İskender", "price": 560},
        {"name": "Pilav Üstü Döner", "price": 550},
        {"name": "SSK Dürüm Döner", "price": 560},
      ],
    },
    {
      "name": "Izgaralar",
      "products": [
        {"name": "Patlıcan Kebap", "price": 610},
        {"name": "Special Kebap", "price": 570},
        {"name": "Beyti Sarma", "price": 560},
        {"name": "Tavuk Pirzola", "price": 540},
        {"name": "Izgara Köfte", "price": 550},
      ],
    },
    {
      "name": "Fırın",
      "products": [
        {"name": "Kuşbaşılı Pide", "price": 540},
        {"name": "Karışık Pide", "price": 550},
        {"name": "Kaşarlı Pide", "price": 470},
        {"name": "Kıymalı Pide", "price": 490},
        {"name": "Lahmacun", "price": 170},
      ],
    },
    {
      "name": "Kahvaltılıklar",
      "products": [
        {"name": "Kahvaltı Tabağı", "price": 450},
        {"name": "Serpme Kahvaltı", "price": 600},
        {"name": "Menemen", "price": 200},
        {"name": "Kuymak", "price": 250},
        {"name": "Yumurta", "price": 130},
      ],
    },
    {
      "name": "Aparatifler",
      "products": [
        {"name": "Çiğköfte", "price": 140},
        {"name": "Soğan Halkası", "price": 130},
        {"name": "Patates Kızartması", "price": 140},
        {"name": "Börek Çeşitleri", "price": 140},
        {"name": "Salata Çeşitleri", "price": 120},
      ],
    },
    {
      "name": "İçecekler",
      "products": [
        {"name": "Kola", "price": 85},
        {"name": "Fanta", "price": 85},
        {"name": "Sprite", "price": 85},
        {"name": "Fuse Tea", "price": 85},
        {"name": "Ayran", "price": 75},
        {"name": "Su", "price": 30},
      ],
    },
  ];

  for (var kategori in kategoriler) {
    await firestore.collection("menu").add(kategori);
  }

  print("🔥 Menü Firestore'a yüklendi!");
}
