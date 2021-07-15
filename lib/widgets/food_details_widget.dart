import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodfacts/constants.dart';
import 'package:foodfacts/models/fooditem.dart';
import 'package:foodfacts/widgets/fooditem_tile_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodDetailsWidget extends StatelessWidget {
  final FoodItem? foodItem;

  const FoodDetailsWidget(this.foodItem);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sizeImage = size.width < 900 ? 75.0 : 150;
    double fontSize = size.width < 900 ? 12 : 20;
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'icon-${foodItem!.foodId}',
              child: Image.asset(
                foodItem!.imageUrl,
                width: sizeImage,
                height: sizeImage,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: Constants.kPadding / 2),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        Constants.dummyText,
                        style:
                            TextStyle(fontSize: fontSize, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
