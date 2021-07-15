import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodfacts/models/fooditem.dart';

enum FoodItemType {
  boolType,
  stringType,
  numberType,
}

class FoodItemTileWidget extends StatelessWidget {
  final String name;
  final IconData icon;
  final FoodItemType type;
  final dynamic value;

  const FoodItemTileWidget({
    required this.icon,
    required this.name,
    required this.type,
    required this.value,
  });

  Widget _getWidgetFromType() {
    const styleText = const TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green);
    switch (type) {
      case FoodItemType.boolType:
        {
          final boolValue = value as bool;
          return boolValue
              ? const Text(
                  "YES",
                  style: styleText,
                )
              : const Text(
                  "NO",
                  style: styleText,
                );
        }
      case FoodItemType.stringType:
        {
          final txtValue = value as String;
          return Text(txtValue, style: styleText);
        }
      case FoodItemType.numberType:
        {
          final numValue = value as double;
          return Text(
            numValue.toString(),
            style: styleText,
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Icon(
              icon,
              size: 40.0,
            ),
            const SizedBox(height: 10.0),
            Text(
              name,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
            const SizedBox(height: 10.0),
            _getWidgetFromType()
          ],
        ),
      ),
    );
  }
}
