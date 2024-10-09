import 'package:campushaat/models/food_items.dart';
import 'package:flutter/material.dart';

class PlaceOrderScreen extends StatefulWidget {
  PlaceOrderScreen({super.key, required this.food, required this.foodItems});
  final Map<String, int> food;
  final List<FoodItem> foodItems;

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Place Order'),
      ),
      body: ListView(
        children: [
          for (var entry in widget.food.entries)
            ListTile(
              title: Text(
                '${widget.foodItems.firstWhere((element) => element.id == entry.key).title} x ${entry.value}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  '₹${widget.foodItems.firstWhere((element) => element.id == entry.key).productPricing.price * entry.value}'),
              trailing: const Icon(Icons.delete),
              onTap: () {
                setState(() {
                  widget.food.remove(entry.key);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${entry.value} removed from cart'),
                  ),
                );
              },
            ),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Order placed successfully'),
                ),
              );
            },
            icon: const Icon(Icons.food_bank),
            label: const Text('Place Order'),
          ),
        ],
      ),
    );
  }
}
