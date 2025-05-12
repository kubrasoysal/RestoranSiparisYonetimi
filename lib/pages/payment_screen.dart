import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  final List<Map<String, dynamic>> items;
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
      appBar: AppBar(
        title: const Text("Ödeme Ekranı"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Toplam Tutar: ${total.toStringAsFixed(2)} ₺",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text("Kart Bilgileri (Demo)", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: "Kart Numarası")),
            const SizedBox(height: 8),
            const TextField(decoration: InputDecoration(labelText: "Son Kullanma Tarihi")),
            const SizedBox(height: 8),
            const TextField(decoration: InputDecoration(labelText: "CVV"), obscureText: true),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            const Text("Sipariş Özeti:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    title: Text(item['name']),
                    subtitle: Text("${item['price']} ₺"),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check_circle),
                label: const Text("Ödemeyi Tamamla"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  onPaymentSuccess();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("✅ Ödeme başarılı, sipariş verildi!")),
                  );
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
