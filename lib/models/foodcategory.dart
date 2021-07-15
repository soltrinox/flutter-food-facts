import 'package:foodfacts/models/fooddetails.dart';
import 'package:foodfacts/models/fooditem.dart';

class FoodCategory {
  String categoryName;
  List<FoodItem> foodItems;

  FoodCategory({
    required this.categoryName,
    required this.foodItems,
  });

  void updateFoodItemImage(String foodItemId, String image) {
    int index = foodItems.indexWhere((fi) => fi.foodId == foodItemId);
    if (index != -1) {
      foodItems[index].imageBase64 = image;
    }
  }

  FoodDetails? updateFoodDetails(
      String foodItemId, Map<String, dynamic>? foodDetailsMap) {
    int index = foodItems.indexWhere((fi) => fi.foodId == foodItemId);
    FoodDetails? foodDetails;
    if (index != -1) {
      FoodDetails fd = FoodDetails(
        vegetarian: foodDetailsMap!['vegetarian'],
        vegan: foodDetailsMap['vegan'],
        glutenFree: foodDetailsMap["glutenFree"],
        dairyFree: foodDetailsMap["dairyFree"],
        veryHealthy: foodDetailsMap["veryHealthy"],
        cheap: foodDetailsMap["cheap"],
        veryPopular: foodDetailsMap["veryPopular"],
        sustainable: foodDetailsMap["sustainable"],
        healthScore: foodDetailsMap["healthScore"],
      );
      foodItems[index].foodDetails = fd;
      foodDetails = fd;
    }
    return foodDetails;
  }
}
