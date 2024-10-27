class CartItem {
  final String imagePath;
  final String title;
  final String description;
  final double price;
  int quantity;

  CartItem({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.price,
    this.quantity = 1,
  });
}
