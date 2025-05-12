import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get totalPrice => _items.fold(0.0, (sum, item) => sum + item.price);

  void addToCart(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  Future<void> submitOrder() async {
    print("🟢 submitOrder çağrıldı");

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("⚠️ Kullanıcı yok, sipariş yazılamaz");
      return;
    }

    final orderData = {
      'userId': user.uid, 
      'products': _items.map((item) => {
        'name': item.name,
        'price': item.price,
        'imagePath': item.imagePath ?? ''
      }).toList(),
      'total': totalPrice,
      'timestamp': Timestamp.now(),
      'status': 'alındı',
    };

    await FirebaseFirestore.instance.collection('orders').add(orderData);
    print("✅ Sipariş Firestore'a yazıldı");

    clearCart();
  }
}
