import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminOrdersPage extends StatelessWidget {
  const AdminOrdersPage({super.key});

  final List<String> statusOptions = const [
    'alındı',
    'hazırlanıyor',
    'yola çıktı',
    'teslim edildi',
  ];

  void updateStatus(String orderId, String newStatus) {
    FirebaseFirestore.instance.collection('orders').doc(orderId).update({
      'status': newStatus,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Siparişleri Yönet'),
        backgroundColor: Colors.orange,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final orders = snapshot.data!.docs;

          if (orders.isEmpty) {
            return const Center(child: Text("Hiç sipariş bulunmamaktadır."));
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final doc = orders[index];
              final data = doc.data() as Map<String, dynamic>;

              final products = data['products'] as List<dynamic>;
              final total = data['total'];
              final status = data['status'];
              final timestamp = (data['timestamp'] as Timestamp).toDate();

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ExpansionTile(
                  title: Text(
                    "Toplam: ${total.toStringAsFixed(2)} ₺ - Durum: ${status.toUpperCase()}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      "Tarih: ${timestamp.day}.${timestamp.month}.${timestamp.year} - ${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}"),
                  children: [
                    ...products.map((item) => ListTile(
                          title: Text(item['name']),
                          subtitle: Text("${item['price']} ₺"),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: DropdownButtonFormField<String>(
                        value: status,
                        decoration: const InputDecoration(labelText: "Durumu Güncelle"),
                        items: statusOptions
                            .map((status) => DropdownMenuItem(
                                  value: status,
                                  child: Text(status.toUpperCase()),
                                ))
                            .toList(),
                        onChanged: (newStatus) {
                          if (newStatus != null) {
                            updateStatus(doc.id, newStatus);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
