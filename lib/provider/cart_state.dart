import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodmon/provider/cart_model.dart';
import 'package:state_notifier/state_notifier.dart';

// Define the CartState class extending StateNotifier
class CartState extends StateNotifier<List<CartItem>> {
  CartState() : super([]);

  void initialize() async {
    List<CartItem> items = [
      CartItem(
          itemName: 'Chicken Crunch Burger', price: 209, totolQuantity: 10),
      CartItem(itemName: 'Chicken Slab Burger', price: 259, totolQuantity: 20),
      CartItem(itemName: 'Donut Header Chicken', price: 199, totolQuantity: 5),
      CartItem(
          itemName: 'Mighty Chicken Patty Burger',
          price: 209,
          totolQuantity: 2),
      CartItem(
          itemName: 'Chicken Crunch Burger', price: 209, totolQuantity: 10),
      CartItem(itemName: 'Chicken Slab Burger', price: 259, totolQuantity: 20),
      CartItem(itemName: 'Donut Header Chicken', price: 199, totolQuantity: 5),
      CartItem(
          itemName: 'Mighty Chicken Patty Burger',
          price: 209,
          totolQuantity: 2),
    ];
    state = items;
  }

  // Add an item to the cart
  void addItem(CartItem item) {
    state = [...state, item];
  }

  // Remove an item from the cart
  void removeItem(CartItem item) {
    state = state.where((cartItem) => cartItem != item).toList();
  }

  // Update the quantity of an item in the cart
  void updateQuantity(CartItem item, int newQuantity) {
    state = [
      for (var cartItem in state)
        if (cartItem == item &&
            newQuantity >= 0 &&
            newQuantity <= cartItem.totolQuantity)
          cartItem.copyWith(quantity: newQuantity)
        else
          cartItem
    ];
  }

  List<CartItem> searchList(String pattern) {
    return state
        .where((element) =>
            element.itemName.toLowerCase().contains(pattern.toLowerCase()))
        .toList();
  }

  // Get the total cost of items in the cart
  double get totalCost {
    double total = 0.0;
    for (var item in state) {
      total += item.price * item.quantity;
    }
    return total;
  }
}

final cartProvider = StateNotifierProvider<CartState, List<CartItem>>((ref) {
  return CartState();
});
