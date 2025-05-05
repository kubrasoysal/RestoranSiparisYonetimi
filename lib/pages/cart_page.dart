import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_item.dart';
import '../providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  Future<void> placeOrder(BuildContext context, List<CartItem> items, double total) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sipariş verebilmek için giriş yapmalısınız.")),
      );
      return;
    }

    final orderData = {
      'email': user.email,
      'items': items.map((item) => {
        'name': item.name,
        'price': item.price,
      }).toList(),
      'total': total,
      'timestamp': Timestamp.now(),
    };

    await FirebaseFirestore.instance.collection('orders').add(orderData);

    Provider.of<CartProvider>(context, listen: false).clearCart();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Sipariş başarıyla verildi!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = cart.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sepetim'),
        backgroundColor: Colors.orange,
      ),
      body: items.isEmpty
          ? const Center(child: Text('Sepetiniz boş.'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 3,
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              item.imagePath ?? 'assets/images/default.jpg',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(item.name),
                          subtitle: Text('${item.price} ₺'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => cart.removeFromCart(item),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.orange.shade100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Toplam:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('${cart.totalPrice.toStringAsFixed(2)} ₺', style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton.icon(
                    onPressed: () => placeOrder(context, items, cart.totalPrice.toDouble()),
                    icon: const Icon(Icons.check_circle),
                    label: const Text("Siparişi Ver"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
