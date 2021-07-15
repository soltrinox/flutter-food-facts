import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodfacts/constants.dart';
import 'package:foodfacts/models/fooddetailsarguments.dart';
import 'package:foodfacts/models/fooditem.dart';
import '../services/foodish_provider.dart';
import 'package:foodfacts/screens/food_details.dart';
import 'package:provider/provider.dart';

class FoodImage extends StatefulWidget {
  final String category;
  final FoodItem foodItem;
  final ValueChanged<String>? callback;

  const FoodImage({
    required this.category,
    required this.foodItem,
    this.callback,
  });
  @override
  State<FoodImage> createState() => _FoodImageState();
}

class _FoodImageState extends State<FoodImage> {
  var _loading = false;
  String strImageBas64 = '';

  _loadImageFromFood() async {
    FoodishProvider foodishProvider =
        Provider.of<FoodishProvider>(context, listen: false);
    String foodImgByt = await foodishProvider.getImageLocationFromFood(
        widget.category, widget.foodItem.foodId);
    if (mounted) {
      setState(() {
        _loading = true;
        strImageBas64 = foodImgByt;
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (!_loading) {
      _loadImageFromFood();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.topCenter,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => {
          if (widget.callback == null)
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodDetails(widget.foodItem),
                ),
              )
            }
          else
            {widget.callback!(widget.foodItem.foodId)}
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(300.0),
          child: Hero(
            tag: 'icon-${widget.foodItem.foodId}',
            child: _loading == false
                ? Container(
                    height: Constants.standarSize,
                    width: Constants.standarSize,
                    child: const CircularProgressIndicator())
                : MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Image.asset(
                      widget.foodItem.imageUrl,
                      fit: BoxFit.fill,
                      height: Constants.standarSize,
                      width: Constants.standarSize,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
