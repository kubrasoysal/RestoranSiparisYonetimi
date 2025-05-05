class CartItem {
  final String name;
  final int price;
  final String? imagePath;

  CartItem({
    required this.name,
    required this.price,
    this.imagePath,
  });
}
