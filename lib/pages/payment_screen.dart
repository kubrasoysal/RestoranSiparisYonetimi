import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class PaymentScreen extends StatelessWidget {
  final List<CartItem> items;
  final double total;
  final VoidCallback onPaymentSuccess;

  const PaymentScreen({
    super.key,
    required this.items,
    required this.total,
    required this.onPaymentSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ödeme")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Toplam ödeme: ${total.toStringAsFixed(2)} ₺",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.credit_card),
              label: const Text("Ödemeyi Tamamla"),
              onPressed: () {
                // Simüle edilmiş ödeme
                onPaymentSuccess();
              },
            )
          ],
        ),
      ),
    );
  }
}
