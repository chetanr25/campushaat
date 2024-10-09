import 'package:campushaat/models/food_items.dart';
import 'package:campushaat/screens/dish_details_screen.dart';
import 'package:flutter/material.dart';

class FoodItemCard extends StatefulWidget {
  final FoodItem item;
  final Map<String, int> foodAdded;
  final void Function(FoodItem item, {bool remove}) addToCart;
  const FoodItemCard(
      {super.key,
      required this.item,
      required this.addToCart,
      required this.foodAdded});

  @override
  State<FoodItemCard> createState() => _FoodItemCardState();
}

class _FoodItemCardState extends State<FoodItemCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return DishDetailScreen(dish: widget.item);
          }));
        },
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Text(
                  '${widget.item.productPricing.off.toStringAsFixed(0)}% off',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Hero(
                          tag: widget.item.id,
                          child: Image.network(
                            widget.item.mediaUrls.first,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // CachedNetworkImage(
                        //   imageUrl: item.mediaUrls.toString(),
                        //   placeholder: (context, url) =>
                        //       CircularProgressIndicator(),
                        //   errorWidget: (context, url, error) => Icon(Icons.error),
                        //   width: 80,
                        //   height: 80,
                        //   fit: BoxFit.cover,
                        // ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 1),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: const Row(
                              children: [
                                Icon(Icons.star, color: Colors.blue, size: 12),
                                SizedBox(width: 1),
                                Text(
                                  '4.5',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.item.title,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.item.info,
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[600]),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.timelapse),
                            Text(
                              '${widget.item.productPreparationTime} mins',
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(children: [
                              Text(
                                '₹${widget.item.productPricing.originalPrice.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 20,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '₹${widget.item.productPricing.price.toStringAsFixed(0)}',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            ]),
                            if (!widget.foodAdded.containsKey(widget.item.id))
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  side: const BorderSide(
                                      color: Colors.blue,
                                      width: 1,
                                      style: BorderStyle.solid),
                                ),
                                onPressed: () {
                                  setState(() {
                                    widget.addToCart(widget.item);
                                  });
                                },
                                child: const Text('Add'),
                              ),
                            if (widget.foodAdded.containsKey(widget.item.id))
                              GestureDetector(
                                onLongPress: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Removed ${widget.item.title} from cart'),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                  setState(() {
                                    widget.foodAdded.remove(widget.item.id);
                                  });
                                  widget.addToCart(widget.item, remove: true);
                                },
                                child: ElevatedButton(
                                  onPressed: () {
                                    // showDialog(
                                    //     context: context,
                                    //     builder: (context) {
                                    //       return AlertDialog(
                                    //         title: Text('Add more items'),
                                    //         content: TextField(
                                    //           keyboardType: TextInputType.number,
                                    //           decoration: InputDecoration(
                                    //             hintText: 'Enter quantity',
                                    //           ),
                                    //         ),
                                    //         actions: [
                                    //           TextButton(
                                    //               onPressed: () {
                                    //                 Navigator.of(context).pop();
                                    //               },
                                    //               child: Text('Cancel')),
                                    //           TextButton(
                                    //               onPressed: () {
                                    //                 Navigator.of(context).pop();
                                    //               },
                                    //               child: Text('Add')),
                                    //         ],
                                    //       );
                                    //     });
                                    // },
                                    // ),
                                    setState(() {
                                      widget.addToCart(widget.item);
                                    });
                                  },
                                  child: Text(
                                    widget.foodAdded[widget.item.id].toString(),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(width: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
