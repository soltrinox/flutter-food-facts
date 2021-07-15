import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodfacts/constants.dart';
import 'package:foodfacts/models/fooditem.dart';

class FoodDetailsHeaderWidget extends StatelessWidget {
  final FoodItem? foodItem;

  const FoodDetailsHeaderWidget(this.foodItem);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final textHeaderContent = Column(
      children: [
        //  const SizedBox(height: 10.0),
        const Icon(
          Icons.fastfood,
          color: Colors.white,
          size: 40.0,
        ),
        Container(
          width: 90.0,
          child: const Divider(color: Colors.green),
        ),
        Text(
          foodItem!.name,
          style: const TextStyle(color: Colors.white, fontSize: 25.0),
        ),
      ],
    );

    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(foodItem!.imageUrl), fit: BoxFit.cover),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(45),
          width: size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.9),
          ),
          child: textHeaderContent,
        ),
        if (size.width < Constants.ipadLimit) ...{
          Positioned(
            left: 8.0,
            top: 65.0,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
            ),
          )
        }
      ],
    );
  }
}
