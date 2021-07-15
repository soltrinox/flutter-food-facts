import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodfacts/models/foodcategory.dart';
import 'package:foodfacts/widgets/foodcard.dart';


class FoodListWidget extends StatefulWidget {
  final FoodCategory foodCategory;
  const FoodListWidget(this.foodCategory);

  @override
  _FoodListWidgetState createState() => _FoodListWidgetState();
}

class _FoodListWidgetState extends State<FoodListWidget> {
  Widget _getWidgetFromElement() {
    if (kIsWeb) {
      return Expanded(
        child: GridView.count(
          crossAxisCount: 4,
          children: widget.foodCategory.foodItems
              .map(
                (e) => FoodCard(
                  category: widget.foodCategory.categoryName,
                  foodItem: e,
                ),
              )
              .toList(),
        ),
      );
    } else {
      return Expanded(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.foodCategory.foodItems.length,
          itemBuilder: (context, index) {
            return FoodCard(
              category: widget.foodCategory.categoryName,
              foodItem: widget.foodCategory.foodItems[index],
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kIsWeb ? 720 : 390,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 40, left: 20),
            child: Text(
              widget.foodCategory.categoryName.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          _getWidgetFromElement()
        ],
      ),
    );
  }
}
