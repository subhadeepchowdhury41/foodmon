// Define the CartItem class
class CartItem {
  final String itemName;
  final double price;
  int totolQuantity;
  int quantity;

  CartItem({
    required this.itemName,
    required this.price,
    required this.totolQuantity,
    this.quantity = 0,
  });

  // Copy constructor to create a new instance with updated values
  CartItem copyWith({
    String? itemName,
    double? price,
    int? totolQuantity,
    int? quantity,
  }) {
    return CartItem(
      itemName: itemName ?? this.itemName,
      price: price ?? this.price,
      totolQuantity: totolQuantity ?? this.totolQuantity,
      quantity: quantity ?? this.quantity,
    );
  }
}
