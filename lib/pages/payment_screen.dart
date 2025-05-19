import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'orders_history_page.dart';

class PaymentScreen extends StatefulWidget {
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
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String deliveryAddress = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ödeme Ekranı"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Toplam Tutar: ${widget.total.toStringAsFixed(2)} ₺",
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

            TextField(
              decoration: const InputDecoration(
                labelText: "Teslimat Adresi",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  deliveryAddress = value;
                });
              },
            ),

            const SizedBox(height: 24),
            const Text("Sipariş Özeti:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            Expanded(
              child: ListView.builder(
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  final item = widget.items[index];
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
                onPressed: () async {
                  try {
                    print("📦 Sipariş Firestore’a gönderiliyor...");

                    final user = FirebaseAuth.instance.currentUser;
                    if (user == null) {
                      print("❌ Giriş yapan kullanıcı bulunamadı.");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Giriş yapılmamış. Sipariş verilemedi.")),
                      );
                      return;
                    }

                    final orderData = {
                      'userId': user.uid,
                      'items': widget.items,
                      'total': widget.total,
                      'status': 'Alındı',
                      'address': deliveryAddress,
                      'createdAt': Timestamp.now(),
                    };

                    print("🧾 Sipariş verisi: $orderData");

                    await FirebaseFirestore.instance.collection('orders').add(orderData);
                    print("✅ Sipariş başarıyla yazıldı.");

                    widget.onPaymentSuccess();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("✅ Ödeme başarılı, sipariş verildi!")),
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const OrdersHistoryPage()),
                    );
                  } catch (e) {
                    print("❌ Firestore yazma hatası: $e");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Hata oluştu: $e")),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}