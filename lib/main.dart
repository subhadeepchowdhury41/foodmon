import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodmon/screens/cart_screen.dart';
import 'package:foodmon/screens/search_screen.dart';
import 'package:foodmon/widgets/ui/filled_icon_button.dart';

void main() {
  runApp(const ProviderScope(child: Foodmon()));
}

class Foodmon extends StatefulWidget {
  const Foodmon({super.key});

  @override
  State<Foodmon> createState() => _FoodmonState();
}

class _FoodmonState extends State<Foodmon> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodmon',
      debugShowCheckedModeBanner: false,
      home: CartScreen(),
      // home: SearchScreen(),
    );
  }
}
