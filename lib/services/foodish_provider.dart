import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodfacts/constants.dart';
import 'package:foodfacts/models/foodcategory.dart';
import 'package:foodfacts/models/fooddetails.dart';
import 'package:foodfacts/models/fooditem.dart';
import 'package:http/http.dart' as http;

class FoodishProvider with ChangeNotifier {
  final List<FoodCategory> _foodsCategories = [];

  final List<String> _categories = ["BURGERS", "PIZZA", "RICE", "PASTA"];

  FoodishProvider() {
    _buildInitialFood();
  }

  void _buildInitialFood() {
    List<FoodItem> burgerItems = [
      FoodItem(
        name: 'Falafel Burger',
        foodId: '642539',
        // imageUrl: 'https://spoonacular.com/recipeImages/642539-312x231.png',
        imageUrl: 'assets/images/642539-312x231.png',
      ),
      FoodItem(
        name: 'Tex-Mex Burger',
        foodId: '663050',
        imageUrl: "assets/images/663050-312x231.jpeg",
      ),
      FoodItem(
        name: 'The Unagi Burger',
        foodId: '663357',
        imageUrl: "assets/images/663357-312x231.jpeg",
      ),
      FoodItem(
        name: 'Little Italy Burger',
        foodId: '650181',
        imageUrl: "assets/images/650181-312x231.jpeg",
      ),
      FoodItem(
        name: 'The Benedict Burger',
        foodId: '663209',
        imageUrl: "assets/images/663209-312x231.jpeg",
      ),
    ];

    _foodsCategories.add(
      FoodCategory(categoryName: "BURGERS", foodItems: burgerItems),
    );

    List<FoodItem> pizzaItems = [
      FoodItem(
        name: 'Pizza bites with pumpkin',
        foodId: '656329',
        imageUrl: 'assets/images/656329-312x231.jpeg',
      ),
      FoodItem(
        name: 'BLT Pizza',
        foodId: '680975',
        imageUrl: 'assets/images/680975-312x231.jpeg',
      ),
      FoodItem(
        name: 'Thai Pizza',
        foodId: '663136',
        imageUrl: 'assets/images/663136-312x231.jpeg',
      ),
      FoodItem(
        name: 'Plantain Pizza',
        foodId: '716300',
        imageUrl: 'assets/images/716300-312x231.jpeg',
      ),
      FoodItem(
        name: 'Pepperoni Pizza Muffins',
        foodId: '655698',
        imageUrl: 'assets/images/655698-312x231.jpeg',
      ),
    ];

    _foodsCategories.add(
      FoodCategory(categoryName: "PIZZA", foodItems: pizzaItems),
    );

    List<FoodItem> riceItems = [
      FoodItem(
        name: 'Rice Pilaf',
        foodId: '658277',
        imageUrl: 'assets/images/658277-312x231.jpeg',
      ),
      FoodItem(
        name: 'Rice Pudding',
        foodId: '658276',
        imageUrl: 'assets/images/658276-312x231.jpeg',
      ),
      FoodItem(
        name: 'Rice with Fried Egg',
        foodId: '658290',
        imageUrl: 'assets/images/658290-312x231.jpeg',
      ),
      FoodItem(
        name: 'Rice and Peas Curry',
        foodId: '716364',
        imageUrl: 'assets/images/716364-312x231.jpeg',
      ),
    ];

    _foodsCategories
        .add(FoodCategory(categoryName: "RICE", foodItems: riceItems));

    List<FoodItem> pastaItems = [
      FoodItem(
        name: 'Pasta With Tuna',
        foodId: '654959',
        imageUrl: 'assets/images/654959-312x231.jpeg',
      ),
      FoodItem(
        name: 'Pasta Margherita',
        foodId: '511728',
        imageUrl: 'assets/images/511728-312x231.jpeg',
      ),
      FoodItem(
        name: 'Pasta and Seafood',
        foodId: '654812',
        imageUrl: 'assets/images/654812-312x231.jpeg',
      ),
      FoodItem(
        name: 'Pasta On The Border',
        foodId: '654857',
        imageUrl: 'assets/images/654857-312x231.jpeg',
      ),
      FoodItem(
        name: 'Pasta Vegetable Soup',
        foodId: '654883',
        imageUrl: 'assets/images/654883-312x231.jpeg',
      ),
    ];

    _foodsCategories
        .add(FoodCategory(categoryName: "PASTA", foodItems: pastaItems));
  }

  List<String> getCategories() {
    return _categories;
  }

  FoodCategory getFoodByCategory(int categoryIndex) {
    return _foodsCategories
        .where((fd) => fd.categoryName == _categories[categoryIndex])
        .toList()[0];
  }

  List<FoodCategory> getInitialFoods() {
    return _foodsCategories;
  }

  Future<String> getImageLocationFromFood(
      String foodName, String foodId) async {
    FoodItem foodItem = await getFoodItemFromCategory(foodName, foodId);
    return foodItem.image;
  }

  Future<FoodItem> getFoodDetails(String categoryId, String foodId) async {
    int index =
        _foodsCategories.indexWhere((cat) => cat.categoryName == categoryId);
    FoodItem foodItem = _foodsCategories[index]
        .foodItems
        .where((fi) => fi.foodId == foodId)
        .first;

    //  FoodItem foodItem = await getFoodItemFromCategory(categoryId, foodId);

    if (!foodItem.hasDetails()) {
      var foodDetailsUrl =
          'https://api.spoonacular.com/recipes/$foodId/information?apiKey=$Constants.apiKey';
      final response = await http.get(Uri.parse(foodDetailsUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic>? reponseBody = json.decode(response.body);
        updateFoodItemDetails(categoryId, foodId, reponseBody);
        notifyListeners();
      }
    }
    return foodItem;
  }

  FoodDetails? updateFoodItemDetails(
      String category, String foodId, Map<String, dynamic>? foodDetails) {
    int index =
        _foodsCategories.indexWhere((cat) => cat.categoryName == category);
    FoodDetails? ret;
    if (index != -1) {
      ret = _foodsCategories[index].updateFoodDetails(foodId, foodDetails);
    }
    return ret;
  }

  void updateFoodImageFromCategory(
      String category, String foodId, String image) {
    int index =
        _foodsCategories.indexWhere((cat) => cat.categoryName == category);

    if (index != -1) {
      _foodsCategories[index].updateFoodItemImage(foodId, image);
    }
  }

  Future<FoodItem> getFoodItemFromCategory(
      String category, String foodId) async {
    int index =
        _foodsCategories.indexWhere((cat) => cat.categoryName == category);
    FoodItem foodItem = _foodsCategories[index]
        .foodItems
        .where((fi) => fi.foodId == foodId)
        .first;

    return foodItem;
  }
}
