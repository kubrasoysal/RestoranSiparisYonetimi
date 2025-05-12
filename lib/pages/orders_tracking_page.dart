import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrdersTrackingPage extends StatelessWidget {
  const OrdersTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return const Center(child: Text("Giriş yapmanız gerekiyor."));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sipariş Takibi"),
        backgroundColor: Colors.deepOrange,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('userId', isEqualTo: currentUser.uid)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final orders = snapshot.data!.docs;

          if (orders.isEmpty) {
            return const Center(child: Text("Hiç sipariş bulunamadı."));
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final data = orders[index].data() as Map<String, dynamic>;
              final total = data['total'];
              final status = data['status'];
              final time = (data['timestamp'] as Timestamp).toDate();

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.receipt_long),
                  title: Text("Tutar: ${total.toStringAsFixed(2)} ₺"),
                  subtitle: Text("Durum: ${status.toString().toUpperCase()}"),
                  trailing: Text(
                    "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}",
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
