class CartItem {
  final String name;
  final double price;
  final String? imagePath;

  CartItem({
    required this.name,
    required this.price,
    this.imagePath,
  });
}
