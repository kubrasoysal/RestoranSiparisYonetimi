import '../menu_data.dart';
import 'package:flutter/material.dart';
import 'cart_page.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/cart_item.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gastrovia Menü'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: menuData.length,
        itemBuilder: (context, index) {
          final kategori = menuData[index];
          final kategoriAdi = kategori['kategori'];
          final urunler = kategori['products'];

          return ExpansionTile(
            title: Text(
              kategoriAdi,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            children: urunler.map<Widget>((urun) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 4,
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      urun['gorsel'],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(urun['ad'] ?? ''),
                  subtitle: Text('${urun['fiyat']} ₺'),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      cart.addToCart(
                        CartItem(
                          name: urun['ad'],
                          price: urun['fiyat'],
                          imagePath: urun['gorsel'],
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${urun['ad']} sepete eklendi!")),
                      );
                    },
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}