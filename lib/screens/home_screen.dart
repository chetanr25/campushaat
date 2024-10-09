import 'package:campushaat/models/food_items.dart';
import 'package:campushaat/screens/place_order_screen.dart';
import 'package:campushaat/widgets/FoodLoadingScreen.dart';
import 'package:campushaat/widgets/food_item_card.dart';
import 'package:campushaat/widgets/noFood_error_screen.dart';
import 'package:flutter/material.dart';
import 'package:campushaat/services/api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FoodListScreen extends StatefulWidget {
  @override
  _FoodListScreenState createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  final ProductService _productService = ProductService();
  List<FoodItem> foodItems = [];
  bool isLoading = false;
  bool hasError = false;
  String errorMessage = '';
  int currentPage = 0;
  final int itemsPerPage = 10;

  Map<String, int> foodAdded = {};

  void _addToCart(FoodItem item, {bool remove = false}) {
    print(foodItems.map((e) => e.id).toList());
    if (remove) {
      if (foodAdded.containsKey(item.id)) {
        if (foodAdded[item.id]! > 1) {
          setState(() {
            foodAdded[item.id] = foodAdded[item.id]! - 1;
          });
        } else {
          setState(() {
            foodAdded.remove(item.id);
          });
        }
      }
      return;
    }
    if (foodAdded.containsKey(item.id)) {
      foodAdded[item.id] = foodAdded[item.id]! + 1;
    } else {
      foodAdded[item.id] = 1;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadMoreItems();
  }

  Future<void> _loadMoreItems() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      List<FoodItem> newItems = await _productService.fetchProducts(
        apiKey: dotenv.env['API_KEY'].toString(),
        start: currentPage * itemsPerPage,
        limit: itemsPerPage,
      );

      setState(() {
        foodItems.addAll(newItems);
        currentPage++;
        isLoading = false;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            isLoading = false;
          });
        });
        // isLoading = false;
        hasError = true;
        errorMessage = 'Failed to load products. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: foodAdded.length != 0
          ? SafeArea(
              child: Container(
                constraints: const BoxConstraints(maxHeight: 1000),
                // color: const Color.fromARGB(139, 33, 149, 243),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            foodAdded.clear();
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('All items removed from cart'),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.delete_forever_outlined,
                          size: 30,
                        )),
                    Text('${foodAdded.length} items',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    ElevatedButton.icon(
                      iconAlignment: IconAlignment.end,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlaceOrderScreen(
                                food: foodAdded, foodItems: foodItems),
                          ),
                        );
                      },
                      icon: const Icon(Icons.food_bank, size: 30),
                      label: const Text('Place Order'),
                    ),
                  ],
                ),
              ),
            )
          : null,
      appBar: AppBar(
        title: const Text('Food Items'),
      ),
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    var itemWidth = MediaQuery.of(context).size.width;
    var itemHeight = MediaQuery.of(context).size.height;
    if (isLoading && foodItems.isEmpty) {
      return AnimatedFoodLoading();
    } else if (foodItems.isEmpty) {
      return NoFoodFound();
    } else {
      return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels >
              scrollInfo.metrics.maxScrollExtent / 2) {
            _loadMoreItems();
          }
          return true;
        },
        child: itemHeight < itemWidth
            ? GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: (itemWidth / itemHeight - 0.3),
                  crossAxisCount: 2,
                ),
                itemCount: foodItems.length + (isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < foodItems.length) {
                    return FoodItemCard(
                      item: foodItems[index],
                      addToCart: _addToCart,
                      foodAdded: foodAdded,
                    );
                  } else if (isLoading) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  if (index < foodItems.length) {
                    return FoodItemCard(
                      item: foodItems[index],
                      addToCart: _addToCart,
                      foodAdded: foodAdded,
                    );
                  } else if (isLoading) {
                    if (errorMessage != '') {
                      return Container(
                        alignment: Alignment.center,
                        height: 70,
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 4),
                          curve: Curves.easeInOut,
                          child: const Text(
                            "You have reached end of the list",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const SizedBox.shrink();
                  }
                },
                itemCount: foodItems.length + (isLoading ? 1 : 0),
              ),
      );
    }
  }
}
