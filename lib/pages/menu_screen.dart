import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/cart_item.dart';
import 'cart_page.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gastrovia Menü"),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartPage()),
              );
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('menu').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final menuDocs = snapshot.data!.docs;
          final List<Widget> widgets = [];

          for (var doc in menuDocs) {
            final data = doc.data() as Map<String, dynamic>;
            final kategori = data['kategori'] ?? 'Kategori';
            final products = data['products'] as List<dynamic>;

            widgets.add(
              ExpansionTile(
                title: Text(
                  kategori,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                children: products.map((product) {
                  final name = product['ad'];
                  final price = (product['fiyat'] as num).toDouble();
                  final imagePath = 'assets/images/${_slugify(kategori)}/${_slugify(name)}.jpg';

                  return Card(
                    color: const Color(0xFFFFF2EE),
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          imagePath,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.broken_image);
                          },
                        ),
                      ),
                      title: Text(name),
                      subtitle: Text("$price ₺"),
                      trailing: IconButton(
                        icon: const Icon(Icons.add_shopping_cart, color: Colors.orange),
                        onPressed: () {
                          cartProvider.addToCart(
                            CartItem(name: name, price: price, imagePath: imagePath),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("$name sepete eklendi!")),
                          );
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }

          return ListView(children: widgets);
        },
      ),
    );
  }
}
