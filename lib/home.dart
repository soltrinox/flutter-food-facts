import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodfacts/constants.dart';
import 'package:foodfacts/models/foodcategory.dart';
import 'package:foodfacts/models/fooditem.dart';
import 'package:foodfacts/screens/food_details.dart';
import 'package:foodfacts/widgets/food_details_widget.dart';
import 'package:foodfacts/widgets/foodcard.dart';
import 'package:provider/provider.dart';
import './services/foodish_provider.dart';
import './widgets/header_widget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  Widget _buildListWidget(FoodCategory foodsCategories, bool largeScreen) {
    String currentCategory =
        Provider.of<FoodishProvider>(context).getCategories()[currentIndex];

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: kIsWeb ? Constants.kPadding : 0),
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: HeaderWidget(_changeCategory),
              ),
              Expanded(
                flex: 2,
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Constants.kPadding),
                  itemCount: foodsCategories.foodItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) => FoodCard(
                    category: currentCategory,
                    foodItem: foodsCategories.foodItems[index],
                    callback: largeScreen ? _changeFoodWidget : null,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  int currentIndex = 0;
  FoodDetailsWidget? currentFoodDetail;
  FoodItem? currentFoodItem;

  _changeCategory(int index) {
    FoodishProvider foodishProvider =
        Provider.of<FoodishProvider>(context, listen: false);
    setState(() {
      currentIndex = index;
      currentFoodItem =
          foodishProvider.getFoodByCategory(currentIndex).foodItems.first;
    });
  }

  _changeFoodWidget(String foodId) {
    FoodishProvider foodishProvider =
        Provider.of<FoodishProvider>(context, listen: false);
    FoodItem foodItem = foodishProvider
        .getFoodByCategory(currentIndex)
        .foodItems
        .where((fi) => fi.foodId == foodId)
        .first;
    setState(() {
      currentFoodItem = foodItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollBarController = ScrollController();
    Size _size = MediaQuery.of(context).size;
    FoodishProvider foodishProvider =
        Provider.of<FoodishProvider>(context, listen: false);
    FoodCategory foodCategory = foodishProvider.getFoodByCategory(currentIndex);
    currentFoodItem ??= foodCategory.foodItems.first;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      body: Scrollbar(
        controller: _scrollBarController,
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth < Constants.iphoneLimit) {
            return _buildListWidget(foodCategory, false);
          } else {
            return Row(
              children: [
                Expanded(
                    flex: _size.width < Constants.ipadLimit ? 5 : 4,
                    child: _buildListWidget(foodCategory, true)),
                Expanded(
                  flex: _size.width < Constants.ipadLimit ? 5 : 6,
                  child: FoodDetails(currentFoodItem!),
                )
              ],
            );
          }
        }),
      ),
    );
  }
}
