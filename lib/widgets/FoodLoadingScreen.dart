import 'package:flutter/material.dart';

class AnimatedFoodLoading extends StatefulWidget {
  @override
  _AnimatedFoodLoadingState createState() => _AnimatedFoodLoadingState();
}

class _AnimatedFoodLoadingState extends State<AnimatedFoodLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: _animation,
            child: Icon(Icons.restaurant_menu, size: 100, color: Colors.orange),
          ),
          const Text('Loading delicious home made food...',
              style: TextStyle(fontSize: 18)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
