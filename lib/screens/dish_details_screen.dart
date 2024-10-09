import 'package:flutter/material.dart';
import 'package:campushaat/models/food_items.dart';

class DishDetailScreen extends StatelessWidget {
  final FoodItem dish;

  const DishDetailScreen({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(dish.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: height < width
                  ? EdgeInsets.only(left: 300, right: 300)
                  : EdgeInsets.zero,
              child: Hero(
                tag: dish.id,
                child: Image.network(
                  dish.mediaUrls.first,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dish.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  if (dish.info.isNotEmpty)
                    Row(
                      children: [
                        const SizedBox(width: 4),
                        const Icon(Icons.info_outline, size: 16),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            dish.info,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  _buildPriceInfo(),
                  const SizedBox(height: 16),
                  _buildPreparationInfo(),
                  const SizedBox(height: 16),
                  _buildQuantityInfo(),
                  const SizedBox(height: 16),
                  _buildSellerInfo(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.attach_money),
            Text('Price Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        Text('  Original Price: ₹${dish.productPricing.originalPrice}'),
        Text('  Discounted Price: ₹${dish.productPricing.price}'),
        Text('  Discount: ${dish.productPricing.off}% off'),
        Text(
            '  Price per ${dish.productPricing.quantity} ${dish.productPricing.unit}: ${dish.productPricing.priceText}'),
      ],
    );
  }

  Widget _buildPreparationInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timelapse),
            const Text('Preparation Time',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        Text('  ${dish.productPreparationTime} minutes'),
      ],
    );
  }

  Widget _buildQuantityInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Quantity Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('  Available Quantity: ${dish.productQuantity}'),
        Text('  Total Orders: ${dish.orderTotal}'),
        Text('  Total Quantity Ordered: ${dish.orderQuantityTotal}'),
      ],
    );
  }

  Widget _buildSellerInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Seller Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(dish.productSoldBy.creatorImageUrl),
              radius: 30,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dish.productSoldBy.creatorName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Seller ID: ${dish.productSoldBy.id}'),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }
}
