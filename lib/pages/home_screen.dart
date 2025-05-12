import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../pages/orders_history_page.dart';
import '../main.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _slugify(String input) {
    return input
        .toLowerCase()
        .replaceAll(" ", "_")
        .replaceAll("ı", "i")
        .replaceAll("ö", "o")
        .replaceAll("ü", "u")
        .replaceAll("ş", "s")
        .replaceAll("ç", "c")
        .replaceAll("ğ", "g");
  }

  double _calculateTotal(List<dynamic> allProducts) {
    return allProducts.fold(0.0, (sum, product) => sum + (product['fiyat'] ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
    'Hoş geldin, ${FirebaseAuth.instance.currentUser?.email ?? 'kullanıcı'}',
    style: const TextStyle(fontSize: 16),
  ),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Çıkış Yap',
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const AuthWrapper()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('menu').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final menuDocs = snapshot.data!.docs;
          final List<Widget> widgets = [];
          double totalSum = 0;

          for (var doc in menuDocs) {
            final data = doc.data() as Map<String, dynamic>;
            final kategori = data['kategori'] ?? 'Kategori';
            final products = data['products'] as List<dynamic>;

            totalSum += _calculateTotal(products);

            widgets.add(
              ExpansionTile(
                title: Text(
                  kategori,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                children: products.map((product) {
                  final name = product['ad'];
                  final price = product['fiyat'];
                  final imagePath = 'assets/images/${_slugify(kategori)}/${_slugify(name)}.jpg';

                  return Card(
                    color: const Color(0xFFFFF2EE),
                    child: ListTile(
                      leading: Image.asset(
                        imagePath,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.broken_image);
                        },
                      ),
                      title: Text(name),
                      subtitle: Text("$price ₺"),
                      trailing: const Icon(Icons.add_shopping_cart),
                    ),
                  );
                }).toList(),
              ),
            );
          }

          widgets.add(
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Toplam Tutar: ${totalSum.toStringAsFixed(2)} ₺",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          );

          return ListView(children: widgets);
        },
      ),
    );
  }
}
