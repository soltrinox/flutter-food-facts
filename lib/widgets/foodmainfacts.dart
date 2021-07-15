import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodfacts/models/fooddetails.dart';
import 'package:foodfacts/models/fooditem.dart';

class FoodMainFacts extends StatelessWidget {
  FoodItem foodItem;

  FoodMainFacts(this.foodItem);

  Widget _buildSwitchItem(String name, bool value) {
    return Row(
      children: [
        Text(name),
        DecoratedBox(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: MaterialButton(
              minWidth: 70.0,
              onPressed: null,
              color: Colors.grey,
              child: Text(
                value ? "YES" : "NO",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[
            _buildSwitchItem("Veg", foodItem.foodDetails!.vegetarian),
            _buildSwitchItem("Gl", foodItem.foodDetails!.glutenFree),
            _buildSwitchItem("Ch", foodItem.foodDetails!.glutenFree),
          ],
        ),
      ),
    );
  }
}
