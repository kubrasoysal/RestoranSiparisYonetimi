import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems = cart.items;

    return Scaffold(
      appBar: AppBar(title: const Text("Sepet"), backgroundColor: Colors.orange),
      body: cartItems.isEmpty
          ? const Center(child: Text("Sepetiniz boş."))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return ListTile(
                        leading: Image.asset(item.imagePath ?? '', width: 50, errorBuilder: (_, __, ___) => const Icon(Icons.image)),
                        title: Text(item.name),
                        subtitle: Text("${item.price} ₺"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            cart.removeFromCart(item);
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text("Toplam: ${cart.totalPrice.toStringAsFixed(2)} ₺"),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/payment', arguments: {
                            'items': cartItems.map((item) => {
                                  'name': item.name,
                                  'price': item.price,
                                  'imagePath': item.imagePath
                                }).toList(),
                            'total': cart.totalPrice,
                          });
                        },
                        child: const Text("Siparişi Ver"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
