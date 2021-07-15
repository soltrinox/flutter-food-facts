import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodfacts/constants.dart';
import 'package:foodfacts/models/fooditem.dart';
import 'package:foodfacts/widgets/foodimage.dart';

class FoodCard extends StatefulWidget {
  final ValueChanged<String>? callback;
  final String category;
  final FoodItem foodItem;

  const FoodCard({
    required this.category,
    required this.foodItem,
    this.callback,
  });

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: const Offset(4, 4),
            blurRadius: 5,
            color: Colors.black.withOpacity(0.2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(Constants.kPadding / 3),
            child: Text(
              widget.foodItem.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
          Expanded(
            child: FoodImage(
                category: widget.category,
                foodItem: widget.foodItem,
                callback: widget.callback),
          )
        ],
      ),
    );
  }
}
