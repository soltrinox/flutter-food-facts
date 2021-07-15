import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodfacts/models/fooditem.dart';
import 'package:foodfacts/widgets/food_details_header_widget.dart';
import 'package:foodfacts/widgets/food_details_widget.dart';
import 'package:provider/provider.dart';

import '../services/foodish_provider.dart';

class FoodDetails extends StatefulWidget {
  static const routeName = '/food-details';

  FoodItem foodItem;

  FoodDetails(this.foodItem);

  @override
  _FoodDetailsState createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  Future<FoodItem> _loadDetails(String categoryName, String foodId) async {
    FoodishProvider foodishProvider =
        Provider.of<FoodishProvider>(context, listen: false);
    FoodItem localFoodItem =
        await foodishProvider.getFoodDetails(categoryName, foodId);

    return localFoodItem;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget _generateDetailsWidget(BuildContext context, FoodItem? foodItem) {
    final foodDetails = FoodDetailsWidget(foodItem);
    final headerContent = FoodDetailsHeaderWidget(foodItem);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(flex: 1, child: headerContent),
          Expanded(flex: 2, child: foodDetails)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _generateDetailsWidget(context, widget.foodItem);
  }
}
